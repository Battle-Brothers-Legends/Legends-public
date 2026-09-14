# data extraction from /mod_legends/!!config/background_stats.nut
from dataclasses import dataclass
from enum import Enum

from ..SquirrelParser import SquirrelParser
from ..SquirrelParserListener import SquirrelParserListener

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

BackgroundStatAST = Concrete | Clone

class BackgroundStatsListener(SquirrelParserListener):
	def __init__(self):
		self.entries: list[BackgroundStatAST] = []
		self._current_bg_name: str | None = None
		self._current_stats: dict[StatType, StatRange] = {}

	def enterNewslot(self, ctx: SquirrelParser.NewslotContext):
		self._current_bg_name = ctx.expression(0).getText()

	def exitNewslot(self, ctx: SquirrelParser.NewslotContext):
		if not self._current_bg_name:
			return

		rhs_text = ctx.expression(1).getText()

		if rhs_text.startswith("clone"):
			source = rhs_text.removeprefix("clone").strip()
			self.entries.append(Clone(target=self._current_bg_name, source=source))
		elif self._current_stats:
			self.entries.append(Concrete(target=self._current_bg_name, stats=dict(self._current_stats)))

		self._current_stats.clear()
		self._current_bg_name = None

	def enterBasicTableSlot(self, ctx: SquirrelParser.BasicTableSlotContext):
		raw_key = ctx.Identifier().getText()
		stat_type = StatType.from_string(raw_key)

		raw_array_str = ctx.expression().getText()
		clean_vals = raw_array_str.strip("[]").split(",")

		min_val = int(clean_vals[0].strip())
		max_val = int(clean_vals[1].strip())

		self._current_stats[stat_type] = StatRange(min_val, max_val)