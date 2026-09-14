# data extraction from /mod_legends/!!config/background_defs.nut
import re
from dataclasses import dataclass, field
from typing import Any

from ..SquirrelParser import SquirrelParser
from ..SquirrelParserListener import SquirrelParserListener


@dataclass
class PerkTreesAST:
	target: str| None = None
	trees: list[str] = field(default_factory=list)

@dataclass
class State:
	parsing: bool = False
	ast: PerkTreesAST = field(default_factory=PerkTreesAST)

	def reset(self):
		self.parsing = False
		self.ast = PerkTreesAST()

class BackgroundPerkTreesListener(SquirrelParserListener):
	def __init__(self):
		self.entries: list[PerkTreesAST] = []
		self.st = State()

	def enterNewslot(self, ctx: SquirrelParser.NewslotContext):
		target = ctx.expression(0).getText()
		if not "BackgroundPerkTrees." in target:
			return

		if not isinstance(ctx.expression(1), SquirrelParser.TableConstructionContext):
			return

		self.st.reset()
		self.st.parsing = True
		self.st.ast.target = target

	def exitNewslot(self, ctx: SquirrelParser.NewslotContext):
		if not self.st.parsing:
			return

		if ctx.expression(0).getText() == self.st.ast.target:
			if self.st.ast.target is not None:
				self.entries.append(self.st.ast)
			self.st.reset()

	def enterBasicTableSlot(self, ctx: SquirrelParser.BasicTableSlotContext):
		if not self.st.parsing:
			return
		if not isinstance(ctx.expression(), SquirrelParser.ArrayConstructionContext):
			return

		self._parse_array(ctx.expression())

	def _parse_array(self, ctx: SquirrelParser.ArrayConstructionContext):
		if ctx.expressionList() is None:
			return
		for index, item in enumerate(ctx.expressionList().expression()):
			self.st.ast.trees.append(item.Identifier().getText())
