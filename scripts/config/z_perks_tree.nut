local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

local VanillaTree = [
	[
		gt.Const.Perks.PerkDefs.FastAdaption,
		gt.Const.Perks.PerkDefs.CripplingStrikes,
		gt.Const.Perks.PerkDefs.Colossus,
		gt.Const.Perks.PerkDefs.BagsAndBelts,
		gt.Const.Perks.PerkDefs.NineLives,
		gt.Const.Perks.PerkDefs.Pathfinder,
		gt.Const.Perks.PerkDefs.Adrenalin,
		gt.Const.Perks.PerkDefs.Recover,
		gt.Const.Perks.PerkDefs.Student
	],
	[
		gt.Const.Perks.PerkDefs.CoupDeGrace,
		gt.Const.Perks.PerkDefs.Bullseye,
		gt.Const.Perks.PerkDefs.Dodge,
		gt.Const.Perks.PerkDefs.FortifiedMind,
		gt.Const.Perks.PerkDefs.HoldOut,
		gt.Const.Perks.PerkDefs.SteelBrow,
		gt.Const.Perks.PerkDefs.QuickHands,
		gt.Const.Perks.PerkDefs.Gifted
	],
	[
		gt.Const.Perks.PerkDefs.Backstabber,	
		gt.Const.Perks.PerkDefs.Anticipation,
		gt.Const.Perks.PerkDefs.ShieldExpert,
		gt.Const.Perks.PerkDefs.Brawny,
		gt.Const.Perks.PerkDefs.Relentless,
		gt.Const.Perks.PerkDefs.Rotation,
		gt.Const.Perks.PerkDefs.RallyTheTroops,
		gt.Const.Perks.PerkDefs.Taunt
	],
	[
		gt.Const.Perks.PerkDefs.SpecMace,
		gt.Const.Perks.PerkDefs.SpecFlail,
		gt.Const.Perks.PerkDefs.SpecHammer,
		gt.Const.Perks.PerkDefs.SpecAxe,
		gt.Const.Perks.PerkDefs.SpecCleaver,
		gt.Const.Perks.PerkDefs.SpecSword,
		gt.Const.Perks.PerkDefs.SpecDagger,
		gt.Const.Perks.PerkDefs.SpecPolearm,
		gt.Const.Perks.PerkDefs.SpecSpear,
		gt.Const.Perks.PerkDefs.SpecCrossbow,
		gt.Const.Perks.PerkDefs.SpecBow,
		gt.Const.Perks.PerkDefs.SpecThrowing
	],
	[
		gt.Const.Perks.PerkDefs.Underdog,
		gt.Const.Perks.PerkDefs.LoneWolf,
		gt.Const.Perks.PerkDefs.ReachAdvantage,
		gt.Const.Perks.PerkDefs.Overwhelm,
		gt.Const.Perks.PerkDefs.Footwork
	],
	[
		gt.Const.Perks.PerkDefs.HeadHunter,
		gt.Const.Perks.PerkDefs.Berserk,
		gt.Const.Perks.PerkDefs.Nimble,
		gt.Const.Perks.PerkDefs.BattleForged
	],
	[
		gt.Const.Perks.PerkDefs.Fearsome,
		gt.Const.Perks.PerkDefs.Duelist,
		gt.Const.Perks.PerkDefs.KillingFrenzy,
		gt.Const.Perks.PerkDefs.Indomitable
	],
	[],
	[],
	[],
	[]	
];

gt.Const.Perks.DefaultCustomPerkTree <- VanillaTree;

gt.Const.Perks.BuildPerkTreeFromTemplate <- function (_custom) 
{
	local tree = []
	local treeMap = {}

	for( local row = 0; row < VanillaTree.len(); row = ++row )
	{
		local rowL = [];
		for( local i = 0; i < VanillaTree[row].len(); i = ++i )
		{
			local perk = clone this.Const.Perks.PerkDefObjects[VanillaTree[row][i]];
			perk.Row <- row;
			perk.Unlocks <- row;
			rowL.push(perk);
			treeMap[perk.ID] <- perk;
		}

		for( local i = 0; i < _custom[row].len(); i = ++i )
		{
			local perk = clone this.Const.Perks.PerkDefObjects[_custom[row][i]];
			perk.Row <- row;
			perk.Unlocks <- row;
			rowL.push(perk);
			treeMap[perk.ID] <- perk;
		}

		tree.push(rowL);
	}

	return {
		Tree = tree,
		Map = treeMap
	}
};

gt.Const.Perks.BuildCustomPerkTree <- function (_custom) 
{
	local pT = {
		Tree = [],
		Map = {}
	}
	pT.addPerk <- function (_perk, _row=0) 
	{
		local perk = clone this.Const.Perks.PerkDefObjects[_perk];
		//Dont add dupes
		if (perk.ID in this.Map)
		{
			return;
		}
		perk.Row <- _row;
		perk.Unlocks <- _row;
		for (local i = this.Tree.len(); i < _row + 1; i = ++i)
		{
			this.Tree.push([]);
		}
		this.Tree[_row].push(perk);
		this.Map[perk.ID] <- perk;
	}

	for( local row = 0; row < _custom.len(); row = ++row )
	{
		for( local i = 0; i < _custom[row].len(); i = ++i )
		{
			pT.addPerk(_custom[row][i], row)
		}
	}

	return pT;
};


gt.Const.Perks.GetDynamicPerkTree <- function (_mins, _map)
{	
	// _mins = {
	// 	WeaponTrees = 6,
	// 	DefenseTrees = 2,
	// 	TraitsTrees = 8,
	// 	EnemyTrees = 3,
	// 	ClassTrees = 0
	// },
	// _map = {
	// 	WeaponTrees = [],
	// 	DefenseTrees = [],
	// 	TraitsTrees = [],
	// 	EnemyTrees = [],
	// 	ClassTrees = []
	// }	
	//this.logInfo("Getting dynamic perk tree")
	local tree = [ [], [], [], [], [], [], [], [], [], [], [] ];

	local _localMap = {
		Weapon = [],
		Defense = [],
		Traits = [],
		Enemy = [],
		Class = []
	}

	//Clone so we don't overwrite the default character background ones
	foreach (p in _map.Weapon)
	{
		_localMap.Weapon.push(p);
	}
	foreach (p in _map.Defense)
	{
		_localMap.Defense.push(p);
	}
	foreach (p in _map.Traits)
	{
		_localMap.Traits.push(p);
	}
	foreach (p in _map.Enemy)
	{
		_localMap.Enemy.push(p);
	}
	foreach (p in _map.Class)
	{
		_localMap.Class.push(p);
	}

	//Add weapons
	//this.logInfo("*BUILDING WEAPON TREE. NUM START =  " + _map.Weapon.len() + " : MIN = " + _mins.Weapon);
	local count = _mins.Weapon - _localMap.Weapon.len();
	for (local i = 0; i < count; i = ++i)
	{
		local _exclude = [];
		foreach (tt in _localMap.Weapon)
		{
			_exclude.push(tt.ID);
		}
		local t = this.Const.Perks.WeaponTrees.getRandom(_exclude)
		//this.logInfo("Adding weapon perk tree " + t.ID);
		_localMap.Weapon.push(t);
		
	}

	//Add Defense
	local count = _mins.Defense - _localMap.Defense.len();
	for (local i = 0; i < count; i = ++i)
	{
		local _exclude = [];
		foreach (tt in _localMap.Defense)
		{
			_exclude.push(tt.ID);
		}
		local t = this.Const.Perks.DefenseTrees.getRandom(_exclude)
		//this.logInfo("Adding Defense perk tree " + t.ID);
		_localMap.Defense.push(t);
	}

	//Add Traits
	local count = _mins.Traits - _localMap.Traits.len();
	for (local i = 0; i < count; i = ++i)
	{
		local _exclude = [];
		foreach (tt in _localMap.Traits)
		{
			_exclude.push(tt.ID);
		}
		local t = this.Const.Perks.TraitsTrees.getRandom(_exclude)
		//this.logInfo("Adding Traits perk tree " + t.ID);
		_localMap.Traits.push(t);
	}

	//Add Enemy
	local count = _mins.Enemy - _localMap.Enemy.len();
	for (local i = 0; i < count; i = ++i)
	{
		local r = this.Math.rand(0, 100)
		if (r > (_mins.EnemyChance * 100.0))
		{
			continue
		}
		local _exclude = [];
		foreach (tt in _localMap.Enemy)
		{
			_exclude.push(tt.ID);
		}
		local t = this.Const.Perks.EnemyTrees.getRandom(_exclude)
		//this.logInfo("Adding Enemy perk tree " + t.ID);
		_localMap.Enemy.push(t);
	}

	//Add Class
	local count = _mins.Class - _localMap.Class.len();
	for (local i = 0; i < count; i = ++i)
	{
		local r = this.Math.rand(0, 100)
		if (r > (_mins.ClassChance * 100.0))
		{
			continue
		}
		local _exclude = [];
		foreach (tt in _localMap.Class)
		{
			_exclude.push(tt.ID);
		}		
		local t = this.Const.Perks.ClassTrees.getRandom(_exclude)
		//this.logInfo("Adding Class perk tree " + t.ID);
		_localMap.Class.push(t);
	}

	foreach (v in _localMap)
	{
		foreach(mT in v)
		{
			foreach (i, row in mT.Tree)
			{
				foreach(p in row)
				{
					tree[i].push(p);
				}
			}
		}
	}

	return tree;
}

gt.Const.Perks.PerksTreeTemplate <- gt.Const.Perks.BuildCustomPerkTree(VanillaTree)

