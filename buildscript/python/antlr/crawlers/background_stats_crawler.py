from enum import Enum

from . import Crawler
from ..ast.AstUtils import AstUtils
from ..ast.SquirrelAstVisitor import SquirrelAstVisitor
from ..ast.nodes import *


class StatType(Enum):
	HITPOINTS = "Hitpoints"
	BRAVERY = "Bravery"
	STAMINA = "Stamina"
	MELEE_SKILL = "MeleeSkill"
	RANGED_SKILL = "RangedSkill"
	MELEE_DEFENSE = "MeleeDefense"
	RANGED_DEFENSE = "RangedDefense"
	INITIATIVE = "Initiative"

	@classmethod
	def from_string(cls, name: str) -> "StatType":
		try:
			return cls(name)
		except ValueError:
			raise ValueError(f"Unknown stat identifier: '{name}', a typo perhaps?")


@dataclass(frozen=True)
class StatRange:
	min_val: int
	max_val: int


@dataclass(frozen=True)
class Concrete:
	target: str
	stats: dict[StatType, StatRange]


@dataclass(frozen=True)
class Clone:
	target: str
	source: str


BackgroundStat = Concrete | Clone


class BackgroundStatsCrawler(Crawler[list[BackgroundStat]]):
	@staticmethod
	def get_range(table, name):
		""" Parses values from arrays """

		def _filter(a: ArrayConstruction):
			return isinstance(a.parent, BasicTableSlot) and a.parent.name == name

		if array := AstUtils.find_first(table, ArrayConstruction, _filter):
			min_val = array.expressions[0].real_value
			max_val = array.expressions[1].real_value
			return StatRange(min_val, max_val)
		return None

	@staticmethod
	def filter_tables(table: TableConstruction):
		""" Filters all tables in file to find correct for the case"""
		if not isinstance(table.parent, Newslot):
			return False
		if len(table.slots) == 0:
			return False
		if "::Legends.BackgroundsStats" not in str(AstUtils.qualified_name(table.parent.lhs)):
			return False
		return True

	@staticmethod
	def filter_clones(expr: CloneExpression):
		""" Filters clone expressions """
		if not isinstance(expr.parent, Newslot):
			return False
		return True

	def run(self, code) -> list[BackgroundStat]:
		tree = SquirrelAstVisitor.parse(code)
		comments = SquirrelAstVisitor.parseComments(code)

		result: list[BackgroundStat] = []

		for table in AstUtils.find(tree, TableConstruction, self.filter_tables):
			stats: dict[StatType, StatRange] = dict()
			for stat in StatType:
				stats[stat] = self.get_range(table, stat.value)

			result.append(Concrete(
				target=AstUtils.qualified_name(table.parent.lhs) or "?",
				stats=stats
			))

		for clone in AstUtils.find(tree, CloneExpression, self.filter_clones):
			result.append(Clone(
				target=AstUtils.qualified_name(clone.parent.lhs) or "?",
				source=AstUtils.qualified_name(clone.expr) or "?",
			))

		return result
