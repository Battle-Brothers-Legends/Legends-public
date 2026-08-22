lexer grammar SquirrelLexer;

channels {
    COMMENT,
    EOL
}

SCOPE : '::';
VARARGS : '...';
NEWSLOT : '<-';

INCREMENT : '++';
DECREMENT : '--';

LESS_THAN : '<';
LESS_OR_EQUAL : '<=';
EQUAL : '==';
NOT_EQUAL : '!=';
GREATER_THAN : '>';
GREATER_OR_EQUAL : '>=';

ASSIGN_ADD : '+=';
ASSIGN_SUB : '-=';
ASSIGN_DIV : '/=';
ASSIGN_MUL : '*=';
ASSIGN_MOD : '%=';

ASSIGN : '=';
MODULO : '%';
MULTIPLY : '*';
DIVIDE : '/';

LOGICAL_NOT : '!';
LOGICAL_AND : '&&';
LOGICAL_OR : '||';

BITWISE_NOT : '~';
BITWISE_XOR : '^';
BITWISE_AND : '&';
BITWISE_OR : '|';

COMPARE : '<=>';

LEFT_SHIFT : '<<';
RIGHT_SHIFT : '>>';
RIGHT_UNSIGNED_SHIFT : '>>>';

L_PAREN : '(';
R_PAREN : ')';
L_CURLY_BRACKET : '{';
R_CURLY_BRACKET : '}';
L_BRACKET : '[';
R_BRACKET : ']';
SEMICOLON : ';';
COLON : ':';
COMMA : ',';
AT : '@';
QUESTION : '?';
DOT : '.';
PLUS : '+';
MINUS : '-';
DOUBLE_QUOTE : '"';
SINGLE_QUOTE : '\'';

WHILE : 'while';
DO : 'do';
IF : 'if';
ELSE : 'else';
BREAK : 'break';
CONTINUE : 'continue';
RETURN : 'return';
NULL : 'null';
FUNCTION : 'function';
LOCAL : 'local';
FOR : 'for';
FOREACH : 'foreach';
IN : 'in';
TYPEOF : 'typeof';
BASE : 'base';
DELETE : 'delete';
TRY : 'try';
CATCH : 'catch';
THROW : 'throw';
CLONE : 'clone';
YIELD : 'yield';
RESUME : 'resume';
SWITCH : 'switch';
CASE : 'case';
DEFAULT : 'default';
THIS : 'this';
CLASS : 'class';
EXTENDS : 'extends';
CONSTRUCTOR : 'constructor';
INSTANCEOF : 'instanceof';
STATIC : 'static';
ENUM : 'enum';
CONST : 'const';

fragment Digit
    :   [0-9];

fragment NonZeroDigit
    :   [1-9];

IntegerLiteral
    :   DecimalIntegerLiteral
    |   HexIntegerLiteral
    |   CharIntegerLiteral
    |   OctIntegerLiteral;

fragment DecimalIntegerLiteral
    :   Digit+;

fragment HexIntegerLiteral
    :   '0x' HexDigit+;

fragment HexDigit
    :   [0-9A-Fa-f];

fragment CharIntegerLiteral
    :   '\'' . '\'';

fragment OctIntegerLiteral
    :   '0'[0-7]+;

FloatLiteral
    :   DecimalFloatLiteral
    |   ScientificFloatLiteral;

fragment DecimalFloatLiteral
    :   [-+]? Digit+ '.' Digit+;

fragment ScientificFloatLiteral
    :   DecimalFloatLiteral [eE] [+-]? Digit+;

StringLiteral
    :   NormalStringLiteral
    |   VerbatimStringLiteral;

fragment NormalStringLiteral
    :   '"' StringCharacter* '"';

fragment VerbatimStringLiteral
    :   '@"' (~'"' | '""')* '"'
    ;

fragment StringCharacter
    :   ~["\\\r\n]
    |   EscapeSequence;

fragment EscapeSequence
    :   '\\' ([tabnrvf\\"'0] | 'x' HexDigit+);

Comment
    :   ('//' | '#') ~('\r' | '\n')* -> channel(COMMENT);

MultilineComment
    :   '/*' .*? '*/' -> channel(COMMENT);

BooleanLiteral
    :   TrueLiteral
    |   FalseLiteral;

fragment TrueLiteral
    :   'true';

fragment FalseLiteral
    :   'false';

Identifier
    :   [a-zA-Z_] [a-zA-Z_0-9]*;

NEWLINE: '\n' -> channel(EOL);
WS: (' ' | '\t' | '\r') -> skip;