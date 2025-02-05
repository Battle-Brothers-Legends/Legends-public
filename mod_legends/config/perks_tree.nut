if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

local VanillaTree = [
	[
		::Const.Perks.PerkDefs.FastAdaption,
		::Const.Perks.PerkDefs.CripplingStrikes,
		::Const.Perks.PerkDefs.Colossus,
		::Const.Perks.PerkDefs.BagsAndBelts,
		::Const.Perks.PerkDefs.NineLives,
		::Const.Perks.PerkDefs.Pathfinder,
		::Const.Perks.PerkDefs.Adrenaline,
		::Const.Perks.PerkDefs.Recover,
		::Const.Perks.PerkDefs.Student
	],
	[
		::Const.Perks.PerkDefs.CoupDeGrace,
		::Const.Perks.PerkDefs.Bullseye,
		::Const.Perks.PerkDefs.Dodge,
		::Const.Perks.PerkDefs.FortifiedMind,
		::Const.Perks.PerkDefs.HoldOut,
		::Const.Perks.PerkDefs.SteelBrow,
		::Const.Perks.PerkDefs.QuickHands,
		::Const.Perks.PerkDefs.Gifted
	],
	[
		::Const.Perks.PerkDefs.Backstabber,
		::Const.Perks.PerkDefs.Anticipation,
		::Const.Perks.PerkDefs.ShieldExpert,
		::Const.Perks.PerkDefs.Brawny,
		::Const.Perks.PerkDefs.LegendOnslaught,
		::Const.Perks.PerkDefs.Rotation,
		::Const.Perks.PerkDefs.RallyTheTroops,
		::Const.Perks.PerkDefs.Taunt
	],
	[
		::Const.Perks.PerkDefs.SpecMace,
		::Const.Perks.PerkDefs.SpecFlail,
		::Const.Perks.PerkDefs.SpecHammer,
		::Const.Perks.PerkDefs.SpecAxe,
		::Const.Perks.PerkDefs.SpecCleaver,
		::Const.Perks.PerkDefs.SpecSword,
		::Const.Perks.PerkDefs.LegendSpecGreatSword,
		::Const.Perks.PerkDefs.SpecDagger,
		::Const.Perks.PerkDefs.SpecPolearm,
		::Const.Perks.PerkDefs.SpecSpear,
		::Const.Perks.PerkDefs.SpecCrossbow,
		::Const.Perks.PerkDefs.SpecBow,
		::Const.Perks.PerkDefs.SpecThrowing
	],
	[
		::Const.Perks.PerkDefs.Underdog,
		::Const.Perks.PerkDefs.LoneWolf,
		::Const.Perks.PerkDefs.ReachAdvantage,
		::Const.Perks.PerkDefs.Overwhelm,
		::Const.Perks.PerkDefs.Footwork
	],
	[
		::Const.Perks.PerkDefs.HeadHunter,
		::Const.Perks.PerkDefs.Berserk,
		::Const.Perks.PerkDefs.Nimble,
		::Const.Perks.PerkDefs.BattleForged
	],
	[
		::Const.Perks.PerkDefs.Fearsome,
		::Const.Perks.PerkDefs.Duelist,
		::Const.Perks.PerkDefs.KillingFrenzy,
		::Const.Perks.PerkDefs.Indomitable
	],
	[],
	[],
	[],
	[]
];

::Const.Perks.DefaultCustomPerkTree <- VanillaTree;

::Const.Perks.BuildPerkTreeFromTemplate <- function (_custom)
{
	local tree = [];
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

::Const.Perks.BuildCustomPerkTree <- function (_custom)
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
		perk.IsRefundable <- true;
		for (local i = this.Tree.len(); i < _row + 1; i = ++i)
		{
			this.Tree.push([]);
		}
		this.Tree[_row].push(perk);
		this.Map[perk.ID] <- perk;
	}

	pT.addTree <- function (_tree)
	{
		foreach(i, row in _tree)
		{
			foreach (p in row)
			{
				this.addPerk(p, i);
			}
		}
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


::Const.Perks.GetDynamicPerkTree <- function (_mins, _map)
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
	local attributes = this.Const.Perks.TraitsTrees.getBaseAttributes();

	local _localMap = {
		Weapon = [],
		Defense = [],
		Traits = [],
		Enemy = [],
		Class = [],
		Magic = []
	}

	//Clone so we don't overwrite the default character background ones
	if ("Weapon" in _map) {
		foreach (p in _map.Weapon)
		{
			_localMap.Weapon.push(p);
		}
	}
	if ("Defense" in _map) {
		foreach (p in _map.Defense)
		{
			_localMap.Defense.push(p);
		}
	}
	if ("Traits" in _map) {
		foreach (p in _map.Traits)
		{
			_localMap.Traits.push(p);
		}
	}
	if ("Enemy" in _map) {
		foreach (p in _map.Enemy)
		{
			_localMap.Enemy.push(p);
		}
	}
	if ("Class" in _map) {
		foreach (p in _map.Class)
		{
			_localMap.Class.push(p);
		}
	}
	if ("Magic" in _map) {
		foreach (p in _map.Magic)
		{
			_localMap.Magic.push(p);
		}
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
		local t = this.Const.Perks.WeaponTrees.getRandom(_exclude);
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
		local t = this.Const.Perks.DefenseTrees.getRandom(_exclude);
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
	for (local i = 0; i <= count; i = ++i)
	{
		local r = this.Math.rand(0, 100);
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
	for (local i = 0; i <= count; i = ++i)
	{
		local r = this.Math.rand(0, 100);
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

	//Add Magic
	local count = _mins.Magic - _localMap.Magic.len();
	for (local i = 0; i <= count; i = ++i)
	{
		local r = this.Math.rand(0, 100);
		if (r > (_mins.MagicChance * 100.0))
		{
			continue
		}
		local _exclude = [];
		foreach (tt in _localMap.Magic)
		{
			_exclude.push(tt.ID);
		}
	}

	local _totals = {}
	local _overflows = {}
	foreach (v in _localMap)
	{
		foreach(mT in v)
		{
			foreach (i, row in mT.Tree)
			{
				if (!(i in _totals)) {
					_totals[i] <- 0
					_overflows[i] <- []
				}

				foreach(j, p in row)
				{
					if (_totals[i] >= 13)
					{
						_overflows[i].push(p)
						continue
					}
					_totals[i]++
					tree[i].push(p);
				}
			}
		}
	}

	//Handle overlow of perks in a row
	// local _direction = 1
	foreach (index, L in _overflows)
	{
		local nextIndex = index;
		local foundIndexToSlot = true;
		for (local i = 0; i < L.len(); i = ++i)
		{
			while (nextIndex < 7 && _totals[nextIndex] >= 13 ) { //assume we start index 6, last row
				nextIndex++; //attatch to row 7, actually tier 8 of perk tree
				if (nextIndex > 6) { //adds new index to our tree for this
					foundIndexToSlot = false //if this is ever false than our starting row and everything past it is overflowed, so we go back one
				}
			}
			if (foundIndexToSlot == false)
			{
				nextIndex = index
				foundIndexToSlot = true;
				while(nextIndex > 0 && _totals[nextIndex] >= 13) { //if nextIndex is ever somehow -1 that means everything past the row it tried was overflow and everything before it, so we just drop the perk then
					nextIndex--;
					if (nextIndex < 0) {
						foundIndexToSlot = false;
					}
				}
			}
			if (foundIndexToSlot) //if we somehow haven't found an index to slot a perk it just gets junked because the entire tree is max perk, guarantees an overflow. can change this
			{
				// this.logWarning("Originally had a perk on index: " + index + ", put it on index: " + nextIndex);
				tree[nextIndex].push(L[i])
				_totals[nextIndex]++
			}
		}
	}

	foreach (t in _localMap.Traits)
	{
		if (t.Attributes)
		{
		local c = t.Attributes;
		attributes.Hitpoints[0] += c.Hitpoints[0];
		attributes.Hitpoints[1] += c.Hitpoints[1];
		attributes.Bravery[0] += c.Bravery[0];
		attributes.Bravery[1] += c.Bravery[1];
		attributes.Stamina[0] += c.Stamina[0];
		attributes.Stamina[1] += c.Stamina[1];
		attributes.MeleeSkill[0] += c.MeleeSkill[0];
		attributes.MeleeSkill[1] += c.MeleeSkill[1];
		attributes.MeleeDefense[0] += c.MeleeDefense[0];
		attributes.MeleeDefense[1] += c.MeleeDefense[1];
		attributes.RangedSkill[0] += c.RangedSkill[0];
		attributes.RangedSkill[1] += c.RangedSkill[1];
		attributes.RangedDefense[0] += c.RangedDefense[0];
		attributes.RangedDefense[1] += c.RangedDefense[1];
		attributes.Initiative[0] += c.Initiative[0];
		attributes.Initiative[1] += c.Initiative[1];
		}
	}

	return {
		Tree = tree,
		Attributes = attributes
	};
}



::Const.Perks.isInTree <- function ( _tree, _perk)
{
	foreach (row in _tree)
	{
		foreach (p in row)
		{
			if (p == _perk)
			{
				return true;
			}
		}
	}
	return false;
}

::Const.Perks.MergeDynamicPerkTree <- function (_tree, _map)
{
	foreach (v in _map)
	{
		foreach(mT in v)
		{
			foreach (i, row in mT.Tree)
			{
				foreach(p in row)
				{
					if (this.Const.Perks.isInTree(_tree, p))
					{
						continue
					}
					_tree[i].push(p);
				}
			}
		}
	}

	return _tree;
}

::Const.Perks.PerksTreeTemplate <- ::Const.Perks.BuildCustomPerkTree(VanillaTree)

