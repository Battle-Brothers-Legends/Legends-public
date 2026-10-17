from dataclasses import dataclass, field, replace
from typing import Optional

from antlr.ast.AstUtils import AstUtils
from antlr.ast.SquirrelAstVisitor import SquirrelAstVisitor
from antlr.ast.nodes import Newslot, TableConstruction, Literal, ArrayConstruction, DotAccess, BasicTableSlot, \
	StringLiteral
from antlr.scrawlers import Scrawler


@dataclass(frozen=True)
class PerkNode:
	tier: int = field()
	name: str = field()
	const: str = field()


@dataclass
class PerkTreeDef:
	target: Optional[str] = None
	name: Optional[str] = None
	icon: Optional[str] = None
	tree: list[PerkNode] = field(default_factory=list)


class PerkTreeScrawler(Scrawler[list[PerkTreeDef]]):
	def run(self, code: str) -> list[PerkTreeDef]:
		tree = SquirrelAstVisitor.parse(code)
		comments = SquirrelAstVisitor.parseComments(code)

		result = []

		tables = AstUtils.find(
			tree, TableConstruction,
			lambda t: isinstance(t.parent, Newslot)
					  and "Tree" in str(AstUtils.qualified_name(t.parent.lhs))
		)
		for table in tables:
			definition = PerkTreeDef()
			if value := AstUtils.find_first(table, BasicTableSlot, lambda s: s.name == "ID"):
				if isinstance(value.expr, StringLiteral):
					definition = replace(definition, target=value.expr.value.strip('"'))
			if value := AstUtils.find_first(table, BasicTableSlot, lambda s: s.name == "Name"):
				if isinstance(value.expr, StringLiteral):
					definition = replace(definition, name=value.expr.value.strip('"'))
			if value := AstUtils.find_first(table, BasicTableSlot, lambda s: s.name == "Icon"):
				if isinstance(value.expr, StringLiteral):
					definition = replace(definition, icon=value.expr.value.strip('"'))

			# perk trees
			if tree := AstUtils.find_first(table, ArrayConstruction, lambda a: a.parent.name == "Tree"):
				for idx, constArray in enumerate(tree.expressions):
					if not isinstance(constArray, ArrayConstruction):
						continue  # skip non arrays

					for const in AstUtils.find(constArray, DotAccess, lambda it: it.parent == constArray):
						definition.tree.append(PerkNode(
							tier=idx,
							name=const.name,
							const=AstUtils.qualified_name(const) or ""
						))
			if definition.name:
				result.append(definition)
		return result
