# Generated from SquirrelParser.g4 by ANTLR 4.13.2
from antlr4 import *
if "." in __name__:
    from .SquirrelParser import SquirrelParser
else:
    from SquirrelParser import SquirrelParser

# This class defines a complete listener for a parse tree produced by SquirrelParser.
class SquirrelParserListener(ParseTreeListener):

    # Enter a parse tree produced by SquirrelParser#program.
    def enterProgram(self, ctx:SquirrelParser.ProgramContext):
        pass

    # Exit a parse tree produced by SquirrelParser#program.
    def exitProgram(self, ctx:SquirrelParser.ProgramContext):
        pass


    # Enter a parse tree produced by SquirrelParser#statements.
    def enterStatements(self, ctx:SquirrelParser.StatementsContext):
        pass

    # Exit a parse tree produced by SquirrelParser#statements.
    def exitStatements(self, ctx:SquirrelParser.StatementsContext):
        pass


    # Enter a parse tree produced by SquirrelParser#statement.
    def enterStatement(self, ctx:SquirrelParser.StatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#statement.
    def exitStatement(self, ctx:SquirrelParser.StatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#statementBody.
    def enterStatementBody(self, ctx:SquirrelParser.StatementBodyContext):
        pass

    # Exit a parse tree produced by SquirrelParser#statementBody.
    def exitStatementBody(self, ctx:SquirrelParser.StatementBodyContext):
        pass


    # Enter a parse tree produced by SquirrelParser#statementBlock.
    def enterStatementBlock(self, ctx:SquirrelParser.StatementBlockContext):
        pass

    # Exit a parse tree produced by SquirrelParser#statementBlock.
    def exitStatementBlock(self, ctx:SquirrelParser.StatementBlockContext):
        pass


    # Enter a parse tree produced by SquirrelParser#ifStatement.
    def enterIfStatement(self, ctx:SquirrelParser.IfStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#ifStatement.
    def exitIfStatement(self, ctx:SquirrelParser.IfStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#whileStatement.
    def enterWhileStatement(self, ctx:SquirrelParser.WhileStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#whileStatement.
    def exitWhileStatement(self, ctx:SquirrelParser.WhileStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#doWhileStatement.
    def enterDoWhileStatement(self, ctx:SquirrelParser.DoWhileStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#doWhileStatement.
    def exitDoWhileStatement(self, ctx:SquirrelParser.DoWhileStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#switchStatement.
    def enterSwitchStatement(self, ctx:SquirrelParser.SwitchStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#switchStatement.
    def exitSwitchStatement(self, ctx:SquirrelParser.SwitchStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#switchCase.
    def enterSwitchCase(self, ctx:SquirrelParser.SwitchCaseContext):
        pass

    # Exit a parse tree produced by SquirrelParser#switchCase.
    def exitSwitchCase(self, ctx:SquirrelParser.SwitchCaseContext):
        pass


    # Enter a parse tree produced by SquirrelParser#defaultCase.
    def enterDefaultCase(self, ctx:SquirrelParser.DefaultCaseContext):
        pass

    # Exit a parse tree produced by SquirrelParser#defaultCase.
    def exitDefaultCase(self, ctx:SquirrelParser.DefaultCaseContext):
        pass


    # Enter a parse tree produced by SquirrelParser#forStatement.
    def enterForStatement(self, ctx:SquirrelParser.ForStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#forStatement.
    def exitForStatement(self, ctx:SquirrelParser.ForStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#foreachStatement.
    def enterForeachStatement(self, ctx:SquirrelParser.ForeachStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#foreachStatement.
    def exitForeachStatement(self, ctx:SquirrelParser.ForeachStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#keyOnlyVar.
    def enterKeyOnlyVar(self, ctx:SquirrelParser.KeyOnlyVarContext):
        pass

    # Exit a parse tree produced by SquirrelParser#keyOnlyVar.
    def exitKeyOnlyVar(self, ctx:SquirrelParser.KeyOnlyVarContext):
        pass


    # Enter a parse tree produced by SquirrelParser#keyValVar.
    def enterKeyValVar(self, ctx:SquirrelParser.KeyValVarContext):
        pass

    # Exit a parse tree produced by SquirrelParser#keyValVar.
    def exitKeyValVar(self, ctx:SquirrelParser.KeyValVarContext):
        pass


    # Enter a parse tree produced by SquirrelParser#breakStatement.
    def enterBreakStatement(self, ctx:SquirrelParser.BreakStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#breakStatement.
    def exitBreakStatement(self, ctx:SquirrelParser.BreakStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#continueStatement.
    def enterContinueStatement(self, ctx:SquirrelParser.ContinueStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#continueStatement.
    def exitContinueStatement(self, ctx:SquirrelParser.ContinueStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#returnStatement.
    def enterReturnStatement(self, ctx:SquirrelParser.ReturnStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#returnStatement.
    def exitReturnStatement(self, ctx:SquirrelParser.ReturnStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#yieldStatement.
    def enterYieldStatement(self, ctx:SquirrelParser.YieldStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#yieldStatement.
    def exitYieldStatement(self, ctx:SquirrelParser.YieldStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#localDeclare.
    def enterLocalDeclare(self, ctx:SquirrelParser.LocalDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#localDeclare.
    def exitLocalDeclare(self, ctx:SquirrelParser.LocalDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#classDeclare.
    def enterClassDeclare(self, ctx:SquirrelParser.ClassDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#classDeclare.
    def exitClassDeclare(self, ctx:SquirrelParser.ClassDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#className.
    def enterClassName(self, ctx:SquirrelParser.ClassNameContext):
        pass

    # Exit a parse tree produced by SquirrelParser#className.
    def exitClassName(self, ctx:SquirrelParser.ClassNameContext):
        pass


    # Enter a parse tree produced by SquirrelParser#tryCatch.
    def enterTryCatch(self, ctx:SquirrelParser.TryCatchContext):
        pass

    # Exit a parse tree produced by SquirrelParser#tryCatch.
    def exitTryCatch(self, ctx:SquirrelParser.TryCatchContext):
        pass


    # Enter a parse tree produced by SquirrelParser#throwStatement.
    def enterThrowStatement(self, ctx:SquirrelParser.ThrowStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#throwStatement.
    def exitThrowStatement(self, ctx:SquirrelParser.ThrowStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#constStatement.
    def enterConstStatement(self, ctx:SquirrelParser.ConstStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#constStatement.
    def exitConstStatement(self, ctx:SquirrelParser.ConstStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#constValue.
    def enterConstValue(self, ctx:SquirrelParser.ConstValueContext):
        pass

    # Exit a parse tree produced by SquirrelParser#constValue.
    def exitConstValue(self, ctx:SquirrelParser.ConstValueContext):
        pass


    # Enter a parse tree produced by SquirrelParser#indexAssign.
    def enterIndexAssign(self, ctx:SquirrelParser.IndexAssignContext):
        pass

    # Exit a parse tree produced by SquirrelParser#indexAssign.
    def exitIndexAssign(self, ctx:SquirrelParser.IndexAssignContext):
        pass


    # Enter a parse tree produced by SquirrelParser#enumStatement.
    def enterEnumStatement(self, ctx:SquirrelParser.EnumStatementContext):
        pass

    # Exit a parse tree produced by SquirrelParser#enumStatement.
    def exitEnumStatement(self, ctx:SquirrelParser.EnumStatementContext):
        pass


    # Enter a parse tree produced by SquirrelParser#enumerations.
    def enterEnumerations(self, ctx:SquirrelParser.EnumerationsContext):
        pass

    # Exit a parse tree produced by SquirrelParser#enumerations.
    def exitEnumerations(self, ctx:SquirrelParser.EnumerationsContext):
        pass


    # Enter a parse tree produced by SquirrelParser#memberStaticDeclare.
    def enterMemberStaticDeclare(self, ctx:SquirrelParser.MemberStaticDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#memberStaticDeclare.
    def exitMemberStaticDeclare(self, ctx:SquirrelParser.MemberStaticDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#memberArrayDeclare.
    def enterMemberArrayDeclare(self, ctx:SquirrelParser.MemberArrayDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#memberArrayDeclare.
    def exitMemberArrayDeclare(self, ctx:SquirrelParser.MemberArrayDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#memberFunctionDeclare.
    def enterMemberFunctionDeclare(self, ctx:SquirrelParser.MemberFunctionDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#memberFunctionDeclare.
    def exitMemberFunctionDeclare(self, ctx:SquirrelParser.MemberFunctionDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#memberConstructorDeclare.
    def enterMemberConstructorDeclare(self, ctx:SquirrelParser.MemberConstructorDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#memberConstructorDeclare.
    def exitMemberConstructorDeclare(self, ctx:SquirrelParser.MemberConstructorDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#inits.
    def enterInits(self, ctx:SquirrelParser.InitsContext):
        pass

    # Exit a parse tree produced by SquirrelParser#inits.
    def exitInits(self, ctx:SquirrelParser.InitsContext):
        pass


    # Enter a parse tree produced by SquirrelParser#init.
    def enterInit(self, ctx:SquirrelParser.InitContext):
        pass

    # Exit a parse tree produced by SquirrelParser#init.
    def exitInit(self, ctx:SquirrelParser.InitContext):
        pass


    # Enter a parse tree produced by SquirrelParser#args.
    def enterArgs(self, ctx:SquirrelParser.ArgsContext):
        pass

    # Exit a parse tree produced by SquirrelParser#args.
    def exitArgs(self, ctx:SquirrelParser.ArgsContext):
        pass


    # Enter a parse tree produced by SquirrelParser#arg.
    def enterArg(self, ctx:SquirrelParser.ArgContext):
        pass

    # Exit a parse tree produced by SquirrelParser#arg.
    def exitArg(self, ctx:SquirrelParser.ArgContext):
        pass


    # Enter a parse tree produced by SquirrelParser#funcname.
    def enterFuncname(self, ctx:SquirrelParser.FuncnameContext):
        pass

    # Exit a parse tree produced by SquirrelParser#funcname.
    def exitFuncname(self, ctx:SquirrelParser.FuncnameContext):
        pass


    # Enter a parse tree produced by SquirrelParser#literal.
    def enterLiteral(self, ctx:SquirrelParser.LiteralContext):
        pass

    # Exit a parse tree produced by SquirrelParser#literal.
    def exitLiteral(self, ctx:SquirrelParser.LiteralContext):
        pass


    # Enter a parse tree produced by SquirrelParser#preincrementOp.
    def enterPreincrementOp(self, ctx:SquirrelParser.PreincrementOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#preincrementOp.
    def exitPreincrementOp(self, ctx:SquirrelParser.PreincrementOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#lessEqualOp.
    def enterLessEqualOp(self, ctx:SquirrelParser.LessEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#lessEqualOp.
    def exitLessEqualOp(self, ctx:SquirrelParser.LessEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#divideOp.
    def enterDivideOp(self, ctx:SquirrelParser.DivideOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#divideOp.
    def exitDivideOp(self, ctx:SquirrelParser.DivideOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#moduloOp.
    def enterModuloOp(self, ctx:SquirrelParser.ModuloOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#moduloOp.
    def exitModuloOp(self, ctx:SquirrelParser.ModuloOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#resumeExpression.
    def enterResumeExpression(self, ctx:SquirrelParser.ResumeExpressionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#resumeExpression.
    def exitResumeExpression(self, ctx:SquirrelParser.ResumeExpressionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#lambda.
    def enterLambda(self, ctx:SquirrelParser.LambdaContext):
        pass

    # Exit a parse tree produced by SquirrelParser#lambda.
    def exitLambda(self, ctx:SquirrelParser.LambdaContext):
        pass


    # Enter a parse tree produced by SquirrelParser#logicalAndOp.
    def enterLogicalAndOp(self, ctx:SquirrelParser.LogicalAndOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#logicalAndOp.
    def exitLogicalAndOp(self, ctx:SquirrelParser.LogicalAndOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#logicalOrOp.
    def enterLogicalOrOp(self, ctx:SquirrelParser.LogicalOrOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#logicalOrOp.
    def exitLogicalOrOp(self, ctx:SquirrelParser.LogicalOrOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#newslot.
    def enterNewslot(self, ctx:SquirrelParser.NewslotContext):
        pass

    # Exit a parse tree produced by SquirrelParser#newslot.
    def exitNewslot(self, ctx:SquirrelParser.NewslotContext):
        pass


    # Enter a parse tree produced by SquirrelParser#arrayConstruction.
    def enterArrayConstruction(self, ctx:SquirrelParser.ArrayConstructionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#arrayConstruction.
    def exitArrayConstruction(self, ctx:SquirrelParser.ArrayConstructionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#rightShiftOp.
    def enterRightShiftOp(self, ctx:SquirrelParser.RightShiftOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#rightShiftOp.
    def exitRightShiftOp(self, ctx:SquirrelParser.RightShiftOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#postdecrementOp.
    def enterPostdecrementOp(self, ctx:SquirrelParser.PostdecrementOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#postdecrementOp.
    def exitPostdecrementOp(self, ctx:SquirrelParser.PostdecrementOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#unaryMinusOp.
    def enterUnaryMinusOp(self, ctx:SquirrelParser.UnaryMinusOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#unaryMinusOp.
    def exitUnaryMinusOp(self, ctx:SquirrelParser.UnaryMinusOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#identifier.
    def enterIdentifier(self, ctx:SquirrelParser.IdentifierContext):
        pass

    # Exit a parse tree produced by SquirrelParser#identifier.
    def exitIdentifier(self, ctx:SquirrelParser.IdentifierContext):
        pass


    # Enter a parse tree produced by SquirrelParser#notEqualOp.
    def enterNotEqualOp(self, ctx:SquirrelParser.NotEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#notEqualOp.
    def exitNotEqualOp(self, ctx:SquirrelParser.NotEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#subEqualOp.
    def enterSubEqualOp(self, ctx:SquirrelParser.SubEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#subEqualOp.
    def exitSubEqualOp(self, ctx:SquirrelParser.SubEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#postincrementOp.
    def enterPostincrementOp(self, ctx:SquirrelParser.PostincrementOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#postincrementOp.
    def exitPostincrementOp(self, ctx:SquirrelParser.PostincrementOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#baseExpression.
    def enterBaseExpression(self, ctx:SquirrelParser.BaseExpressionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#baseExpression.
    def exitBaseExpression(self, ctx:SquirrelParser.BaseExpressionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#bitwiseAndOp.
    def enterBitwiseAndOp(self, ctx:SquirrelParser.BitwiseAndOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#bitwiseAndOp.
    def exitBitwiseAndOp(self, ctx:SquirrelParser.BitwiseAndOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#leftShiftOp.
    def enterLeftShiftOp(self, ctx:SquirrelParser.LeftShiftOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#leftShiftOp.
    def exitLeftShiftOp(self, ctx:SquirrelParser.LeftShiftOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#rightUnsignedShiftOp.
    def enterRightUnsignedShiftOp(self, ctx:SquirrelParser.RightUnsignedShiftOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#rightUnsignedShiftOp.
    def exitRightUnsignedShiftOp(self, ctx:SquirrelParser.RightUnsignedShiftOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#dotAccess.
    def enterDotAccess(self, ctx:SquirrelParser.DotAccessContext):
        pass

    # Exit a parse tree produced by SquirrelParser#dotAccess.
    def exitDotAccess(self, ctx:SquirrelParser.DotAccessContext):
        pass


    # Enter a parse tree produced by SquirrelParser#indexAccess.
    def enterIndexAccess(self, ctx:SquirrelParser.IndexAccessContext):
        pass

    # Exit a parse tree produced by SquirrelParser#indexAccess.
    def exitIndexAccess(self, ctx:SquirrelParser.IndexAccessContext):
        pass


    # Enter a parse tree produced by SquirrelParser#modEqualOp.
    def enterModEqualOp(self, ctx:SquirrelParser.ModEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#modEqualOp.
    def exitModEqualOp(self, ctx:SquirrelParser.ModEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#functionCall.
    def enterFunctionCall(self, ctx:SquirrelParser.FunctionCallContext):
        pass

    # Exit a parse tree produced by SquirrelParser#functionCall.
    def exitFunctionCall(self, ctx:SquirrelParser.FunctionCallContext):
        pass


    # Enter a parse tree produced by SquirrelParser#instanceofOp.
    def enterInstanceofOp(self, ctx:SquirrelParser.InstanceofOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#instanceofOp.
    def exitInstanceofOp(self, ctx:SquirrelParser.InstanceofOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#greaterEqualOp.
    def enterGreaterEqualOp(self, ctx:SquirrelParser.GreaterEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#greaterEqualOp.
    def exitGreaterEqualOp(self, ctx:SquirrelParser.GreaterEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#ternaryOp.
    def enterTernaryOp(self, ctx:SquirrelParser.TernaryOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#ternaryOp.
    def exitTernaryOp(self, ctx:SquirrelParser.TernaryOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#cloneExpression.
    def enterCloneExpression(self, ctx:SquirrelParser.CloneExpressionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#cloneExpression.
    def exitCloneExpression(self, ctx:SquirrelParser.CloneExpressionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#multiplyOp.
    def enterMultiplyOp(self, ctx:SquirrelParser.MultiplyOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#multiplyOp.
    def exitMultiplyOp(self, ctx:SquirrelParser.MultiplyOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#assignOp.
    def enterAssignOp(self, ctx:SquirrelParser.AssignOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#assignOp.
    def exitAssignOp(self, ctx:SquirrelParser.AssignOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#deleteOperation.
    def enterDeleteOperation(self, ctx:SquirrelParser.DeleteOperationContext):
        pass

    # Exit a parse tree produced by SquirrelParser#deleteOperation.
    def exitDeleteOperation(self, ctx:SquirrelParser.DeleteOperationContext):
        pass


    # Enter a parse tree produced by SquirrelParser#greaterOp.
    def enterGreaterOp(self, ctx:SquirrelParser.GreaterOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#greaterOp.
    def exitGreaterOp(self, ctx:SquirrelParser.GreaterOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#anonymousFunction.
    def enterAnonymousFunction(self, ctx:SquirrelParser.AnonymousFunctionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#anonymousFunction.
    def exitAnonymousFunction(self, ctx:SquirrelParser.AnonymousFunctionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#subOp.
    def enterSubOp(self, ctx:SquirrelParser.SubOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#subOp.
    def exitSubOp(self, ctx:SquirrelParser.SubOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#lessOp.
    def enterLessOp(self, ctx:SquirrelParser.LessOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#lessOp.
    def exitLessOp(self, ctx:SquirrelParser.LessOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#parenExpression.
    def enterParenExpression(self, ctx:SquirrelParser.ParenExpressionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#parenExpression.
    def exitParenExpression(self, ctx:SquirrelParser.ParenExpressionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#predecrementOp.
    def enterPredecrementOp(self, ctx:SquirrelParser.PredecrementOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#predecrementOp.
    def exitPredecrementOp(self, ctx:SquirrelParser.PredecrementOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#bitwiseOrOp.
    def enterBitwiseOrOp(self, ctx:SquirrelParser.BitwiseOrOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#bitwiseOrOp.
    def exitBitwiseOrOp(self, ctx:SquirrelParser.BitwiseOrOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#addEqualOp.
    def enterAddEqualOp(self, ctx:SquirrelParser.AddEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#addEqualOp.
    def exitAddEqualOp(self, ctx:SquirrelParser.AddEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#inOp.
    def enterInOp(self, ctx:SquirrelParser.InOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#inOp.
    def exitInOp(self, ctx:SquirrelParser.InOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#mulEqualOp.
    def enterMulEqualOp(self, ctx:SquirrelParser.MulEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#mulEqualOp.
    def exitMulEqualOp(self, ctx:SquirrelParser.MulEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#logicalNotOp.
    def enterLogicalNotOp(self, ctx:SquirrelParser.LogicalNotOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#logicalNotOp.
    def exitLogicalNotOp(self, ctx:SquirrelParser.LogicalNotOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#bitwiseNotOp.
    def enterBitwiseNotOp(self, ctx:SquirrelParser.BitwiseNotOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#bitwiseNotOp.
    def exitBitwiseNotOp(self, ctx:SquirrelParser.BitwiseNotOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#addOp.
    def enterAddOp(self, ctx:SquirrelParser.AddOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#addOp.
    def exitAddOp(self, ctx:SquirrelParser.AddOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#divEqualOp.
    def enterDivEqualOp(self, ctx:SquirrelParser.DivEqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#divEqualOp.
    def exitDivEqualOp(self, ctx:SquirrelParser.DivEqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#scopeAccess.
    def enterScopeAccess(self, ctx:SquirrelParser.ScopeAccessContext):
        pass

    # Exit a parse tree produced by SquirrelParser#scopeAccess.
    def exitScopeAccess(self, ctx:SquirrelParser.ScopeAccessContext):
        pass


    # Enter a parse tree produced by SquirrelParser#tableConstruction.
    def enterTableConstruction(self, ctx:SquirrelParser.TableConstructionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#tableConstruction.
    def exitTableConstruction(self, ctx:SquirrelParser.TableConstructionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#compareOp.
    def enterCompareOp(self, ctx:SquirrelParser.CompareOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#compareOp.
    def exitCompareOp(self, ctx:SquirrelParser.CompareOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#typeofOp.
    def enterTypeofOp(self, ctx:SquirrelParser.TypeofOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#typeofOp.
    def exitTypeofOp(self, ctx:SquirrelParser.TypeofOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#functionDeclare.
    def enterFunctionDeclare(self, ctx:SquirrelParser.FunctionDeclareContext):
        pass

    # Exit a parse tree produced by SquirrelParser#functionDeclare.
    def exitFunctionDeclare(self, ctx:SquirrelParser.FunctionDeclareContext):
        pass


    # Enter a parse tree produced by SquirrelParser#bitwiseXOROp.
    def enterBitwiseXOROp(self, ctx:SquirrelParser.BitwiseXOROpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#bitwiseXOROp.
    def exitBitwiseXOROp(self, ctx:SquirrelParser.BitwiseXOROpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#equalOp.
    def enterEqualOp(self, ctx:SquirrelParser.EqualOpContext):
        pass

    # Exit a parse tree produced by SquirrelParser#equalOp.
    def exitEqualOp(self, ctx:SquirrelParser.EqualOpContext):
        pass


    # Enter a parse tree produced by SquirrelParser#literalExpression.
    def enterLiteralExpression(self, ctx:SquirrelParser.LiteralExpressionContext):
        pass

    # Exit a parse tree produced by SquirrelParser#literalExpression.
    def exitLiteralExpression(self, ctx:SquirrelParser.LiteralExpressionContext):
        pass


    # Enter a parse tree produced by SquirrelParser#functionDeclareEnd.
    def enterFunctionDeclareEnd(self, ctx:SquirrelParser.FunctionDeclareEndContext):
        pass

    # Exit a parse tree produced by SquirrelParser#functionDeclareEnd.
    def exitFunctionDeclareEnd(self, ctx:SquirrelParser.FunctionDeclareEndContext):
        pass


    # Enter a parse tree produced by SquirrelParser#tableSlot.
    def enterTableSlot(self, ctx:SquirrelParser.TableSlotContext):
        pass

    # Exit a parse tree produced by SquirrelParser#tableSlot.
    def exitTableSlot(self, ctx:SquirrelParser.TableSlotContext):
        pass


    # Enter a parse tree produced by SquirrelParser#basicTableSlot.
    def enterBasicTableSlot(self, ctx:SquirrelParser.BasicTableSlotContext):
        pass

    # Exit a parse tree produced by SquirrelParser#basicTableSlot.
    def exitBasicTableSlot(self, ctx:SquirrelParser.BasicTableSlotContext):
        pass


    # Enter a parse tree produced by SquirrelParser#arrayTableSlot.
    def enterArrayTableSlot(self, ctx:SquirrelParser.ArrayTableSlotContext):
        pass

    # Exit a parse tree produced by SquirrelParser#arrayTableSlot.
    def exitArrayTableSlot(self, ctx:SquirrelParser.ArrayTableSlotContext):
        pass


    # Enter a parse tree produced by SquirrelParser#jsonTableSlot.
    def enterJsonTableSlot(self, ctx:SquirrelParser.JsonTableSlotContext):
        pass

    # Exit a parse tree produced by SquirrelParser#jsonTableSlot.
    def exitJsonTableSlot(self, ctx:SquirrelParser.JsonTableSlotContext):
        pass


    # Enter a parse tree produced by SquirrelParser#expressionList.
    def enterExpressionList(self, ctx:SquirrelParser.ExpressionListContext):
        pass

    # Exit a parse tree produced by SquirrelParser#expressionList.
    def exitExpressionList(self, ctx:SquirrelParser.ExpressionListContext):
        pass



del SquirrelParser