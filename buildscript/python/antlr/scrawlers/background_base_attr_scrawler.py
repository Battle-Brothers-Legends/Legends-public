from dataclasses import dataclass
from . import Scrawler
from .background_stats_scrawler import StatType, StatRange
from ..ast.AstUtils import AstUtils
from ..ast.SquirrelAstVisitor import SquirrelAstVisitor
from ..ast.nodes import *


@dataclass(frozen=True)
class BackgroundBaseAttr:
	target: str
	stats: dict[StatType, StatRange]

	def add_stats(self, stats: dict[StatType, StatRange]):
		combine_ranges = lambda a, b: StatRange(
			(a.min_val if a else 0) + (b.min_val if b else 0),
			(a.max_val if a else 0) + (b.max_val if b else 0)
		)
		return {
			key: combine_ranges(self.stats.get(key), stats.get(key))
			for key in (self.stats.keys() | stats.keys())
		}


class BackgroundBaseAttrScrawler(Scrawler[list[BackgroundBaseAttr]]):
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
		if "::Legends.Backgrounds.BaseAttr" not in str(AstUtils.qualified_name(table.parent.lhs)):
			return False
		return True

	def run(self, code) -> list[BackgroundBaseAttr]:
		tree = SquirrelAstVisitor.parse(code)
		comments = SquirrelAstVisitor.parseComments(code)
		result = []

		if not (table := AstUtils.find_first(tree, TableConstruction, self.filter_tables)):
			raise "Wtf, what happened to `::Legends.Backgrounds.BaseAttr` ?"

		for slot in AstUtils.find(table, TableConstruction):
			stats: dict[StatType, StatRange] = dict()
			for stat in StatType:
				if _range := self.get_range(slot, stat.value):
					stats[stat] = _range
			result.append(BackgroundBaseAttr(
				target=slot.parent.name,
				stats=stats
			))

		return result
