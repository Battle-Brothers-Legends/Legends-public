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
		::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
		::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
		::Const.Perks.PerkDefs.LegendFavouredEnemySpider
		],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemySpider],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemySchrat],
		[
		::Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
		::Const.Perks.PerkDefs.LegendFavouredEnemyAlps
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemySchrat],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyHexen]
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyAlps]
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
		::Const.Perks.PerkDefs.LegendFavouredEnemySkeleton,
		::Const.Perks.PerkDefs.LegendFavouredEnemyZombie
		],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyVampire]
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemySkeleton],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyZombie],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyVampire]
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
		::Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
		::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin
		],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyUnhold],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyOrk],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyUnhold],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyMercenary],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
		 ::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyMercenary],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyNoble],
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
		 ::Const.Perks.PerkDefs.LegendFavouredEnemyBandit,
		 ::Const.Perks.PerkDefs.LegendFavouredEnemyNomad
		 ],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyBandit],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian],
		[]
	]
};

::Const.Perks.ArchersTree <- {
	ID = "ArchersTree",
	Descriptions = [
		"archers"
	],
	Tree = [
		[::Const.Perks.PerkDefs.Pathfinder],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.Footwork],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyArcher],
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
		[::Const.Perks.PerkDefs.LegendFavouredEnemyArcher],
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
			::Const.Perks.PerkDefs.Steadfast,
			::Const.Perks.PerkDefs.LegendSmackdown
		],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster],
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
		[::Const.Perks.PerkDefs.LegendTrueBeliever],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner],
		[]
	]
};

::Const.Perks.NomadsTree <- {
	ID = "NomadsTree",
	Descriptions = [
		"nomads"
	],
	Tree = [
		[::Const.Perks.PerkDefs.Pathfinder],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyNomad],
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
