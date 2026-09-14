# data extraction from /mod_legends/!!config/background_defs.nut
import re
from dataclasses import dataclass
from typing import Any

from ..SquirrelParser import SquirrelParser
from ..SquirrelParserListener import SquirrelParserListener


@dataclass(frozen=True)
class BackgroundDefAST:
	id: str
	script: str
	const: str
	name: str
	hiring_cost: str
	daily_cost: str
	icon: str


class BackgroundDefsListener(SquirrelParserListener):
	def __init__(self):
		self.entries: list[BackgroundDefAST] = []
		self._current_table: dict[str, Any] = {}
		self._in_push_call = False
		self._skip_current = False
		self._override_name: str | None = None

	# noinspection method-may-be-static
	def _get_comments(self, ctx) -> list[str]:
		try:
			token_stream = ctx.parser.getInputStream()
			if not token_stream or not ctx.start:
				return []

			comments = []

			left_tokens = token_stream.getHiddenTokensToLeft(ctx.start.tokenIndex, channel=-1)
			if left_tokens:
				for t in left_tokens:
					text = t.text.strip()
					if text.startswith("//") or text.startswith("/*"):
						comments.append(text)

			right_tokens = token_stream.getHiddenTokensToRight(ctx.stop.tokenIndex, channel=-1)
			if right_tokens:
				for t in right_tokens:
					text = t.text.strip()
					if text.startswith("//") or text.startswith("/*"):
						comments.append(text)

			return comments
		except Exception:
			return []

	def enterFunctionCall(self, ctx: SquirrelParser.FunctionCallContext):
		call_text = ctx.expression().getText()
		if "backgroundDefs.push" in call_text:
			self._in_push_call = True

	def exitFunctionCall(self, ctx: SquirrelParser.FunctionCallContext):
		call_text = ctx.expression().getText()
		if "backgroundDefs.push" in call_text:
			if self._skip_current:
				self._in_push_call = False
				self._skip_current = False
				self._override_name = None
				self._current_table.clear()
				return

			if self._current_table:
				final_name = (
					self._override_name
					if self._override_name is not None
					else str(self._current_table.get("Name", ""))
				)

				self.entries.append(BackgroundDefAST(
					id=str(self._current_table.get("ID", "")),
					script=str(self._current_table.get("Script", "")),
					const=str(self._current_table.get("Const", "")),
					name=final_name.replace("\\'", "'"),
					hiring_cost=str(self._current_table.get("HiringCost", "0")),
					daily_cost=str(self._current_table.get("DailyCost", "0")),
					icon=str(self._current_table.get("Icon", "")),
				))

			# Reset flags only when exiting the function call
			self._in_push_call = False
			self._skip_current = False
			self._override_name = None
			self._current_table.clear()

	def enterBasicTableSlot(self, ctx: SquirrelParser.BasicTableSlotContext):
		if not self._in_push_call:
			return

		comments = self._get_comments(ctx)
		for comment in comments:
			if "@wiki_skip" in comment:
				self._skip_current = True
				return

			if "@wiki_name" in comment:
				match = re.search(r'@wiki_name\s+(?:"([^"]+)"|\'([^\']+)\'|(\S+))', comment)
				if match:
					self._override_name = match.group(1) or match.group(2) or match.group(3)

		key = ctx.Identifier().getText()
		val = ctx.expression().getText()

		if (val.startswith('"') and val.endswith('"')) or (val.startswith("'") and val.endswith("'")):
			val = val[1:-1]

		self._current_table[key] = val