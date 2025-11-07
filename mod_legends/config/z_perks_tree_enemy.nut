if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.BeastsTree <- {
	ID = "BeastsTree",
	Name = "Beasts",
	Descriptions = [
		"beasts"
	],
	
	Tree = [
		[],
		[],
		[],
		[
			::Legends.Perk.LegendFavouredEnemyGhoul,
			::Legends.Perk.LegendFavouredEnemyDirewolf,
			::Legends.Perk.LegendFavouredEnemySpider
		],
		[],
		[::Legends.Perk.LegendFavouredEnemyLindwurm],
		[]
	]
};

::Const.Perks.GhoulTree <- {
	ID = "GhoulTree",
	Name = "Nachzehrers",
	Descriptions = [
		"nachzehrers"
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
	Name = "Direwolves",
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
	Name = "Webknechts",
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
	Name = "Lindwurms",
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
	Name = "Mystics",
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
	Name = "Schrats",
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
	Name = "Hexen",
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
	Name = "Alps",
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
	Name = "Undead",
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
	Name = "Ancient Empire",
	Descriptions = [
		"ancient empire"
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
	Name = "Wiedergangers",
	Descriptions = [
		"wiedergangers"
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
	Name = "Necrosavants",
	Descriptions = [
		"necrosavants"
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
	Name = "Greenskins",
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
	Name = "Orcs",
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
	Name = "Goblins",
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
	Name = "Unholds",
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
	Name = "Civilians",
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
	Name = "Caravans",
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
	Name = "Mercenaries",
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
	Name = "Nobles",
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
	Name = "Outlanders",
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
	Name = "Bandits",
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
	Name = "Barbarians",
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
	Name = "Sharpshooters",
	Descriptions = [
		"sharpshooter"
	],
	Tree = [
		[::Legends.Perk.Pathfinder],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyArcher],
		[]
	]
};

::Const.Perks.ArcherTree <- {
	ID = "ArcherTree",
	Name = "Archers"
	Descriptions = [
		"archers"
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
	Name = "Swordmasters",
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
	Name = "Southerners",
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
	Name = "Nomads",
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
