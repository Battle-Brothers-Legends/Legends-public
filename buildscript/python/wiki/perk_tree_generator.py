import os
import re
from typing import assert_never

from antlr import Antlr4Runner
from antlr.listener.perk_tree_listener import PerkTreeListener, PerkTreeDefAST
from wiki.generator import Generator


# noinspection method-may-be-static
class PerkTreeGenerator(Generator):
	PERK_FILES = (
		"z_perks_tree_class.nut",
		"z_perks_tree_defense.nut",
		"z_perks_tree_enemy_armor.nut",
		"z_perks_tree_enemy_traits.nut",
		"z_perks_tree_magic.nut",
		"z_perks_tree_profession.nut",
		"z_perks_tree_traits.nut",
		"z_perks_tree_weapons.nut",
	)

	TEMPLATE_TITLE_ROW = """
<tr>
  <td colspan="2"><img src="{icon}"/><b>{text}</b></td>
</tr>
""".strip()
	TEMPLATE_HEADER_ROW = """
<tr align="center">
  <td>Tier</td>
  <td>Perk</td>
</tr>
""".strip()

	TEMPLATE_PERK_ROW = """
<tr align="center">
  <td>{tier}</td>
  <td>{perk}</td>
</tr>
""".strip()

	def __init__(self, root, output_path):
		self.root = root
		self.output_path = output_path

	def process(self):
		trees: list[PerkTreeDefAST] = [tree for f in self.PERK_FILES for tree in self._get_trees(f)]

		output = [f"## Perk trees"]
		for tree in  sorted(trees, key=lambda tree: tree.name):
			output.append(f"### {tree.name}\n")
			output.append(self.TABLE_START)
			output.append(self.TEMPLATE_TITLE_ROW.format(icon=tree.icon, text=tree.name))
			output.append(self.TEMPLATE_HEADER_ROW)
			for perk in tree.tree:
				output.append(self.TEMPLATE_PERK_ROW.format(perk=perk.name, tier=perk.tier))
			output.append(self.TABLE_END)

		os.makedirs(self.root / self.output_path, exist_ok=True)
		with open((self.root / self.output_path / "Perk Trees.md").resolve(), "w", encoding="utf-8") as f:
			f.write("\n".join(output))

	def _get_trees(self, file) -> list[PerkTreeDefAST]:
		return Antlr4Runner.run(
			self.get_content((self.root / f"mod_legends/config/{file}").resolve()), PerkTreeListener()
		).entries
