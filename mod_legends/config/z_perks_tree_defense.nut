if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.HeavyArmorTree <- {
	ID = "HeavyArmorTree",
	Name = "Heavy Armor",
	Descriptions = [
		"heavy armor"
	],
	Tree = [
		[],
		[::Const.Perks.PerkDefs.SteelBrow],
		[::Const.Perks.PerkDefs.Brawny],
		[],
		[],
		[::Const.Perks.PerkDefs.BattleForged],
		[::Const.Perks.PerkDefs.LegendFullForce]
	]
};

::Const.Perks.MediumArmorTree <- {
	ID = "MediumArmorTree",
	Name = "Medium Armor",
	Descriptions = [
		"medium armor"
	],
	Tree = [
		[],
		[
			::Const.Perks.PerkDefs.LegendBalance
		],
		[
			::Const.Perks.PerkDefs.LegendPerfectFit
		],
		[],
		[],
		[
			::Const.Perks.PerkDefs.LegendLithe
		],
		[
			::Const.Perks.PerkDefs.LegendInTheZone
		]
	]
};

::Const.Perks.LightArmorTree <- {
	ID = "LightArmorTree",
	Name = "Light Armor",
	Descriptions = [
		"light armor"
	],
	Tree = [
		[],
		[
			::Const.Perks.PerkDefs.Dodge
		],
		[
			::Const.Perks.PerkDefs.LegendOnslaught
		],
		[],
		[],
		[
			::Const.Perks.PerkDefs.Nimble
		],
		[
			::Const.Perks.PerkDefs.LegendFreedomOfMovement
		]
	]
};

::Const.Perks.ClothArmorTree <- {
	ID = "ClothArmorTree",
	Name = "Cloth Armor",
	Descriptions = [
		"cloth armor"
	],
	Tree = [
		[
			::Const.Perks.PerkDefs.LegendBlendIn
		],
		[],
		[
			::Const.Perks.PerkDefs.LegendSmallTarget
		],
		[],
		[],
		[
			::Const.Perks.PerkDefs.LegendFashionable
		],
		[
			::Const.Perks.PerkDefs.LegendUnburdened
		]
	]
};


//::Const.Perks.HelmetTree <- {
	//ID = "HelmetTree",
	//Descriptions = [
	//	"helmets"
	//],
	//Tree = [
	//	[::Const.Perks.PerkDefs.LegendLookout],
	//	[::Const.Perks.PerkDefs.SteelBrow],
	//	[],//::Const.Perks.PerkDefs.
	//	[],
	//	[],
	//	[],
	//	[]
	//]
//};

::Const.Perks.DefenseTrees <- {
	Tree = [
		//::Const.Perks.ShieldTree,
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.MediumArmorTree,
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
		//::Const.Perks.HelmetTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID) != null)
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
