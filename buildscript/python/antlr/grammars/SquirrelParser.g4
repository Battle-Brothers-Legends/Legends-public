parser grammar SquirrelParser;

options {
    tokenVocab=SquirrelLexer;
}

program
    :   statements EOF;

statements
    :   statement*;

statement
    :   statementBody? SEMICOLON+
    |   statementBody
    ;

statementBody
    :   statementBlock
    |   ifStatement
    |   whileStatement
    |   doWhileStatement
    |   switchStatement
    |   forStatement
    |   foreachStatement
    |   breakStatement
    |   continueStatement
    |   returnStatement
    |   yieldStatement
    |   classDeclare
    |   tryCatch
    |   throwStatement
    |   constStatement
    |   enumStatement
    |   indexAssign
    |   localDeclare
    |   expression;

statementBlock
    :   L_CURLY_BRACKET statements R_CURLY_BRACKET;

ifStatement
    :   IF L_PAREN expression R_PAREN statement (ELSE statement)?;

whileStatement
    :   WHILE L_PAREN expression R_PAREN statement;

doWhileStatement
    :   DO statement WHILE L_PAREN expression R_PAREN;

switchStatement
    :   SWITCH L_PAREN expression R_PAREN L_CURLY_BRACKET switchCase* defaultCase? R_CURLY_BRACKET
    ;

switchCase
    :   CASE expression COLON statements
    ;

defaultCase
    :   DEFAULT COLON statements
    ;

forStatement
    :   FOR L_PAREN statement? SEMICOLON statement? SEMICOLON statement? R_PAREN statement;

foreachStatement
    :   FOREACH L_PAREN foreachVar IN expression R_PAREN statement;

foreachVar
    :   Identifier #keyOnlyVar
    |   Identifier COMMA Identifier #keyValVar;

breakStatement
    :   BREAK;

continueStatement
    :   CONTINUE;

returnStatement
    :   RETURN expression?;

yieldStatement
    :   YIELD expression?;

localDeclare
    :   LOCAL inits
    |   LOCAL FUNCTION funcname functionDeclareEnd;

classDeclare
    :   CLASS className (EXTENDS className)? L_CURLY_BRACKET memberDeclare* R_CURLY_BRACKET;

className
    :   (THIS DOT |SCOPE)? Identifier ((DOT | SCOPE) Identifier)*;

tryCatch
    :   TRY statement CATCH (L_PAREN Identifier R_PAREN)? statement;

throwStatement
    :   THROW expression;

constStatement
    :   CONST Identifier ASSIGN constValue;

constValue
    :   (PLUS | MINUS)? IntegerLiteral
    |   FloatLiteral
    |   StringLiteral;

indexAssign
    :   expression L_BRACKET expression R_BRACKET ASSIGN expression;

enumStatement
    :   ENUM Identifier L_CURLY_BRACKET enumerations* R_CURLY_BRACKET;

enumerations
    :   Identifier ASSIGN constValue COMMA?;

memberDeclare
    :   STATIC? Identifier ASSIGN expression SEMICOLON?             #memberStaticDeclare
    |   L_BRACKET expression R_BRACKET ASSIGN expression SEMICOLON? #memberArrayDeclare
    |   FUNCTION funcname functionDeclareEnd                        #memberFunctionDeclare
    |   CONSTRUCTOR functionDeclareEnd                              #memberConstructorDeclare
    ;

inits
    :   init (COMMA init)*
    ;

init
    :   Identifier (ASSIGN expression)?
    ;

args
    :   arg (COMMA arg)* (COMMA VARARGS)?
    |   VARARGS;

arg
    :   Identifier (ASSIGN expression)?;

funcname
    :   Identifier (SCOPE Identifier)*;

literal
    :   IntegerLiteral
    |   FloatLiteral
    |   BooleanLiteral
    |   StringLiteral
    |   NULL
    |   THIS;

expression
    // 1 Primary expressions
    :   literal                                     #literalExpression
    |   Identifier                                  #identifier
    |   L_PAREN expression R_PAREN                  #parenExpression
    |   L_CURLY_BRACKET tableSlot* R_CURLY_BRACKET  #tableConstruction
    |   L_BRACKET expressionList? (COMMA)? R_BRACKET #arrayConstruction
    |   FUNCTION funcname functionDeclareEnd        #functionDeclare
    |   FUNCTION functionDeclareEnd                 #anonymousFunction
    |   AT L_PAREN args? R_PAREN expression         #lambda
    |   BASE DOT Identifier L_PAREN expressionList? R_PAREN #baseExpression

    // 2 Scope access
    |   SCOPE Identifier                            #scopeAccess

    // 3 Postfix & Member Access (Highest Operator Precedence)
    |   expression DOT Identifier                   #dotAccess
    |   expression L_BRACKET expression R_BRACKET   #indexAccess
    |   expression L_PAREN expressionList? R_PAREN  #functionCall
    |   expression INCREMENT                        #postincrementOp
    |   expression DECREMENT                        #postdecrementOp

    // 4 Unary / Prefix Operations
    |   CLONE expression                            #cloneExpression
    |   RESUME expression                           #resumeExpression
    |   DELETE expression                           #deleteOperation
    |   MINUS expression                            #unaryMinusOp
    |   BITWISE_NOT expression                      #bitwiseNotOp
    |   LOGICAL_NOT expression                      #logicalNotOp
    |   TYPEOF expression                           #typeofOp
    |   INCREMENT expression                        #preincrementOp
    |   DECREMENT expression                        #predecrementOp

    // 5 Binary Operations (Multiplication, Addition, Bitwise, Logical...)
    |   expression DIVIDE expression                #divideOp
    |   expression MULTIPLY expression              #multiplyOp
    |   expression MODULO expression                #moduloOp

    |   expression PLUS expression                  #addOp
    |   expression MINUS expression                 #subOp

    |   expression LEFT_SHIFT expression            #leftShiftOp
    |   expression RIGHT_SHIFT expression           #rightShiftOp
    |   expression RIGHT_UNSIGNED_SHIFT expression  #rightUnsignedShiftOp

    |   expression LESS_THAN expression             #lessOp
    |   expression LESS_OR_EQUAL expression         #lessEqualOp
    |   expression GREATER_THAN expression          #greaterOp
    |   expression GREATER_OR_EQUAL expression      #greaterEqualOp

    |   expression EQUAL expression                 #equalOp
    |   expression NOT_EQUAL expression             #notEqualOp
    |   expression COMPARE expression               #compareOp

    |   expression BITWISE_AND expression           #bitwiseAndOp
    |   expression BITWISE_XOR expression           #bitwiseXOROp
    |   expression BITWISE_OR expression            #bitwiseOrOp

    |   expression LOGICAL_AND expression           #logicalAndOp
    |   expression IN expression                    #inOp
    |   expression LOGICAL_OR expression            #logicalOrOp
    |   expression INSTANCEOF expression            #instanceofOp

    |   expression QUESTION expression COLON expression #ternaryOp

    // 6 Assignment (Lowest Precedence)
    |   expression NEWSLOT expression               #newslot
    |   expression ASSIGN_MUL expression            #mulEqualOp
    |   expression ASSIGN_DIV expression            #divEqualOp
    |   expression ASSIGN_MOD expression            #modEqualOp
    |   expression ASSIGN_ADD expression            #addEqualOp
    |   expression ASSIGN expression                #assignOp
    |   expression ASSIGN_SUB expression            #subEqualOp
    ;

functionDeclareEnd
    :   L_PAREN args? R_PAREN statement
    ;

tableSlot
    :   (basicTableSlot | arrayTableSlot | jsonTableSlot | (FUNCTION funcname functionDeclareEnd)) COMMA?
    ;

basicTableSlot
    :   Identifier (ASSIGN | COLON) expression
    ;

arrayTableSlot
    :   L_BRACKET expression R_BRACKET ASSIGN expression
    ;

jsonTableSlot
    :   DOUBLE_QUOTE Identifier DOUBLE_QUOTE COLON expression
    ;

expressionList
    :   expression (COMMA expression)* COMMA?
    ;