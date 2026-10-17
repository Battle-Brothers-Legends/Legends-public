import sys

from .crawlers import Crawler

try:
	from antlr4 import CommonTokenStream, InputStream, ParseTreeWalker
	from antlr4.error.ErrorListener import ErrorListener
	from antlr4.tree.Tree import ParseTreeWalker
except ImportError:
	print("Missing dependencies! Run: pip install antlr4-python3-runtime")
	sys.exit(1)

class Antlr4Runner(object):
	@staticmethod
	def run(code: str, scrawler: Crawler):
		try:
			return scrawler.run(code)
		except Exception as e:
			print(f"Syntax error: {str(e)}")
			return None
