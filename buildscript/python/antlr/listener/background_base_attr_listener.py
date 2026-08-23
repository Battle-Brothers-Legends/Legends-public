# data extraction from /mod_legends/!!config/character_backgrounds.nut
from dataclasses import dataclass

from .background_stats_listener import StatType, StatRange
from ..SquirrelParser import SquirrelParser
from ..SquirrelParserListener import SquirrelParserListener

@dataclass(frozen=True)
class BackgroundBaseAttrAST:
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

class BackgroundBaseAttrListener(SquirrelParserListener):
	TARGET = "::Legends.Backgrounds.BaseAttr"

	def __init__(self):
		self.entries: list[BackgroundBaseAttrAST] = []
		self._is_target_object = False
		self._current_sub_target: str | None = None
		self._current_stats: dict[StatType, StatRange] = {}

	def enterNewslot(self, ctx: SquirrelParser.NewslotContext):
		target_name = ctx.expression(0).getText()
		if target_name == self.TARGET:
			self._is_target_object = True

	def exitNewslot(self, ctx: SquirrelParser.NewslotContext):
		target_name = ctx.expression(0).getText()
		if target_name == self.TARGET:
			self._is_target_object = False

	def enterBasicTableSlot(self, ctx: SquirrelParser.BasicTableSlotContext):
		if not self._is_target_object:
			return

		key = ctx.Identifier().getText()
		val_expr = ctx.expression()

		if isinstance(val_expr, SquirrelParser.TableConstructionContext):
			self._current_sub_target = key
			self._current_stats.clear()

		elif self._current_sub_target:
			stat_type = StatType.from_string(key)
			if stat_type is not None:
				raw_array_str = val_expr.getText()
				if raw_array_str.startswith("[") and raw_array_str.endswith("]"):
					clean_vals = raw_array_str.strip("[]").split(",")
					if len(clean_vals) >= 2:
						min_val = int(clean_vals[0].strip())
						max_val = int(clean_vals[1].strip())
						self._current_stats[stat_type] = StatRange(min_val, max_val)

	def exitBasicTableSlot(self, ctx: SquirrelParser.BasicTableSlotContext):
		if not self._is_target_object:
			return

		key = ctx.Identifier().getText()
		val_expr = ctx.expression()

		# Finalize entry when leaving the nested table slot (e.g., Default = { ... })
		if (isinstance(val_expr, SquirrelParser.TableConstructionContext) or "{" in val_expr.getText()) and self._current_sub_target == key:
			if self._current_stats:
				self.entries.append(
					BackgroundBaseAttrAST(
						target=self._current_sub_target,
						stats=dict(self._current_stats)
					)
				)
			self._current_stats.clear()
			self._current_sub_target = None