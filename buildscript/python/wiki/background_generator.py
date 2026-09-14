import os
import re
from typing import assert_never

from antlr import Antlr4Runner
from antlr.listener.background_base_attr_listener import BackgroundBaseAttrListener, BackgroundBaseAttrAST
from antlr.listener.background_defs_listener import BackgroundDefsListener, BackgroundDefAST
from antlr.listener.background_perk_trees_listener import BackgroundPerkTreesListener, PerkTreesAST
from antlr.listener.background_stats_listener import Concrete, Clone, StatType, StatRange
from antlr.listener.background_stats_listener import BackgroundStatsListener, BackgroundStatAST
from antlr.listener.perk_tree_listener import PerkTreeDefAST, PerkTreeListener
from wiki.generator import Generator
from wiki.perk_tree_generator import PerkTreeGenerator


# noinspection method-may-be-static
class BackgroundGenerator(Generator):
	DETAILS_START = "<tr><td colspan=\"9\"><details><summary>{title}</summary>\n"
	DETAILS_END = "</details></td></tr>\n"

	TEMPLATE_STAT_ROW = """
<tr align="center">
  <td></td>
  <td><img src="ui/icons/health.png"/></td>
  <td><img src="ui/icons/melee_skill.png"/></td>
  <td><img src="ui/icons/ranged_skill.png"/></td>
  <td><img src="ui/icons/melee_defense.png"/></td>
  <td><img src="ui/icons/ranged_defense.png"/></td>
  <td><img src="ui/icons/fatigue.png"/></td>
  <td><img src="ui/icons/bravery.png"/></td>
  <td><img src="ui/icons/initiative.png"/></td>
</tr>
""".strip()

	TEMPLATE_ATTR_RANGE = """
<tr>
  <td align="left"><b>{title}</b></td>
  <td>{hp_min}<br>{hp_max}</td>
  <td>{matk_min}<br>{matk_max}</td>
  <td>{ratk_min}<br>{ratk_max}</td>
  <td>{mdef_min}<br>{mdef_max}</td>
  <td>{rdef_min}<br>{rdef_max}</td>
  <td>{fat_min}<br>{fat_max}</td>
  <td>{res_min}<br>{res_max}</td>
  <td>{ini_min}<br>{ini_max}</td>
</tr>
""".strip()

	TEMPLATE_BG = """
<tr>
  <td colspan="7" align="left">
	<img src="{icon}" align="center" />
	<b>{name}</b>
  </td>
  <td colspan="2" align="right">
	<img src="ui/icons/asset_daily_money.png" align="center" />
	<b>{wage}</b>
  </td>
</tr>
""".strip()

	TEMPLATE_PERK_TREES = """
<tr>
  <td align="left">
	<b>Guaranteed Perk Trees</b>
  </td>
  <td colspan="8" align="left">
	{perks}
  </td>
</tr>	
""".strip()

	def __init__(self, root, output_path):
		self.root = root
		self.output_path = output_path

	def process(self):
		all_trees: dict[str, PerkTreeDefAST] = {
			tree.target.split('.')[-1]: tree
			for f in PerkTreeGenerator.PERK_FILES
			for tree in self._get_all_trees(f)
			if tree.target is not None
		}
		perk_trees = self._get_perk_trees() or {}
		base = self._get_base() or {}
		stats = self._get_stats() or {}
		defs = self._get_defs() or {}
		output = [
			"# WIP",
			f"## Base stats"
		]
		for const in  sorted(base.keys()):
			output.append(f"### {self._convert_const(const)}")
			output.append(self.TABLE_START)
			output.append(self.TEMPLATE_STAT_ROW)
			output.append(self._format(self.TEMPLATE_ATTR_RANGE, self._mock_bg_def(const), base[const].stats, title="Attribute Range"))
			output.append(self.TABLE_END)

		output.append(f"## Backgrounds")

		for const in sorted(defs.keys()):
			entry = defs[const]
			stat = stats[const]
			bstat = base["Default"]
			output.append(f"#### {self._convert_const(const)}")
			output.append(self.TABLE_START)
			output.append(self._format(self.TEMPLATE_BG, entry, stat))
			output.append(self.TEMPLATE_STAT_ROW)
			output.append(self._format(self.TEMPLATE_ATTR_RANGE, entry, stat, title="Attribute Range"))
			output.append(self.DETAILS_START.format(title="Click to expand for more details"))
			output.append(self.TABLE_START)
			output.append(self.TEMPLATE_STAT_ROW)
			output.append(self._format(self.TEMPLATE_ATTR_RANGE, entry, bstat.add_stats(stat), title="Full Attribute Range"))
			output.append(self._render_perk_tree(perk_trees.get(const, PerkTreesAST()), all_trees))
			output.append(self.TABLE_END)
			output.append(self.DETAILS_END)
			output.append(self.TABLE_END)

		os.makedirs(self.root / self.output_path, exist_ok=True)
		with open((self.root / self.output_path / "Backgrounds.md").resolve(), "w", encoding="utf-8") as f:
			f.write("\n".join(output))

	def _format(self, template, entry, stat, title=""):
		def get_stat_val(stat_dict, stat_type, attr):
			s = stat_dict.get(stat_type)
			return getattr(s, attr) if s is not None else "0"

		return template.format(
			title=title,
			icon=entry.icon,
			name=entry.name,
			level=0,
			wage=entry.daily_cost,
			# Min values
			hp_min=get_stat_val(stat, StatType.HITPOINTS, "min_val"),
			matk_min=get_stat_val(stat, StatType.MELEE_SKILL, "min_val"),
			ratk_min=get_stat_val(stat, StatType.RANGED_SKILL, "min_val"),
			mdef_min=get_stat_val(stat, StatType.MELEE_DEFENSE, "min_val"),
			rdef_min=get_stat_val(stat, StatType.RANGED_DEFENSE, "min_val"),
			fat_min=get_stat_val(stat, StatType.STAMINA, "min_val"),
			res_min=get_stat_val(stat, StatType.BRAVERY, "min_val"),
			ini_min=get_stat_val(stat, StatType.INITIATIVE, "min_val"),
			# Max values
			hp_max=get_stat_val(stat, StatType.HITPOINTS, "max_val"),
			matk_max=get_stat_val(stat, StatType.MELEE_SKILL, "max_val"),
			ratk_max=get_stat_val(stat, StatType.RANGED_SKILL, "max_val"),
			mdef_max=get_stat_val(stat, StatType.MELEE_DEFENSE, "max_val"),
			rdef_max=get_stat_val(stat, StatType.RANGED_DEFENSE, "max_val"),
			fat_max=get_stat_val(stat, StatType.STAMINA, "max_val"),
			res_max=get_stat_val(stat, StatType.BRAVERY, "max_val"),
			ini_max=get_stat_val(stat, StatType.INITIATIVE, "max_val"),
		)

	def _mock_bg_def(self, name):
		return BackgroundDefAST("", "", name, name, "", "", "")

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


	def _get_base(self) -> dict[str, BackgroundBaseAttrAST] | None:
		result: dict[str, BackgroundBaseAttrAST] = {}
		code = self.get_content((self.root / "mod_legends/!!config/character_backgrounds.nut").resolve())
		try:
			entries: list[BackgroundBaseAttrAST] = Antlr4Runner.run(
				code, BackgroundBaseAttrListener()
			).entries

			for entry in entries:
				result[entry.target] = entry

			return result
		except Exception as e:
			print(f"Error parsing background defs: {str(e)}")
			return None

	def _get_all_trees(self, file) -> list[PerkTreeDefAST]:
		return Antlr4Runner.run(
			self.get_content((self.root / f"mod_legends/config/{file}").resolve()), PerkTreeListener()
		).entries

	def _get_perk_trees(self) -> dict[str, PerkTreesAST] | None:
		result: dict[str, PerkTreesAST] = {}
		code = self.get_content((self.root / "mod_legends/config/zz_background_perk_trees.nut").resolve())
		try:
			entries: list[PerkTreesAST] = Antlr4Runner.run(
				code, BackgroundPerkTreesListener()
			).entries

			for entry in entries:
				result[str(entry.target.split('.')[-1])] = entry

			return result
		except Exception as e:
			print(f"Error parsing background defs: {str(e)}")
			return None

	def _render_perk_tree(self, tree: PerkTreesAST, all_trees: dict[str, PerkTreeDefAST],  target_file: str = "Perk%20Trees") -> str:
		links = []
		for perk in tree.trees:
			name = self._convert_const(perk.split('.')[-1])
			anchor = str(all_trees.get(perk, PerkTreeDefAST()).name).lower().replace(" ", "-")
			links.append(f'<a href="{target_file}#{anchor}">{name}</a>')

		return self.TEMPLATE_PERK_TREES.format(perks="<br>".join(links))

	def _convert_const(self, text: str) -> str:
		s = re.sub(r'([a-z0-9])([A-Z])', r'\1 \2', text)
		return re.sub(r'([A-Z]+)([A-Z][a-z])', r'\1 \2', s)