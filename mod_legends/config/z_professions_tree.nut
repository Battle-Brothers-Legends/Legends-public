if (!("Professions" in ::Const))
{
	::Const.Professions <- {};
}

/*::Const.Professions.HealerProfessionTree <- {
	ID = "HealerProfessionTree",
	Name = "Apothecary",
	Icon = "ui/professions/MaxMedsT2.png",
	Descriptions = [
		"medical ingredients"
	],
	Tree = [
		[::Legends.Profession.LegendMedIngredients],
		[],
		[],
		[],
		[::Legends.Profession.LegendMedPackages],
		[],
		[]
	]
};

::Const.Professions.ChefProfessionTree <- {
	ID = "ChefProfessionTree",
	Name = "Chef",
	Icon = "ui/professions/meal_prep_circle.png",
	Descriptions = [
		"cooking"
	],
	Tree = [
		[::Legends.Profession.LegendMealPreperation],
		[::Legends.Profession.LegendCampCook],
		[::Legends.Profession.LegendAlcoholBrewing],
		[],
		[],
		[::Legends.Profession.LegendQuartermaster],
		[]
	]
};

::Const.Professions.RepairProfessionTree <- {
	ID = "RepairProfessionTree",
	Name = "Repair",
	Icon = "ui/professions/MaxToolsT1.png",
	Descriptions = [
		"repairs"
	],
	Tree = [
		[],
		[::Legends.Profession.LegendToolsDrawers],
		[::Legends.Profession.LegendToolsSpares],
		[],
		[],
		[],
		[]
	]
};

::Const.Professions.BarterProfessionTree <- {
	ID = "BarterProfessionTree",
	Name = "Barter",
	Icon = "ui/professions/BarterT1.png",
	Descriptions = [
		"bartering"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Profession.LegendBarterConvincing
		],
		[],
		[
			::Legends.Profession.LegendBarterTrustworthy
		],
		[
			::Legends.Profession.LegendPaymaster
		],
		[
			::Legends.Profession.LegendOffBookDeal,
			::Legends.Profession.LegendBarterGreed
		]
	]
};

::Const.Professions.DogBreederProfessionTree <- {
	ID = "DogBreederProfessionTree",
	Name = "Dog Breeder",
	Icon = "ui/professions/profession_dogs.png",
	Descriptions = [
		"breeding dogs"
	],
	Tree = [
		[],
		[],
		[],
		[::Legends.Profession.LegendDogBreeder],
		[::Legends.Profession.LegendHippology],
		[],
		[]
	]
};

::Const.Professions.MinerProfessionTree <- {
	ID = "MinerProfessionTree",
	Name = "Mining",
	Icon = "ui/professions/pickaxe_02.png",
	Descriptions = [
		"mining"
	],
	Tree = [
		[],
		[],
		[::Legends.Profession.LegendOreHunter],
		[],
		[],
		[],
		[]
	]
};*/

::Const.Professions.WoodworkingProfessionTree <- {
	ID = "WoodworkingProfessionTree",
	Name = "Woodworking",
	Icon = "ui/professions/woodworking.png",
	Descriptions = [
		"woodworking"
	],
	Tree = [
		[],
		[],
		[::Legends.Profession.LegendWoodworking],
		[],
		[],
		[],
		[]
	]
};

/*::Const.Professions.CaravaneerProfessionTree <- {
	ID = "CaravaneerProfessionTree",
	Name = "Caravaneering",
	Icon = "ui/professions/wheel_maintenance.png",
	Descriptions = [
		"caravaneering"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Profession.LegendEfficientPacking
		],
		[],
		[
			::Legends.Profession.LegendHippology,
			::Legends.Profession.LegendSkillfulStacking
		],
		[
			::Legends.Profession.LegendWheelMaintenance
		],
		[]
	]
};

::Const.Professions.HerbalistProfessionTree <- {
	ID = "HerbalistProfessionTree",
	Name = "Herbalism",
	Icon = "ui/professions/herbs_circle.png",
	Descriptions = [
		"herbalism"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Profession.LegendGatherer],
		[::Legends.Profession.LegendHerbcraft],
		[::Legends.Profession.LegendPotionBrewer]
	]
};

::Const.Professions.FencingTeacherProfessionTree <- {
	ID = "FencingTeacherProfessionTree",
	Name = "Master Trainer",
	Icon = "ui/professions/profession_training_01.png",
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
			::Legends.Profession.LegendMasterTrainer,
			::Legends.Profession.LegendWhipThemInShape
		]
	]
};*/

::Const.Professions.ProfessionTrees <- {
	GroupsCategory = "Profession",
	Tree = [
		/*::Const.Professions.BarterProfessionTree,
		::Const.Professions.CaravaneerProfessionTree,
		::Const.Professions.ChefProfessionTree,
		::Const.Professions.DogBreederProfessionTree,
		::Const.Professions.FencingTeacherProfessionTree,
		::Const.Professions.HealerProfessionTree,
		::Const.Professions.HerbalistProfessionTree,
		::Const.Professions.MinerProfessionTree,
		::Const.Professions.RepairProfessionTree,*/
		::Const.Professions.WoodworkingProfessionTree,
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

	function getRandomProfession()
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
