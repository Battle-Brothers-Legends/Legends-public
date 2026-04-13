if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.HealerProfessionTree <- {
	ID = "HealerProfessionTree",
	Name = "Apothecary",
	Icon = "ui/perks/MaxMedsT2.png",
	Descriptions = [
		"medical ingredients"
	],
	Tree = [
		[::Legends.Perk.LegendMedIngredients],
		[],
		[],
		[],
		[::Legends.Perk.LegendMedPackages],
		[],
		[]
	]
};

::Const.Perks.ChefProfessionTree <- {
	ID = "ChefProfessionTree",
	Name = "Chef",
	Icon = "ui/perks/meal_prep_circle.png",
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
	Icon = "ui/perks/MaxToolsT1.png",
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
	Icon = "ui/perks/BarterT1.png",
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
	Icon = "ui/perks/perk_dogs.png",
	Descriptions = [
		"breeding dogs"
	],
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.LegendDogBreeder],
		[::Legends.Perk.LegendHippology],
		[],
		[]
	]
};

::Const.Perks.MinerProfessionTree <- {
	ID = "MinerProfessionTree",
	Name = "Mining",
	Icon = "ui/perks/pickaxe_02.png",
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
	Icon = "ui/perks/woodworking.png",
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

::Const.Perks.CaravaneerProfessionTree <- {
	ID = "CaravaneerProfessionTree",
	Name = "Caravaneering",
	Icon = "ui/perks/wheel_maintenance.png",
	Descriptions = [
		"caravaneering"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Perk.LegendEfficientPacking
		],
		[],
		[
			::Legends.Perk.LegendHippology,
			::Legends.Perk.LegendSkillfulStacking
		],
		[
			::Legends.Perk.LegendWheelMaintenance
		],
		[]
	]
};

::Const.Perks.HerbalistProfessionTree <- {
	ID = "HerbalistProfessionTree",
	Name = "Herbalism",
	Icon = "ui/perks/herbs_circle.png",
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

::Const.Perks.FencingTeacherProfessionTree <- {
	ID = "FencingTeacherProfessionTree",
	Name = "Master Trainer",
	Icon = "ui/perks/perk_training_01.png",
	Descriptions = [
		"training"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendMasterTrainer,
			::Legends.Perk.LegendWhipThemInShape
		]
	]
};

::Const.Perks.ProfessionTrees <- {
	GroupsCategory = "Profession",
	Tree = [
		::Const.Perks.BarterProfessionTree,
		::Const.Perks.CaravaneerProfessionTree,
		::Const.Perks.ChefProfessionTree,
		::Const.Perks.DogBreederProfessionTree,
		::Const.Perks.FencingTeacherProfessionTree,
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
