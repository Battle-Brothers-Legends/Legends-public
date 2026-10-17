from dataclasses import dataclass

from . import Scrawler
from .background_stats_scrawler import StatType, StatRange
from ..ast.AstUtils import AstUtils
from ..ast.SquirrelAstVisitor import SquirrelAstVisitor
from ..ast.nodes import *

@dataclass
class PerkTrees:
	target: str| None = None
	trees: list[str] = field(default_factory=list)

class BackgroundPerkTreesScrawler(Scrawler[list[PerkTrees]]):
	@staticmethod
	def filter_tables(table: TableConstruction):
		""" Filters all tables in file to find correct for the case"""
		if not isinstance(table.parent, Newslot):
			return False
		if len(table.slots) == 0:
			return False
		if "::Legends.BackgroundPerkTrees" not in str(AstUtils.qualified_name(table.parent.lhs)):
			return False
		return True

	def run(self, code) -> list[PerkTrees]:
		tree = SquirrelAstVisitor.parse(code)
		comments = SquirrelAstVisitor.parseComments(code)
		result = []

		for table in AstUtils.find(tree, TableConstruction, self.filter_tables):
			perks: list[str] = []
			for slot in AstUtils.find(table, ArrayConstruction):
				for entry in slot.expressions:
					perks.append(str(AstUtils.qualified_name(entry)))
			result.append(PerkTrees(
				target=table.parent.lhs.name,
				trees=perks
			))
		return result
