# Generated from grammars/SquirrelParser.g4 by ANTLR 4.13.2
from antlr4 import *
if "." in __name__:
    from .SquirrelParser import SquirrelParser
else:
    from SquirrelParser import SquirrelParser

# This class defines a complete generic visitor for a parse tree produced by SquirrelParser.

class SquirrelParserVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by SquirrelParser#program.
    def visitProgram(self, ctx:SquirrelParser.ProgramContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#statements.
    def visitStatements(self, ctx:SquirrelParser.StatementsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#statement.
    def visitStatement(self, ctx:SquirrelParser.StatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#statementBody.
    def visitStatementBody(self, ctx:SquirrelParser.StatementBodyContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#statementBlock.
    def visitStatementBlock(self, ctx:SquirrelParser.StatementBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#ifStatement.
    def visitIfStatement(self, ctx:SquirrelParser.IfStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#whileStatement.
    def visitWhileStatement(self, ctx:SquirrelParser.WhileStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#doWhileStatement.
    def visitDoWhileStatement(self, ctx:SquirrelParser.DoWhileStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#switchStatement.
    def visitSwitchStatement(self, ctx:SquirrelParser.SwitchStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#switchCase.
    def visitSwitchCase(self, ctx:SquirrelParser.SwitchCaseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#defaultCase.
    def visitDefaultCase(self, ctx:SquirrelParser.DefaultCaseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#forStatement.
    def visitForStatement(self, ctx:SquirrelParser.ForStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#foreachStatement.
    def visitForeachStatement(self, ctx:SquirrelParser.ForeachStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#keyOnlyVar.
    def visitKeyOnlyVar(self, ctx:SquirrelParser.KeyOnlyVarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#keyValVar.
    def visitKeyValVar(self, ctx:SquirrelParser.KeyValVarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#breakStatement.
    def visitBreakStatement(self, ctx:SquirrelParser.BreakStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#continueStatement.
    def visitContinueStatement(self, ctx:SquirrelParser.ContinueStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#returnStatement.
    def visitReturnStatement(self, ctx:SquirrelParser.ReturnStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#yieldStatement.
    def visitYieldStatement(self, ctx:SquirrelParser.YieldStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#localDeclare.
    def visitLocalDeclare(self, ctx:SquirrelParser.LocalDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#classDeclare.
    def visitClassDeclare(self, ctx:SquirrelParser.ClassDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#className.
    def visitClassName(self, ctx:SquirrelParser.ClassNameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#tryCatch.
    def visitTryCatch(self, ctx:SquirrelParser.TryCatchContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#throwStatement.
    def visitThrowStatement(self, ctx:SquirrelParser.ThrowStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#constStatement.
    def visitConstStatement(self, ctx:SquirrelParser.ConstStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#stringLiteral.
    def visitStringLiteral(self, ctx:SquirrelParser.StringLiteralContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#constValue.
    def visitConstValue(self, ctx:SquirrelParser.ConstValueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#indexAssign.
    def visitIndexAssign(self, ctx:SquirrelParser.IndexAssignContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#enumStatement.
    def visitEnumStatement(self, ctx:SquirrelParser.EnumStatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#enumerations.
    def visitEnumerations(self, ctx:SquirrelParser.EnumerationsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#memberStaticDeclare.
    def visitMemberStaticDeclare(self, ctx:SquirrelParser.MemberStaticDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#memberArrayDeclare.
    def visitMemberArrayDeclare(self, ctx:SquirrelParser.MemberArrayDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#memberFunctionDeclare.
    def visitMemberFunctionDeclare(self, ctx:SquirrelParser.MemberFunctionDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#memberConstructorDeclare.
    def visitMemberConstructorDeclare(self, ctx:SquirrelParser.MemberConstructorDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#inits.
    def visitInits(self, ctx:SquirrelParser.InitsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#init.
    def visitInit(self, ctx:SquirrelParser.InitContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#args.
    def visitArgs(self, ctx:SquirrelParser.ArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#arg.
    def visitArg(self, ctx:SquirrelParser.ArgContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#funcname.
    def visitFuncname(self, ctx:SquirrelParser.FuncnameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#literal.
    def visitLiteral(self, ctx:SquirrelParser.LiteralContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#tableConstructionExpr.
    def visitTableConstructionExpr(self, ctx:SquirrelParser.TableConstructionExprContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#preincrementOp.
    def visitPreincrementOp(self, ctx:SquirrelParser.PreincrementOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#lessEqualOp.
    def visitLessEqualOp(self, ctx:SquirrelParser.LessEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#divideOp.
    def visitDivideOp(self, ctx:SquirrelParser.DivideOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#moduloOp.
    def visitModuloOp(self, ctx:SquirrelParser.ModuloOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#resumeExpression.
    def visitResumeExpression(self, ctx:SquirrelParser.ResumeExpressionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#lambda.
    def visitLambda(self, ctx:SquirrelParser.LambdaContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#logicalAndOp.
    def visitLogicalAndOp(self, ctx:SquirrelParser.LogicalAndOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#logicalOrOp.
    def visitLogicalOrOp(self, ctx:SquirrelParser.LogicalOrOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#newslot.
    def visitNewslot(self, ctx:SquirrelParser.NewslotContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#arrayConstruction.
    def visitArrayConstruction(self, ctx:SquirrelParser.ArrayConstructionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#rightShiftOp.
    def visitRightShiftOp(self, ctx:SquirrelParser.RightShiftOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#postdecrementOp.
    def visitPostdecrementOp(self, ctx:SquirrelParser.PostdecrementOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#unaryMinusOp.
    def visitUnaryMinusOp(self, ctx:SquirrelParser.UnaryMinusOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#identifier.
    def visitIdentifier(self, ctx:SquirrelParser.IdentifierContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#notEqualOp.
    def visitNotEqualOp(self, ctx:SquirrelParser.NotEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#subEqualOp.
    def visitSubEqualOp(self, ctx:SquirrelParser.SubEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#postincrementOp.
    def visitPostincrementOp(self, ctx:SquirrelParser.PostincrementOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#baseExpression.
    def visitBaseExpression(self, ctx:SquirrelParser.BaseExpressionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#bitwiseAndOp.
    def visitBitwiseAndOp(self, ctx:SquirrelParser.BitwiseAndOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#leftShiftOp.
    def visitLeftShiftOp(self, ctx:SquirrelParser.LeftShiftOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#rightUnsignedShiftOp.
    def visitRightUnsignedShiftOp(self, ctx:SquirrelParser.RightUnsignedShiftOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#dotAccess.
    def visitDotAccess(self, ctx:SquirrelParser.DotAccessContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#indexAccess.
    def visitIndexAccess(self, ctx:SquirrelParser.IndexAccessContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#modEqualOp.
    def visitModEqualOp(self, ctx:SquirrelParser.ModEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#functionCall.
    def visitFunctionCall(self, ctx:SquirrelParser.FunctionCallContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#instanceofOp.
    def visitInstanceofOp(self, ctx:SquirrelParser.InstanceofOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#greaterEqualOp.
    def visitGreaterEqualOp(self, ctx:SquirrelParser.GreaterEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#ternaryOp.
    def visitTernaryOp(self, ctx:SquirrelParser.TernaryOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#cloneExpression.
    def visitCloneExpression(self, ctx:SquirrelParser.CloneExpressionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#multiplyOp.
    def visitMultiplyOp(self, ctx:SquirrelParser.MultiplyOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#assignOp.
    def visitAssignOp(self, ctx:SquirrelParser.AssignOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#deleteOperation.
    def visitDeleteOperation(self, ctx:SquirrelParser.DeleteOperationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#greaterOp.
    def visitGreaterOp(self, ctx:SquirrelParser.GreaterOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#anonymousFunction.
    def visitAnonymousFunction(self, ctx:SquirrelParser.AnonymousFunctionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#subOp.
    def visitSubOp(self, ctx:SquirrelParser.SubOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#lessOp.
    def visitLessOp(self, ctx:SquirrelParser.LessOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#parenExpression.
    def visitParenExpression(self, ctx:SquirrelParser.ParenExpressionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#predecrementOp.
    def visitPredecrementOp(self, ctx:SquirrelParser.PredecrementOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#bitwiseOrOp.
    def visitBitwiseOrOp(self, ctx:SquirrelParser.BitwiseOrOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#addEqualOp.
    def visitAddEqualOp(self, ctx:SquirrelParser.AddEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#inOp.
    def visitInOp(self, ctx:SquirrelParser.InOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#mulEqualOp.
    def visitMulEqualOp(self, ctx:SquirrelParser.MulEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#logicalNotOp.
    def visitLogicalNotOp(self, ctx:SquirrelParser.LogicalNotOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#bitwiseNotOp.
    def visitBitwiseNotOp(self, ctx:SquirrelParser.BitwiseNotOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#addOp.
    def visitAddOp(self, ctx:SquirrelParser.AddOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#divEqualOp.
    def visitDivEqualOp(self, ctx:SquirrelParser.DivEqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#scopeAccess.
    def visitScopeAccess(self, ctx:SquirrelParser.ScopeAccessContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#compareOp.
    def visitCompareOp(self, ctx:SquirrelParser.CompareOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#typeofOp.
    def visitTypeofOp(self, ctx:SquirrelParser.TypeofOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#functionDeclare.
    def visitFunctionDeclare(self, ctx:SquirrelParser.FunctionDeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#bitwiseXOROp.
    def visitBitwiseXOROp(self, ctx:SquirrelParser.BitwiseXOROpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#equalOp.
    def visitEqualOp(self, ctx:SquirrelParser.EqualOpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#literalExpression.
    def visitLiteralExpression(self, ctx:SquirrelParser.LiteralExpressionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#functionDeclareEnd.
    def visitFunctionDeclareEnd(self, ctx:SquirrelParser.FunctionDeclareEndContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#tableConstruction.
    def visitTableConstruction(self, ctx:SquirrelParser.TableConstructionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#tableSlot.
    def visitTableSlot(self, ctx:SquirrelParser.TableSlotContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#basicTableSlot.
    def visitBasicTableSlot(self, ctx:SquirrelParser.BasicTableSlotContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#arrayTableSlot.
    def visitArrayTableSlot(self, ctx:SquirrelParser.ArrayTableSlotContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#jsonTableSlot.
    def visitJsonTableSlot(self, ctx:SquirrelParser.JsonTableSlotContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SquirrelParser#expressionList.
    def visitExpressionList(self, ctx:SquirrelParser.ExpressionListContext):
        return self.visitChildren(ctx)



del SquirrelParser