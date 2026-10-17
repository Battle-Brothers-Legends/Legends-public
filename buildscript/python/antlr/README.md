### Generating grammar files

```
cd antlr
antlr4.exe -Dlanguage=Python3 -visitor grammars/SquirrelLexer.g4 grammars/SquirrelParser.g4
```