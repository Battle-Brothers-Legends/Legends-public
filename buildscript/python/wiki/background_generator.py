import os
import re
from typing import assert_never

from antlr import Antlr4Runner
from antlr.listener.background_defs_listener import BackgroundDefsListener, BackgroundDefAST
from antlr.listener.background_stats_listener import Concrete, Clone, StatType, StatRange
from antlr.listener.background_stats_listener import BackgroundStatsListener, BackgroundStatAST
from wiki.generator import Generator


class BackgroundGenerator(Generator):
	TEMPLATE = """
<table>
  <thead>
	<tr>
	  <th colspan="7" align="left">
		<img src="{icon}" align="center" />
		<b>{name}</b>
	  </th>
	  <th colspan="2" align="right">
		<img src="ui/icons/asset_daily_money.png" align="center" />
		<b>{wage}</b>
	  </th>
	</tr>
    <tr align="center">
      <th></th>
      <th><img src="ui/icons/health.png"/></th>
      <th><img src="ui/icons/melee_skill.png"/></th>
      <th><img src="ui/icons/ranged_skill.png"/></th>
      <th><img src="ui/icons/melee_defense.png"/></th>
      <th><img src="ui/icons/ranged_defense.png"/></th>
      <th><img src="ui/icons/fatigue.png"/></th>
      <th><img src="ui/icons/bravery.png"/></th>
      <th><img src="ui/icons/initiative.png"/></th>
    </tr>
  </thead>
  <tbody>
    <!-- Attribute Range -->
    <tr align="center">
      <td align="left"><b>Attribute Range</b></td>
      <td>{hp_min}<br>{hp_max}</td>
      <td>{matk_min}<br>{matk_max}</td>
      <td>{ratk_min}<br>{ratk_max}</td>
      <td>{mdef_min}<br>{mdef_max}</td>
      <td>{rdef_min}<br>{rdef_max}</td>
      <td>{fat_min}<br>{fat_max}</td>
      <td>{res_min}<br>{res_max}</td>
      <td>{ini_min}<br>{ini_max}</td>
    </tr>
  </tbody>
</table>
"""

	STAT_DISPLAY_NAMES = {
		StatType.HITPOINTS: "Hitpoints",
		StatType.BRAVERY: "Resolve",
		StatType.STAMINA: "Fatigue",
		StatType.MELEE_SKILL: "M.Attack",
		StatType.RANGED_SKILL: "R.Attack",
		StatType.MELEE_DEFENSE: "M.Defense",
		StatType.RANGED_DEFENSE: "R.Defense",
		StatType.INITIATIVE: "Initiative",
	}

	def __init__(self, root, output_path):
		self.root = root
		self.output_path = output_path

	def process(self):
		stats = self._get_stats() or {}
		defs = self._get_defs() or {}
		markdown_lines = []

		for const, entry in defs.items():
			stat = stats[const]
			table = self.TEMPLATE.format(
				icon=entry.icon,
				name=entry.name,
				level=0,
				wage=entry.daily_cost,
				# Min values
				hp_min=stat[StatType.HITPOINTS].min_val,
				matk_min=stat[StatType.MELEE_SKILL].min_val,
				ratk_min=stat[StatType.RANGED_SKILL].min_val,
				mdef_min=stat[StatType.MELEE_DEFENSE].min_val,
				rdef_min=stat[StatType.RANGED_DEFENSE].min_val,
				fat_min=stat[StatType.STAMINA].min_val,
				res_min=stat[StatType.BRAVERY].min_val,
				ini_min=stat[StatType.INITIATIVE].min_val,
				# Max values
				hp_max=stat[StatType.HITPOINTS].max_val,
				matk_max=stat[StatType.MELEE_SKILL].max_val,
				ratk_max=stat[StatType.RANGED_SKILL].max_val,
				mdef_max=stat[StatType.MELEE_DEFENSE].max_val,
				rdef_max=stat[StatType.RANGED_DEFENSE].max_val,
				fat_max=stat[StatType.STAMINA].max_val,
				res_max=stat[StatType.BRAVERY].max_val,
				ini_max=stat[StatType.INITIATIVE].max_val,
			)
			markdown_lines.append(f"#### {self._convert_const(const)}")
			markdown_lines.append(table)

		os.makedirs(self.root / self.output_path, exist_ok=True)
		with open((self.root / self.output_path / "Backgrounds.md").resolve(), "w", encoding="utf-8") as f:
			f.write("\n".join(markdown_lines))

	def _get_stats(self) -> dict[str, dict[StatType, StatRange]] | None:
		code = self.get_content((self.root / "mod_legends/!!config/background_stats.nut").resolve())
		try:
			result: dict[str, dict[StatType, StatRange]] = {}
			entries: list[BackgroundStatAST] = Antlr4Runner.run(
				code, BackgroundStatsListener()
			).entries

			for entry in entries:
				match entry:
					case Concrete(target=target, stats=stats):
						result[target.split(".")[-1]] = stats
					case Clone(target=target, source=source):
						result[target.split(".")[-1]] = result[source.split(".")[-1]]
					case _ as unreachable:
						assert_never(unreachable)

			return result
		except Exception as e:
			print(f"Error parsing background stats: {str(e)}")
			return None


	def _get_defs(self) -> dict[str, BackgroundDefAST] | None:
		result: dict[str, BackgroundDefAST] = {}
		code = self.get_content((self.root / "mod_legends/!!config/backgrounds_defs.nut").resolve())
		try:
			entries: list[BackgroundDefAST] = Antlr4Runner.run(
				code, BackgroundDefsListener()
			).entries

			for entry in entries:
				result[entry.const] = entry
			return result
		except Exception as e:
			print(f"Error parsing background defs: {str(e)}")
			return None

	def _convert_const(self, text: str) -> str:
		s = re.sub(r'([a-z0-9])([A-Z])', r'\1 \2', text)
		return re.sub(r'([A-Z]+)([A-Z][a-z])', r'\1 \2', s)