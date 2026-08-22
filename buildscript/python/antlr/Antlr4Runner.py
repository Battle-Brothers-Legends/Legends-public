import sys

try:
	from antlr4 import CommonTokenStream, InputStream, ParseTreeWalker
	from antlr4.error.ErrorListener import ErrorListener
	from antlr4.tree.Tree import ParseTreeWalker
except ImportError:
	print("Missing dependencies! Run: pip install antlr4-python3-runtime")
	sys.exit(1)

from .SquirrelLexer import SquirrelLexer
from .SquirrelParser import SquirrelParser
from .SquirrelParserListener import SquirrelParserListener


class Antlr4Runner(object):
	class PrintErrorListener(ErrorListener):
		def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
			print(f"Syntax error at line {line}, column {column}: {msg}")

	@staticmethod
	def run(code: str, listener: SquirrelParserListener):
		token_stream = CommonTokenStream(SquirrelLexer(InputStream(code)))

		parser = SquirrelParser(token_stream)
		parser.removeErrorListeners()
		parser.addErrorListener(Antlr4Runner.PrintErrorListener())

		try:
			tree = parser.program()
			walker = ParseTreeWalker()
			walker.walk(listener, tree)
			return listener
		except Exception as e:
			print(f"Syntax error: {str(e)}")
			return None
