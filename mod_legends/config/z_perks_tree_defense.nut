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
		[::Legends.Perk.Brawny],
		[::Legends.Perk.Steadfast],
		[],
		[],
		[::Legends.Perk.BattleForged],
		[::Legends.Perk.LegendImmovableObject]
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
			::Legends.Perk.LegendBalance
		],
		[
			::Legends.Perk.LegendPerfectFit
		],
		[],
		[],
		[
			::Legends.Perk.LegendLithe
		],
		[
			::Legends.Perk.LegendSwagger
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
			::Legends.Perk.Dodge
		],
		[
			::Legends.Perk.LegendOnslaught,
			::Legends.Perk.SteelBrow
		],
		[],
		[],
		[
			::Legends.Perk.Nimble
		],
		[]
	]
};

::Const.Perks.ClothArmorTree <- {
	ID = "ClothArmorTree",
	Name = "Cloth Armor",
	Descriptions = [
		"cloth armor"
	],
	Tree = [
		[],
		[
			::Legends.Perk.LegendHimshaw
		],
		[
			::Legends.Perk.LegendEvasion
		],
		[],
		[],
		[
			::Legends.Perk.LegendFashionable
		],
		[
			::Legends.Perk.LegendFreedomOfMovement
		]
	]
};


//::Const.Perks.HelmetTree <- {
	//ID = "HelmetTree",
	//Descriptions = [
	//	"helmets"
	//],
	//Tree = [
	//	[::Legends.Perk.LegendLookout],
	//	[::Legends.Perk.SteelBrow],
	//	[],//::Legends.Perk.
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
