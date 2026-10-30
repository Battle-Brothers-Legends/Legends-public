if (!("Perks" in ::Const)) {
	::Const.Perks <- {};
}

local category = "Enemy";
::Const.Perks.SwordmastersTree <- {
	ID = "SwordmastersTree",
	Name = "Swordmasters",
	Icon = "ui/perks/legend_favoured_enemy_swordmaster.png",
	Category = category,
	Descriptions = [
		"swordmasters"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.Steadfast, ::Legends.Perk.LegendSmackdown],
		[],
		[],
		[],
		[::Legends.Perk.BattleFlow]
	]
};

::Const.Perks.EnemyTrees <- {
	GroupsCategory = "Enemy",
	Tree = [
		::Const.Perks.SwordmastersTree,
	],
	function getRandom(_exclude) {
		local L = [];
		foreach (i, t in this.Tree) {
			if (_exclude != null && _exclude.find(t.ID)) {
				continue;
			}
			L.push(i);
		}

		local r = ::Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}


	function getRandomPerk() {
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree) {
			foreach (p in row) {
				L.push(p);
			}
		}

		local r = ::Math.rand(0, L.len() - 1);
		return L[r];
	}

};
