from dataclasses import dataclass, field

from ..SquirrelParser import SquirrelParser
from ..SquirrelParserListener import SquirrelParserListener


@dataclass(frozen=True)
class PerkNode:
	tier: int
	name: str
	const: str


@dataclass
class PerkTreeDefAST:
	target: str | None = None
	name: str | None = None
	icon: str | None = None
	tree: list[PerkNode] = field(default_factory=list)


@dataclass
class State:
	parsing: bool = False
	ast: PerkTreeDefAST = field(default_factory=PerkTreeDefAST)

	def reset(self):
		self.parsing = False
		self.ast = PerkTreeDefAST()


class PerkTreeListener(SquirrelParserListener):
	def __init__(self):
		self.entries: list[PerkTreeDefAST] = []
		self.st = State()

	def enterNewslot(self, ctx: SquirrelParser.NewslotContext):
		target = ctx.expression(0).getText()
		if not ("Perks." in target or target.endswith("Tree")):
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
			if self.st.ast.name is not None:
				self.entries.append(self.st.ast)
			self.st.reset()

	def enterBasicTableSlot(self, ctx: SquirrelParser.BasicTableSlotContext):
		if not self.st.parsing:
			return

		match ctx.Identifier().getText():
			case "Name":
				self.st.ast.name = ctx.expression().getText().strip('"')
			case "Icon":
				self.st.ast.icon = ctx.expression().getText().strip('"')
			case "Tree":
				self._parse_tree(ctx.expression())

	def _parse_tree(self, ctx: SquirrelParser.ArrayConstructionContext):
		for index, item in enumerate(ctx.expressionList().expression()):
			if not isinstance(item, SquirrelParser.ArrayConstructionContext):
				continue
			if item.expressionList() is None:
				continue
			for const in item.expressionList().expression():
				if isinstance(const, SquirrelParser.DotAccessContext):
					self.st.ast.tree.append(PerkNode(
						tier=index,
						name=const.Identifier().getText(),
						const=const.getText()
					))
