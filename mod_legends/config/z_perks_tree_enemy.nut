if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.BeastsTree <- {
	ID = "BeastsTree",
	Descriptions = [
		"beasts"
	],
	Tree = [
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemyGhoul,
		::Legends.Perk.LegendFavouredEnemyDirewolf,
		::Legends.Perk.LegendFavouredEnemySpider
		],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyLindwurm],
		[]
	]
};

::Const.Perks.GhoulTree <- {
	ID = "GhoulTree",
	Descriptions = [
		"ghouls"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyGhoul],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.DirewolfTree <- {
	ID = "DirewolfTree",
	Descriptions = [
		"direwolves"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyDirewolf],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.SpiderTree <- {
	ID = "SpiderTree",
	Descriptions = [
		"spiders"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySpider],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.LindwurmTree <- {
	ID = "LindwurmTree",
	Descriptions = [
		"lindwurms"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyLindwurm],
		[]
	]
};

::Const.Perks.MysticTree <- {
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
		[::Legends.Perk.LegendFavouredEnemySchrat],
		[
		::Legends.Perk.LegendFavouredEnemyHexen,
		::Legends.Perk.LegendFavouredEnemyAlps
		]
	]
};

::Const.Perks.SchratTree <- {
	ID = "SchratTree",
	Descriptions = [
		"schrats"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySchrat],
		[]
	]
};

::Const.Perks.HexenTree <- {
	ID = "HexenTree",
	Descriptions = [
		"hexen"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyHexen]
	]
};

::Const.Perks.AlpTree <- {
	ID = "AlpTree",
	Descriptions = [
		"alps"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyAlps]
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
		::Legends.Perk.LegendFavouredEnemySkeleton,
		::Legends.Perk.LegendFavouredEnemyZombie
		],
		[],
		[::Legends.Perk.LegendFavouredEnemyVampire]
	]
};

::Const.Perks.SkeletonTree <- {
	ID = "SkeletonTree",
	Descriptions = [
		"skeletons"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySkeleton],
		[],
		[]
	]
};

::Const.Perks.ZombieTree <- {
	ID = "ZombieTree",
	Descriptions = [
		"zombies"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyZombie],
		[],
		[]
	]
};

::Const.Perks.VampireTree <- {
	ID = "VampireTree",
	Descriptions = [
		"vampires"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyVampire]
	]
};

::Const.Perks.OrcsTree <- {
	ID = "OrcsTree",
	Descriptions = [
		"greenskins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemyOrk,
		::Legends.Perk.LegendFavouredEnemyGoblin
		],
		[::Legends.Perk.LegendFavouredEnemyUnhold],
		[]
	]
};

::Const.Perks.OrcTree <- {
	ID = "OrcTree",
	Descriptions = [
		"orcs"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyOrk],
		[],
		[]
	]
};

::Const.Perks.GoblinTree <- {
	ID = "GoblinTree",
	Descriptions = [
		"goblins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyGoblin],
		[],
		[]
	]
};

::Const.Perks.UnholdTree <- {
	ID = "UnholdTree",
	Descriptions = [
		"unholds"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyUnhold],
		[]
	]
};

::Const.Perks.CivilizationTree <- {
	ID = "CivilizationTree",
	Descriptions = [
		"civilians"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyCaravan],
		[],
		[::Legends.Perk.LegendFavouredEnemyMercenary],
		[::Legends.Perk.LegendFavouredEnemyNoble,
		 ::Legends.Perk.LegendFavouredEnemySoutherner
		],
		[]
	]
};

::Const.Perks.CaravanTree <- {
	ID = "CaravanTree",
	Descriptions = [
		"caravans"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyCaravan],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.MercenaryTree <- {
	ID = "MercenaryTree",
	Descriptions = [
		"mercenaries"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyMercenary],
		[],
		[]
	]
};

::Const.Perks.NoblesTree <- {
	ID = "NoblesTree",
	Descriptions = [
		"nobles"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyNoble],
		[]
	]
};

::Const.Perks.OutlandersTree <- {
	ID = "OutlandersTree",
	Descriptions = [
		"outlanders"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		 ::Legends.Perk.LegendFavouredEnemyBandit,
		 ::Legends.Perk.LegendFavouredEnemyNomad
		 ],
		[::Legends.Perk.LegendFavouredEnemyBarbarian],
		[]
	]
};

::Const.Perks.BanditTree <- {
	ID = "BanditTree",
	Descriptions = [
		"bandits"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyBandit],
		[],
		[]
	]
};

::Const.Perks.BarbarianTree <- {
	ID = "BarbariansTree",
	Descriptions = [
		"barbarians"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyBarbarian],
		[]
	]
};

::Const.Perks.ArchersTree <- {
	ID = "ArchersTree",
	Descriptions = [
		"archers"
	],
	Tree = [
		[::Legends.Perk.Pathfinder],
		[],
		[],
		[],
		[::Legends.Perk.Footwork],
		[::Legends.Perk.LegendFavouredEnemyArcher],
		[]
	]
};

::Const.Perks.ArcherTree <- {
	ID = "ArcherTree",
	Descriptions = [
		"archer"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyArcher],
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

::Const.Perks.SouthernersTree <- {
	ID = "SouthernersTree",
	Descriptions = [
		"southerners"
	],
	Tree = [
		[],
		[::Legends.Perk.LegendTrueBeliever],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySoutherner],
		[]
	]
};

::Const.Perks.NomadsTree <- {
	ID = "NomadsTree",
	Descriptions = [
		"nomads"
	],
	Tree = [
		[::Legends.Perk.Pathfinder],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyNomad],
		[],
		[]
	]
};

::Const.Perks.EnemyTrees <- {
	Tree = [
		::Const.Perks.GhoulTree,
		::Const.Perks.DirewolfTree,
		::Const.Perks.SpiderTree,
		::Const.Perks.SchratTree,
		::Const.Perks.HexenTree,
		::Const.Perks.AlpTree,
		::Const.Perks.SkeletonTree,
		::Const.Perks.ZombieTree,
		::Const.Perks.VampireTree,
		::Const.Perks.OrcTree,
		::Const.Perks.GoblinTree,
		::Const.Perks.UnholdTree,
		::Const.Perks.CaravanTree,
		::Const.Perks.MercenaryTree,
		::Const.Perks.NoblesTree,
		::Const.Perks.BanditTree,
		::Const.Perks.BarbarianTree,
		::Const.Perks.ArchersTree,
		::Const.Perks.SwordmastersTree,
		::Const.Perks.SouthernersTree
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

		local r = this.Math.rand(0, L.len() - 1)
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
