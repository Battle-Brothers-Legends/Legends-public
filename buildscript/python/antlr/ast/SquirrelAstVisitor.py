from antlr4 import InputStream, CommonTokenStream

from antlr import SquirrelParser, SquirrelLexer
from antlr.ast.Comments import Comments
from antlr.SquirrelParserVisitor import SquirrelParserVisitor
from antlr.ast.SquirrelNode import Span
from antlr.ast.nodes import *


# todo, it should be possible to reuse it to make code generator
# todo there's possibility to use @singledispatch

class SquirrelAstVisitor(SquirrelParserVisitor):
    @classmethod
    def parse(cls, code):
        stream = CommonTokenStream(SquirrelLexer(InputStream(code)))
        parser = SquirrelParser(stream)

        tree = parser.program()
        visitor = SquirrelAstVisitor()

        tree = visitor.visit(tree)
        cls._link_parents(tree)
        return tree

    @classmethod
    def parseComments(cls, code):
        stream = CommonTokenStream(SquirrelLexer(InputStream(code)))
        stream.fill()
        comment_map = {}
        for token in stream.tokens:
            if token.channel == 1:  # HIDDEN channel
                comment_map[token.line] = token.text.strip()
        return Comments(comment_map)

    @classmethod
    def _link_parents(cls, node: SquirrelNode, parent: Optional[SquirrelNode] = None) -> None:
        """Recursively links all child nodes back to their parent."""
        if node is None:
            return

        # Set the parent pointer (if it's an AST node)
        if isinstance(node, SquirrelNode):
            node.parent = parent

            # Iterate over all fields of the dataclass
            for field_name, value in node.__dict__.items():
                if field_name == "parent" or field_name == "span":
                    continue

                if isinstance(value, list):
                    for item in value:
                        if isinstance(item, SquirrelNode):
                            cls._link_parents(item, node)
                elif isinstance(value, SquirrelNode):
                    cls._link_parents(value, node)

    def visit(self, tree):
        result = super().visit(tree)
        if isinstance(result, SquirrelNode) and result.span is None:
            result.span = Span.from_ctx(tree)
        return result

    def tryVisit(self, tree):
        if tree is None:
            return None
        return self.visit(tree)

    def tryVisitArray(self, tree):
        if tree is None:
            return []
        return self.visit(tree)

    def visitErrorNode(self, node):
        print(node)

    def visitProgram(self, ctx: SquirrelParser.ProgramContext):
        return Program(self.visit(ctx.statements()))

    def visitStatements(self, ctx: SquirrelParser.StatementsContext):
        return [self.visit(statement) for statement in ctx.statement()] # flatten

    def visitStatement(self, ctx: SquirrelParser.StatementContext):
        return self.visit(ctx.statementBody())  # flatten

    def visitStatementBody(self, ctx: SquirrelParser.StatementBodyContext):
        return self.visit(ctx.getChild(0))

    def visitStatementBlock(self, ctx: SquirrelParser.StatementBlockContext):
        return StatementBlock([self.visit(s) for s in ctx.statements().statement()])

    def visitIfStatement(self, ctx: SquirrelParser.IfStatementContext):
        return IfStatement(self.visit(ctx.expression()), self.visit(ctx.statement(0)), self.tryVisit(ctx.statement(1)))

    def visitWhileStatement(self, ctx: SquirrelParser.WhileStatementContext):
        return WhileStatement(self.visit(ctx.expression()), self.visit(ctx.statement()))

    def visitDoWhileStatement(self, ctx: SquirrelParser.DoWhileStatementContext):
        return DoWhileStatement(self.visit(ctx.expression()), self.visit(ctx.statement()))

    def visitSwitchStatement(self, ctx: SquirrelParser.SwitchStatementContext):
        return SwitchStatement(self.visit(ctx.expression()), [self.visit(c) for c in ctx.switchCase()], self.tryVisit(ctx.defaultCase()))

    def visitSwitchCase(self, ctx:SquirrelParser.SwitchCaseContext):
        return SwitchCase(self.visit(ctx.expression()), [self.visit(c) for c in ctx.statements().statement()])

    def visitDefaultCase(self, ctx:SquirrelParser.DefaultCaseContext):
        return DefaultCase([self.visit(c) for c in ctx.statements()])

    def visitForStatement(self, ctx:SquirrelParser.ForStatementContext):
        return ForStatement(
            self.visit(ctx.forStat),
            self.tryVisit(ctx.forInit),
            self.tryVisit(ctx.forCondition),
            self.tryVisit(ctx.forUpdate)
        )

    def visitForeachStatement(self, ctx:SquirrelParser.ForeachStatementContext):
        return ForeachStatement(self.visit(ctx.foreachVar()), self.visit(ctx.expression()), self.visit(ctx.statement()))

    def visitKeyOnlyVar(self, ctx:SquirrelParser.KeyOnlyVarContext):
        return KeyOnlyVar(ctx.Identifier().getText())

    def visitKeyValVar(self, ctx:SquirrelParser.KeyValVarContext):
        return KeyValVar(ctx.Identifier(0).getText(), ctx.Identifier(1).getText())

    def visitBreakStatement(self, ctx:SquirrelParser.BreakStatementContext):
        return BreakStatement()

    def visitContinueStatement(self, ctx:SquirrelParser.ContinueStatementContext):
        return ContinueStatement()

    def visitReturnStatement(self, ctx:SquirrelParser.ReturnStatementContext):
        return ReturnStatement(self.visit(ctx.expression()))

    def visitYieldStatement(self, ctx:SquirrelParser.YieldStatementContext):
        return YieldStatement(self.visit(ctx.expression()))

    def visitFunctionDeclareEnd(self, ctx:SquirrelParser.FunctionDeclareEndContext):
        return self.tryVisit(ctx.args()), self.visit(ctx.statement())

    def visitLocalDeclare(self, ctx:SquirrelParser.LocalDeclareContext):
        if ctx.funcname():
            args, statement = self.visit(ctx.functionDeclareEnd())
            return LocalFunction(self.visit(ctx.funcname()), statement, args)
        return LocalVariable(self.visit(ctx.inits()))

    def visitInits(self, ctx:SquirrelParser.InitsContext):
        return [self.visit(i) for i in ctx.init()] # flatten

    def visitInit(self, ctx:SquirrelParser.InitContext):
        return Init(ctx.Identifier().getText(), self.tryVisit(ctx.expression()))

    def visitTryCatch(self, ctx:SquirrelParser.TryCatchContext):
        return TryCatch(self.visit(ctx.statement(0)), self.tryVisit(ctx.Identifier()), self.visit(ctx.statement(1)))

    def visitThrowStatement(self, ctx:SquirrelParser.ThrowStatementContext):
        return ThrowStatement(self.visit(ctx.expression()))

    def visitConstStatement(self, ctx:SquirrelParser.ConstStatementContext):
        return ConstStatement(ctx.Identifier().getText(), self.visit(ctx.constValue()))

    def visitStringLiteral(self, ctx:SquirrelParser.StringLiteralContext):
        return ctx.StringLiteral().getText().strip('"')

    def visitIdentifier(self, ctx:SquirrelParser.IdentifierContext):
        if name:=ctx.Identifier():
            name = name.getText()
        return Identifier(name)

    def visitFuncname(self, ctx:SquirrelParser.FuncnameContext):
        return Funcname([i.getText() for i in ctx.Identifier()])

    def visitNewslot(self, ctx:SquirrelParser.NewslotContext):
        return Newslot(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitAssignOp(self, ctx:SquirrelParser.AssignOpContext):
        return AssignOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitMulEqualOp(self, ctx:SquirrelParser.MulEqualOpContext):
        return MulEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitDivEqualOp(self, ctx:SquirrelParser.DivEqualOpContext):
        return DivEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitModEqualOp(self, ctx:SquirrelParser.ModEqualOpContext):
        return ModEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitAddEqualOp(self, ctx:SquirrelParser.AddEqualOpContext):
        return AddEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitSubEqualOp(self, ctx:SquirrelParser.SubEqualOpContext):
        return SubEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitCloneExpression(self, ctx: SquirrelParser.CloneExpressionContext):
        return CloneExpression(self.visit(ctx.expression()))

    def visitResumeExpression(self, ctx: SquirrelParser.ResumeExpressionContext):
        return ResumeExpression(self.visit(ctx.expression()))

    def visitDeleteOperation(self, ctx: SquirrelParser.DeleteOperationContext):
        return DeleteOperation(self.visit(ctx.expression()))

    def visitUnaryMinusOp(self, ctx: SquirrelParser.UnaryMinusOpContext):
        return UnaryMinusOp(self.visit(ctx.expression()))

    def visitBitwiseNotOp(self, ctx: SquirrelParser.BitwiseNotOpContext):
        return BitwiseNotOp(self.visit(ctx.expression()))

    def visitLogicalNotOp(self, ctx: SquirrelParser.LogicalNotOpContext):
        return LogicalNotOp(self.visit(ctx.expression()))

    def visitTypeofOp(self, ctx: SquirrelParser.TypeofOpContext):
        return TypeofOp(self.visit(ctx.expression()))

    def visitPreincrementOp(self, ctx: SquirrelParser.PreincrementOpContext):
        return PreincrementOp(self.visit(ctx.expression()))

    def visitPredecrementOp(self, ctx: SquirrelParser.PredecrementOpContext):
        return PredecrementOp(self.visit(ctx.expression()))

    def visitDivideOp(self, ctx: SquirrelParser.DivideOpContext):
        return DivideOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitMultiplyOp(self, ctx: SquirrelParser.MultiplyOpContext):
        return MultiplyOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitModuloOp(self, ctx:SquirrelParser.ModuloOpContext):
        return ModuloOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitAddOp(self, ctx:SquirrelParser.AddOpContext):
        return AddOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitSubOp(self, ctx:SquirrelParser.SubOpContext):
        return SubOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitLeftShiftOp(self, ctx:SquirrelParser.LeftShiftOpContext):
        return LeftShiftOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitRightShiftOp(self, ctx:SquirrelParser.RightShiftOpContext):
        return RightShiftOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitRightUnsignedShiftOp(self, ctx:SquirrelParser.RightUnsignedShiftOpContext):
        return RightUnsignedShiftOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitLessOp(self, ctx:SquirrelParser.LessOpContext):
        return LessOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitLessEqualOp(self, ctx:SquirrelParser.LessEqualOpContext):
        return LessEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitGreaterOp(self, ctx:SquirrelParser.GreaterOpContext):
        return GreaterOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitGreaterEqualOp(self, ctx:SquirrelParser.GreaterEqualOpContext):
        return GreaterEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitEqualOp(self, ctx:SquirrelParser.EqualOpContext):
        return EqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitNotEqualOp(self, ctx:SquirrelParser.NotEqualOpContext):
        return NotEqualOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitCompareOp(self, ctx:SquirrelParser.CompareOpContext):
        return CompareOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitBitwiseAndOp(self, ctx:SquirrelParser.BitwiseAndOpContext):
        return BitwiseAndOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitBitwiseXOROp(self, ctx:SquirrelParser.BitwiseXOROpContext):
        return BitwiseXOROp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitBitwiseOrOp(self, ctx:SquirrelParser.BitwiseOrOpContext):
        return BitwiseOrOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitLogicalAndOp(self, ctx:SquirrelParser.LogicalAndOpContext):
        return LogicalAndOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitLogicalOrOp(self, ctx:SquirrelParser.LogicalOrOpContext):
        return LogicalOrOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitInOp(self, ctx:SquirrelParser.InOpContext):
        return InOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitInstanceofOp(self, ctx:SquirrelParser.InstanceofOpContext):
        return InstanceofOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitTernaryOp(self, ctx:SquirrelParser.TernaryOpContext):
        return TernaryOp(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)), self.visit(ctx.expression(2)))

    def visitPostincrementOp(self, ctx:SquirrelParser.PostincrementOpContext):
        return PostincrementOp(self.visit(ctx.expression()))

    def visitPostdecrementOp(self, ctx:SquirrelParser.PostdecrementOpContext):
        return PostdecrementOp(self.visit(ctx.expression()))

    def visitScopeAccess(self, ctx:SquirrelParser.ScopeAccessContext):
        return ScopeAccess(ctx.Identifier().getText())

    def visitDotAccess(self, ctx:SquirrelParser.DotAccessContext):
        return DotAccess(self.visit(ctx.expression()), ctx.Identifier().getText())

    def visitIndexAccess(self, ctx:SquirrelParser.IndexAccessContext):
        return IndexAccess(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitLiteralExpression(self, ctx:SquirrelParser.LiteralExpressionContext):
        return self.visit(ctx.literal())

    def visitParenExpression(self, ctx:SquirrelParser.ParenExpressionContext):
        return ParenExpression(self.visit(ctx.expression()))

    def visitTableConstructionExpr(self, ctx:SquirrelParser.TableConstructionExprContext):
        return self.visit(ctx.tableConstruction()) # flatten

    def visitLambda(self, ctx:SquirrelParser.LambdaContext):
        return Lambda(self.visit(ctx.expression()), self.tryVisit(ctx.args()))

    def visitExpressionList(self, ctx:SquirrelParser.ExpressionListContext):
        return [self.visit(e) for e in ctx.expression()]

    def visitArrayConstruction(self, ctx:SquirrelParser.ArrayConstructionContext):
        return ArrayConstruction(self.tryVisitArray(ctx.expressionList()))

    def visitBaseExpression(self, ctx:SquirrelParser.BaseExpressionContext):
        return BaseExpression(ctx.Identifier().getText(), self.tryVisitArray(ctx.expressionList()))

    def visitFunctionCall(self, ctx:SquirrelParser.FunctionCallContext):
        return FunctionCall(self.visit(ctx.expression()), self.tryVisitArray(ctx.expressionList()))

    def visitBasicTableSlot(self, ctx:SquirrelParser.BasicTableSlotContext):
        return BasicTableSlot(ctx.Identifier().getText(), self.visit(ctx.expression()))

    def visitArrayTableSlot(self, ctx:SquirrelParser.ArrayTableSlotContext):
        return ArrayTableSlot(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)))

    def visitJsonTableSlot(self, ctx:SquirrelParser.JsonTableSlotContext):
        return JsonTableSlot(self.visit(ctx.stringLiteral()), self.visit(ctx.expression()))

    def visitTableSlot(self, ctx:SquirrelParser.TableSlotContext):
        if slot := ctx.basicTableSlot():
            return self.visit(slot)
        if slot := ctx.arrayTableSlot():
            return self.visit(slot)
        if slot := ctx.jsonTableSlot():
            return self.visit(slot)
        args, statement = self.visit(ctx.functionDeclareEnd())
        return FunctionTableSlot(ctx.funcname(), statement, args)

    def visitTableConstruction(self, ctx:SquirrelParser.TableConstructionContext):
        return TableConstruction([self.visit(slot) for slot in ctx.tableSlot()])

    def visitArg(self, ctx:SquirrelParser.ArgContext):
        return Arg(ctx.Identifier().getText(), self.tryVisit(ctx.expression()))

    def visitArgs(self, ctx:SquirrelParser.ArgsContext):
        return Args([self.visit(arg) for arg in ctx.arg()], ctx.VARARGS() is not None)

    def visitFunctionDeclare(self, ctx:SquirrelParser.FunctionDeclareContext):
        args, statement = self.visit(ctx.functionDeclareEnd())
        return FunctionDeclare(self.visit(ctx.funcname()), statement, args)

    def visitAnonymousFunction(self, ctx:SquirrelParser.AnonymousFunctionContext):
        args, statement = self.visit(ctx.functionDeclareEnd())
        return AnonymousFunction(statement, args)

    def visitIndexAssign(self, ctx:SquirrelParser.IndexAssignContext):
        return IndexAssign(self.visit(ctx.expression(0)), self.visit(ctx.expression(1)), self.visit(ctx.expression(2)))

    def visitConstValue(self, ctx: SquirrelParser.ConstValueContext):
        if ctx.IntegerLiteral():
            val = int(ctx.IntegerLiteral().getText(), 0)
            if ctx.MINUS():
                val = -val
            return IntegerLiteral(value=val)

        elif ctx.FloatLiteral():
            return FloatLiteral(value=float(ctx.FloatLiteral().getText()))

        elif ctx.stringLiteral():
            return StringLiteral(value=self.visit(ctx.stringLiteral()))

        raise ValueError(f"Unknown constValue context: {ctx.getText()}")

    def visitClassName(self, ctx:SquirrelParser.ClassNameContext):
        return ClassName([c.getText() for c in ctx.Identifier()])

    def visitLiteral(self, ctx: SquirrelParser.LiteralContext):
        if ctx.IntegerLiteral():
            return IntegerLiteral(value=int(ctx.IntegerLiteral().getText(), 0))
        elif ctx.FloatLiteral():
            return FloatLiteral(value=float(ctx.FloatLiteral().getText()))
        elif ctx.BooleanLiteral():
            return BooleanLiteral(value=ctx.BooleanLiteral().getText().lower() == "true")
        elif ctx.stringLiteral():
            return StringLiteral(value=self.visit(ctx.stringLiteral()))
        elif ctx.NULL():
            return NullLiteral()
        elif ctx.THIS():
            return ThisLiteral()

        raise ValueError(f"Unknown literal context: {ctx.getText()}")

    def visitEnumerations(self, ctx:SquirrelParser.EnumerationsContext):
        return Enumeration(ctx.Identifier().getText(), self.visit(ctx.constValue()))

    def visitEnumStatement(self, ctx:SquirrelParser.EnumStatementContext):
        return EnumStatement(ctx.Identifier().getText(), [self.visit(e) for e in ctx.enumerations()])

    def visitTerminal(self, node):
        token_text = node.getText()
        token_type = node.symbol.type if hasattr(node, "symbol") else "UNKNOWN"
        print(f"[DEBUG Terminal] token={repr(token_text)} type={token_type}")
        return super().visitTerminal(node)