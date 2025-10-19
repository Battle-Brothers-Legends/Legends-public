if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.BeastTree <- {
	ID = "BeastTree",
	Descriptions = [
		"beasts"
	],
	Tree = [
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemyBeast
		],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.MysticTree <- { // this may no longer be needed
	ID = "MysticTree",
	Descriptions = [
		"mystics"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyOccult],
		[]
	]
};

::Const.Perks.OccultTree <- {
	ID = "OccultTree",
	Descriptions = [
		"occult"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyOccult],
		[],
		[]
	]
};

::Const.Perks.UndeadTree <- {
	ID = "UndeadTree",
	Descriptions = [
		"undead"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemyUndead
		],
		[],
		[]
	]
};

::Const.Perks.GreenskinTree <- {
	ID = "GreenskinTree",
	Descriptions = [
		"greenskins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyGreenskins],
		[],
		[]
	]
};

::Const.Perks.CivilizationTree <- {
	ID = "CivilizationTree",
	Descriptions = [
		"law-abiding fools"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyCivilization],
		[],
		[]
	]
};

::Const.Perks.OutlawTree <- {
	ID = "OutlawTree",
	Descriptions = [
		"outlaws"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		 ::Legends.Perk.LegendFavouredEnemyOutlaw,
		],
		[],
		[]
	]
};

::Const.Perks.SwordmastersTree <- {
	ID = "SwordmastersTree",
	Descriptions = [
		"swordmasters"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Perk.Steadfast,
			::Legends.Perk.LegendSmackdown
		],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySwordmaster],
		[]
	]
};

::Const.Perks.EnemyTrees <- {
	Tree = [
		::Const.Perks.BeastTree,
		::Const.Perks.OccultTree,
		::Const.Perks.UndeadTree,
		::Const.Perks.GreenskinTree,
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree,
		::Const.Perks.SwordmastersTree,
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}


	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree)
		{
			foreach (p in row)
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}

};
