from dataclasses import dataclass
from . import Crawler
from .def_helpers import DefsHelpers
from ..ast.AstUtils import AstUtils
from ..ast.SquirrelAstVisitor import SquirrelAstVisitor
from ..ast.nodes import *

@dataclass(frozen=True)
class BackgroundDef:
	id: str
	name: str
	hiring_cost: str = ""
	daily_cost: str = ""
	icon: str = ""
	const: str = ""

class BackgroundDefsCrawler(Crawler[list[BackgroundDef]]):
	@staticmethod
	def filter_tables(table: TableConstruction):
		""" Filters all tables in file to find correct for the case"""
		if not isinstance(table.parent, Newslot):
			return False
		if len(table.slots) == 0:
			return False
		if "::Legends.Background" not in str(AstUtils.qualified_name(table.parent.lhs)):
			return False
		return True

	def run(self, code) -> list[BackgroundDef]:
		tree = SquirrelAstVisitor.parse(code)
		comments = SquirrelAstVisitor.parseComments(code)

		backgrounds = []
		# find Legends.Background <- {...}
		if not (table := AstUtils.find_first(tree, TableConstruction, self.filter_tables)):
			return []

		# find new slot declarations inside table
		for slot in table.slots:
			skip, custom_name = self._parse_wiki_metadata(comments.for_node(slot))
			if skip:
				continue # skip because metadata said so
			if not (innerTable := AstUtils.find_first(slot, TableConstruction, lambda t: t.parent == slot)):
				continue # skip because it has no table defined

			properties = dict()
			for innerSlot in innerTable.slots:
				if literal := AstUtils.find_first(innerSlot, Literal):
					properties[innerSlot.key] = literal.real_value

			bg_def = BackgroundDef(
				id=properties.get("ID", f"background.{DefsHelpers.convert_to_snake_case(slot.key)}"),
				name=properties.get("Name", DefsHelpers.convert_to_display_name(slot.key)),
				hiring_cost=str(properties.get("HiringCost", 0)),
				daily_cost=str(properties.get("DailyCost", 0)),
				icon=properties.get("Icon", DefsHelpers.convert_to_snake_case(slot.key)),
				const=slot.key
			)
			backgrounds.append(bg_def)
		return backgrounds