if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.HealerProfessionTree <- {
	ID = "HealerProfessionTree",
	Name = "Healing",
	Descriptions = [
		"healing"
	],
	Tree = [
		[::Legends.Perk.LegendMedIngredients],
		[],
		[],
		[::Legends.Perk.LegendSpecBandage],
		[],
		[],
		[::Legends.Perk.LegendFieldTriage]
	]
};

::Const.Perks.ChefProfessionTree <- {
	ID = "ChefProfessionTree",
	Name = "Chef",
	Descriptions = [
		"cooking"
	],
	Tree = [
		[::Legends.Perk.LegendMealPreperation],
		[::Legends.Perk.LegendCampCook],
		[::Legends.Perk.LegendAlcoholBrewing],
		[],
		[],
		[::Legends.Perk.LegendQuartermaster],
		[::Legends.Perk.LegendFieldTreats]
	]
};

::Const.Perks.RepairProfessionTree <- {
	ID = "RepairProfessionTree",
	Name = "Repair",
	Descriptions = [
		"repairs"
	],
	Tree = [
		[],
		[::Legends.Perk.LegendToolsDrawers],
		[::Legends.Perk.LegendToolsSpares],
		[],
		[],
		[],
		[::Legends.Perk.LegendFieldRepairs]
	]
};

::Const.Perks.BarterProfessionTree <- {
	ID = "BarterProfessionTree",
	Name = "Barter",
	Descriptions = [
		"bartering"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Perk.LegendBarterConvincing
		],
		[],
		[
			::Legends.Perk.LegendBarterTrustworthy
		],
		[
			::Legends.Perk.LegendDangerPay,
			::Legends.Perk.LegendPaymaster
		],
		[
			::Legends.Perk.LegendOffBookDeal,
			::Legends.Perk.LegendBarterGreed
		]
	]
};

::Const.Perks.DogBreederProfessionTree <- {
	ID = "DogBreederProfessionTree",
	Name = "Dog Breeder",
	Descriptions = [
		"breeding dogs"
	],
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.LegendDogBreeder],
		[],
		[],
		[]
	]
};

::Const.Perks.MinerProfessionTree <- {
	ID = "MinerProfessionTree",
	Name = "Mining",
	Descriptions = [
		"mining"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendOreHunter],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.WoodworkingProfessionTree <- {
	ID = "WoodworkingProfessionTree",
	Name = "Woodworking",
	Descriptions = [
		"woodworking"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendWoodworking],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.HerbalistProfessionTree <- {
	ID = "HerbalistProfessionTree",
	Name = "Herbalism",
	Descriptions = [
		"herbalism"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendGatherer],
		[::Legends.Perk.LegendHerbcraft],
		[::Legends.Perk.LegendPotionBrewer]
	]
};

::Const.Perks.ProfessionTrees <- {
	Tree = [
		::Const.Perks.BarterProfessionTree,
		::Const.Perks.ChefProfessionTree,
		::Const.Perks.DogBreederProfessionTree,
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.HerbalistProfessionTree,
		::Const.Perks.MinerProfessionTree,
		::Const.Perks.RepairProfessionTree,
		::Const.Perks.WoodworkingProfessionTree,
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
