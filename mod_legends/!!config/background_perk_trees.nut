if (!("BackgroundPerkTrees" in ::Legends)) {
::Legends.BackgroundPerkTrees <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.AdventurousNoble <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.CrossbowTree,
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Anatomist <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.SpearTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.HerbalistProfessionTree,
	],
	Magic = [
		::Const.Perks.PhilosophyMagicTree
	]
};

::Legends.BackgroundPerkTrees.Apprentice <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.HammerTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.AxeTree,
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.IndestructibleTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.FastTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Assassin <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.ThrowingTree,
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.CalmTree,
		::Const.Perks.AgileTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.SwordmastersTree,
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.AssassinMagicTree
	]
};

::Legends.BackgroundPerkTrees.AssassinSouthern <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.FitTree,
		::Const.Perks.AgileTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.AssassinMagicTree
	]
};

::Legends.BackgroundPerkTrees.Barbarian <- {
	Weapon = [
		::Const.Perks.AxeTree,
		::Const.Perks.HammerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.LargeTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
		],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Bastard <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.LargeTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.BeastSlayer <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.BowTree,
		::Const.Perks.AxeTree,
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.AgileTree,
		::Const.Perks.CalmTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.OccultTree,
		::Const.Perks.BeastTree,
	],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Beggar <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SlingTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.CalmTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.BeggarSouthern <- clone ::Legends.BackgroundPerkTrees.Beggar;

::Legends.BackgroundPerkTrees.BellyDancer <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree,
		::Const.Perks.IntelligentTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.JugglerClassTree
	],
	Profession = [],
	Magic = [
		::Const.Perks.BardMagicTree
	]
};

::Legends.BackgroundPerkTrees.Bowyer <- {
	Weapon = [
		::Const.Perks.BowTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Brawler <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree,
		::Const.Perks.FastTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Butcher <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.CalmTree,
		::Const.Perks.LargeTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.ChefProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.ButcherSouthern <- clone ::Legends.BackgroundPerkTrees.Butcher;

::Legends.BackgroundPerkTrees.CaravanHand <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.SpearTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.ShieldTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [
		::Const.Perks.CaravaneerProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.CaravanHandSouthern <- clone ::Legends.BackgroundPerkTrees.CaravanHand;

::Legends.BackgroundPerkTrees.Companion <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.ThrowingTree,
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.FastTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.CompanionSouthern <- clone ::Legends.BackgroundPerkTrees.Companion;

::Legends.BackgroundPerkTrees.Companion2h <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.AxeTree,
		::Const.Perks.SwordTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.CompanionSouthern2h <- clone ::Legends.BackgroundPerkTrees.Companion2h;

::Legends.BackgroundPerkTrees.CompanionRanged <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.BowTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
	],
	Traits = [
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FitTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.CompanionSouthernRanged <- clone ::Legends.BackgroundPerkTrees.CompanionRanged;

::Legends.BackgroundPerkTrees.Cripple <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SlingTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.CrippleSouthern <- clone ::Legends.BackgroundPerkTrees.Cripple;

::Legends.BackgroundPerkTrees.Crucified <- {
	Weapon = [
		::Const.Perks.FlailTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.MaceTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [

		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.FitTree
	],
	Enemy = [
			::Const.Perks.OutlawTree,
			::Const.Perks.CivilizationTree
			],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Crusader <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.UndeadTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.FaithClassTree
	]
};

::Legends.BackgroundPerkTrees.Cultist <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.CivilizationTree
	],
	Class = [
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.ConvertedCultist <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.NinetailsClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Daytaler <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.MaceTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.DaytalerSouthern <- clone ::Legends.BackgroundPerkTrees.Daytaler;

::Legends.BackgroundPerkTrees.Deserter <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.MaceTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.DisownedNoble <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.MartyrTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Eunuch <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.SlingTree,
		::Const.Perks.MaceTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.CalmTree,
		::Const.Perks.MartyrTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.BarterProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.EunuchSouthern <- clone ::Legends.BackgroundPerkTrees.Eunuch;

::Legends.BackgroundPerkTrees.Executioner <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.AxeTree,
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree,
		::Const.Perks.CalmTree
	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.ExecutionerSouthern <- clone ::Legends.BackgroundPerkTrees.Executioner;

::Legends.BackgroundPerkTrees.Farmhand <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.FlailTree,
		::Const.Perks.SlingTree,
		::Const.Perks.CleaverTree,
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Fisherman <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SpearTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree
	],
	Enemy = [
		::Const.Perks.BeastTree
	],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.FishermanSouthern <- clone ::Legends.BackgroundPerkTrees.Fisherman;

::Legends.BackgroundPerkTrees.Flagellant <- {
	Weapon = [
		::Const.Perks.FlailTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.FaithClassTree,
		::Const.Perks.HealerClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Gambler <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.DeviousTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.ConArtistTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.GamblerSouthern <- clone ::Legends.BackgroundPerkTrees.Gambler;

::Legends.BackgroundPerkTrees.Gladiator <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.AgileTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree,
		::Const.Perks.MartyrTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.GladiatorOrigin <- clone ::Legends.BackgroundPerkTrees.Gladiator;

::Legends.BackgroundPerkTrees.Gravedigger <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.HammerTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.UndeadTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Graverobber <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.HammerTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.UndeadTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.HedgeKnight <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.AxeTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.SwordmastersTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Historian <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SpearTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.CalmTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = [
		// ::Const.Perks.CaptainMagicTree,
		::Const.Perks.PhilosophyMagicTree
	]
};

::Legends.BackgroundPerkTrees.Houndmaster <- {
	Weapon = [
		::Const.Perks.ThrowingTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.HoundmasterClassTree
	],
	Profession = [
		::Const.Perks.DogBreederProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Hunter <- {
	Weapon = [
		::Const.Perks.BowTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FitTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.OccultTree,
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Juggler <- {
	Weapon = [
		::Const.Perks.ThrowingTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.FitTree,
		::Const.Perks.FastTree,
		::Const.Perks.CalmTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.JugglerClassTree,
		::Const.Perks.ConArtistTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.JugglerSouthern <- clone ::Legends.BackgroundPerkTrees.Juggler;

::Legends.BackgroundPerkTrees.KillerOnTheRun <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FastTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree
	],
	Profession = [],
	Class = [],
	Magic = [
		::Const.Perks.AssassinMagicTree
	]
};

::Legends.BackgroundPerkTrees.KingsGuard <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.SwordmastersTree
	],
	Class = [],
	Profession = [], 
	Magic = [
		::Const.Perks.ImmortalMagicTree
	]
};

::Legends.BackgroundPerkTrees.LindwurmSlayer <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.BowTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.DeviousTree,
		::Const.Perks.AgileTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.BeastTree
	],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Lumberjack <- {
	Weapon = [
		::Const.Perks.AxeTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.LargeTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.WoodworkingProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Manhunter <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree
	],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Mason <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Messenger <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.FastTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Militia <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FitTree,
		::Const.Perks.AgileTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Miller <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.OrganisedTree,
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.ChefProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Miner <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.IndestructibleTree,
		::Const.Perks.LargeTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [
		::Const.Perks.GreenskinTree,
		::Const.Perks.BeastTree
	],
	Class = [],
	Profession = [
		::Const.Perks.MinerProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Minstrel <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.FastTree,
		::Const.Perks.FitTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [
		::Const.Perks.JugglerClassTree
	],
	Profession = [],
	Magic = [
		::Const.Perks.BardMagicTree,
	]
};

::Legends.BackgroundPerkTrees.Monk <- {
	Weapon = [
		::Const.Perks.FlailTree,
		::Const.Perks.MaceTree,
		::Const.Perks.HammerTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.UndeadTree
	],
	Class = [
		::Const.Perks.FaithClassTree,
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.MonkTurnedFlagellant <- {
	Weapon = [
		::Const.Perks.FlailTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.HammerTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.FaithClassTree
		],
	Profession = [
		::Const.Perks.HealerProfessionTree
	],
	Magic = [
	]
};

::Legends.BackgroundPerkTrees.Nomad <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.MaceTree,
		::Const.Perks.SpearTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.BeastTree,
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.NomadRanged <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.SpearTree,
		::Const.Perks.BowTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.BeastTree,
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.OrcSlayer <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.SwordTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree
	],
	Enemy = [
			::Const.Perks.GreenskinTree,
			::Const.Perks.BeastTree,
			],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.PacifiedFlagellant <- {
	Weapon = [
		::Const.Perks.FlailTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.FaithClassTree
		],
	Profession = [
		::Const.Perks.HealerProfessionTree,
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Paladin <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.MaceTree,
		::Const.Perks.HammerTree,
		::Const.Perks.SwordTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.UndeadTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.PaladinOld <- {
	Weapon = [
		::Const.Perks.AxeTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.LargeTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.FitTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree
	],
	Enemy = [
		::Const.Perks.UndeadTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Peddler <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.MaceTree

	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.OrganisedTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [::Const.Perks.OutlawTree],
	Class = [],
	Profession = [
		::Const.Perks.BarterProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.PeddlerSouthern <- clone ::Legends.BackgroundPerkTrees.Peddler;

::Legends.BackgroundPerkTrees.Pimp <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree
			],
	Class = [],
	Profession = [
		::Const.Perks.BarterProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Poacher <- {
	Weapon = [
		::Const.Perks.BowTree,
		::Const.Perks.SlingTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.AgileTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.GreenskinTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Raider <- {
	Weapon = [
		::Const.Perks.AxeTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FlailTree,
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Ratcatcher <- {
	Weapon = [
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree,
		::Const.Perks.SpearTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.FastTree,
		::Const.Perks.CalmTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Refugee <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FastTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.RegentInAbsentia <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Magic = [
		::Const.Perks.CaptainMagicTree
	],
	Profession = []
};

::Legends.BackgroundPerkTrees.RetiredSoldier <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.ThrowingTree,
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [
		::Const.Perks.FencingTeacherProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Sellsword <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ThrowingTree,
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree
	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Servant <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.OrganisedTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.FastTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.BarterProfessionTree,
		::Const.Perks.ChefProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Shepherd <- {
	Weapon = [
		::Const.Perks.SlingTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree
	],
	Enemy = [::Const.Perks.BeastTree],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.ShepherdSouthern <- clone ::Legends.BackgroundPerkTrees.Shepherd;

::Legends.BackgroundPerkTrees.Slave <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree,
		::Const.Perks.SpearTree,
		::Const.Perks.SlingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.SlaveBarbarian <- {
	Weapon = [
		::Const.Perks.AxeTree,
		::Const.Perks.HammerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.LargeTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.SlaveSouthern <- clone ::Legends.BackgroundPerkTrees.Slave;

::Legends.BackgroundPerkTrees.Squire <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.HammerTree,
		::Const.Perks.CrossbowTree,
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.FitTree,
		::Const.Perks.FastTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Swordmaster <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.CalmTree,
		::Const.Perks.LargeTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.AgileTree
	],
	Enemy = [
		::Const.Perks.SwordmastersTree
	],
	Class = [],
	Profession = [
		::Const.Perks.FencingTeacherProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Tailor <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.TailorClassTree
	],
	Profession = [
		::Const.Perks.RepairProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.Thief <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.BowTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.AgileTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree
	],
	Class = [
		::Const.Perks.ConArtistTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Vagabond <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.IndestructibleTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.FastTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = [];

::Legends.BackgroundPerkTrees.Wildman <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.GreenskinTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.Witchhunter <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.UndeadTree,
		::Const.Perks.OccultTree
	],
	Class = [
		::Const.Perks.PoisonClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendAdventurousLady <- {
	Weapon = [
		::Const.Perks.BowTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SwordTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Class = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendAlchemist <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [ //lf 5
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.OrganisedTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.PoisonClassTree
	]
	Profession = [
		::Const.Perks.BarterProfessionTree,
		::Const.Perks.HerbalistProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCommanderAssassin <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.FlailTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.DeviousTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.FitTree,
		::Const.Perks.CalmTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.LargeTree

	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.CivilizationTree
	],
	Class = [
		::Const.Perks.JugglerClassTree,
		::Const.Perks.PoisonClassTree
	],
	Profession = [],
	Magic = [
		::Const.Perks.AssassinMagicTree,
		::Const.Perks.AssassinLeftoverTree
	]


};;

::Legends.BackgroundPerkTrees.LegendBattleSister <- {
	Weapon = [
		::Const.Perks.FlailTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.AxeTree,
		::Const.Perks.MaceTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.HammerTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FitTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [
		::Const.Perks.UndeadTree
	],
	Class = [
		::Const.Perks.FaithClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCommanderBeggar <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCommanderBeggarScaling <- clone ::Legends.BackgroundPerkTrees.LegendCommanderBeggar;

::Legends.BackgroundPerkTrees.LegendBerserker <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.AxeTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.GreenskinTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.BerserkerMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendCommanderBerserker <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.GreenskinTree,
		::Const.Perks.BeastTree
	],
	Class = [],
	Magic = [
		::Const.Perks.BerserkerMagicTree
	]
};;

::Legends.BackgroundPerkTrees.LegendBlacksmith <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.RepairProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendBladedancer <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.MaceTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.FitTree,
		::Const.Perks.CalmTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.SwordmastersTree,
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendBountyHunter <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.CalmTree,
		::Const.Perks.AgileTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.SwordmastersTree,
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.AssassinMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendCompanionMelee <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.AxeTree,
		::Const.Perks.MaceTree,
		::Const.Perks.SpearTree,
		::Const.Perks.FlailTree,
		::Const.Perks.SwordTree,
		::Const.Perks.HammerTree,
		::Const.Perks.ShieldTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCompanionRanged <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.SpearTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.AxeTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FitTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.TrainedTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendConscript <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FitTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.TrainedTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendConscriptRanged <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FitTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.TrainedTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCrusader <- {
	Weapon = [
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.ShieldTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.FitTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.OccultTree,
		::Const.Perks.BeastTree,
		::Const.Perks.UndeadTree
	],
	Class = [
		::Const.Perks.FaithClassTree
	],
	Profession = [
		::Const.Perks.RepairProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendDervish <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.CleaverTree,
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [ //lf 5
		::Const.Perks.IndestructibleTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.FaithClassTree,
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendDisownedLady <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.BowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree,
		::Const.Perks.TrainedTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Class = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendDonkey <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendDruid <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.FistsTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.HerbalistProfessionTree
	]
	Magic = [
		::Const.Perks.DruidMagicTree,
		::Const.Perks.StavesMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendGladiatorPrizefighter <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.MaceTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.AgileTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree,
		::Const.Perks.MartyrTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendGuildmaster <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.CalmTree,
		::Const.Perks.TrainedTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.OccultTree,
	],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendHerbalist <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.AxeTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.BowTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.AgileTree,
		::Const.Perks.CalmTree
	],
	Enemy = [::Const.Perks.OccultTree],
	Class = [
		::Const.Perks.PoisonClassTree,
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.HerbalistProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendHorse <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendHorseCourser <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendHorseDestrier <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendHorseRouncey <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendHorserider <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendHusk <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree,
		::Const.Perks.MaceTree,
		::Const.Perks.AxeTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FitTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.CivilizationTree
	],
	Class = [
		::Const.Perks.BeastClassTree,
		::Const.Perks.NinetailsClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendIllusionist <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SpearTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.FastTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.OccultTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.IllusionistMagicTree,
		::Const.Perks.PremonitionMagicTree,
		::Const.Perks.StavesMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendInventor <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.OrganisedTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.RepairProfessionTree,
		::Const.Perks.CaravaneerProfessionTree
	],
	Magic = [
		::Const.Perks.PhilosophyMagicTree,
		::Const.Perks.InventorMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendIronmonger <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.AxeTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.IndestructibleTree,
		::Const.Perks.FastTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FitTree
	],
	Enemy = [],
	Class = [],
	Profession = [
		::Const.Perks.RepairProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLeechPeddler <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.AgileTree,
		::Const.Perks.CalmTree
	],
	Enemy = [
		::Const.Perks.BeastTree
	],
	Class = [
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.HerbalistProfessionTree
	],
	Magic = [
	]
};

::Legends.BackgroundPerkTrees.LegendLegionAuxiliary <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLegionCenturion <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLegionGladiator <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree,
		::Const.Perks.JugglerClassTree
	],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendLegionHonourGuard <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
}

::Legends.BackgroundPerkTrees.LegendLegionLegate <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLegionLegionary <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLegionPrefect <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.SlingTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLegionSlave <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendLonewolf <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.HammerTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.FistsTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.SwordmastersTree
	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.ImmortalMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendLurker <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree,
		::Const.Perks.MartyrTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,

	],
	Class = [
		::Const.Perks.BeastClassTree,
		::Const.Perks.NinetailsClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendMagister <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.FlailTree,
		::Const.Perks.SlingTree,
		::Const.Perks.SwordTree,
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree,
		::Const.Perks.CivilizationTree
	],
	Class = [
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.HerbalistProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendManAtArms <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.SpearTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.TrainedTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.FitTree
	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.BeastTree
	],
	Class = [],
	Profession = [
		::Const.Perks.FencingTeacherProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendMasterArcher <- {
	Weapon = [
		::Const.Perks.BowTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.FitTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [

	],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.RangerHuntMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendMuladi <- {
	Weapon = [
		::Const.Perks.BowTree,
		::Const.Perks.SlingTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.AgileTree
	],
	Enemy = [
		::Const.Perks.CivilizationTree
	],
	Class = [
		::Const.Perks.HoundmasterClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendNecro <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCommanderNecro <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendNecromancer <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.BasicNecroMagicTree,
		::Const.Perks.StavesMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendNecrosavant <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Magic = [
		::Const.Perks.VampireMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendNightwatch <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.SturdyTree
	],
	Enemy = [
		::Const.Perks.OccultTree
	],
	Profession = [],
	Class = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCommanderNoble <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SwordTree,
		::Const.Perks.MaceTree,
		::Const.Perks.CrossbowTree
	],
	Defense = [
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.CalmTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.FitTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.CivilizationTree
	],
	Class = [],
	Profession = [
		::Const.Perks.BarterProfessionTree
	],
	Magic = [
		::Const.Perks.CaptainMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendNoble2h <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.AxeTree,
		::Const.Perks.SwordTree,
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.FitTree,
		::Const.Perks.LargeTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendArbalester <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.BowTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.FastTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FitTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.OutlawTree,
		::Const.Perks.CivilizationTree
	],
	Profession = [],
	Class = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendFootSoldier <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.SwordTree,
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.FastTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendCommanderPeddler <- {
	Weapon = [
		::Const.Perks.PolearmTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.SlingTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.MaceTree

	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.OrganisedTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.DeviousTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Class = [],
	Profession = [
		::Const.Perks.BarterProfessionTree,
		::Const.Perks.CaravaneerProfessionTree
	],
	Magic = [
		::Const.Perks.PhilosophyMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendPilgrim <- {
	Weapon = [
		::Const.Perks.HammerTree,
		::Const.Perks.MaceTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.SlingTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [
		::Const.Perks.UndeadTree
	],
	Class = [
		::Const.Perks.FaithClassTree
	],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendPreserver <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendPuppet <- {
	Weapon = [
		::Const.Perks.AxeTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.HammerTree
	],
	Defense = [
		::Const.Perks.HeavyArmorTree
	],
	Traits = [
		::Const.Perks.MartyrTree,
		::Const.Perks.LargeTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendPuppetMaster <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendRanger <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.FitTree,
		::Const.Perks.AgileTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.OccultTree,
	],
	Class = [
		::Const.Perks.BeastClassTree
	],
	Profession = [],
	Magic = [
		::Const.Perks.RangerHuntMagicTree,
		::Const.Perks.MasterArcherTree
	]
};

::Legends.BackgroundPerkTrees.LegendCommanderRanger <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.AxeTree,
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.ViciousTree,
		::Const.Perks.FastTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.FitTree,
		::Const.Perks.AgileTree,
		::Const.Perks.LargeTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.GreenskinTree,
		::Const.Perks.OccultTree,
	],
	Class = [
		::Const.Perks.BeastClassTree,
		::Const.Perks.HoundmasterClassTree
	],
	Profession = [],
	Magic = [
		::Const.Perks.RangerHuntMagicTree,
		::Const.Perks.MasterArcherTree,
		::Const.Perks.ArcherCommandTree
	]
};

::Legends.BackgroundPerkTrees.LegendSeer <- {
	Weapon = [
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [
		::Const.Perks.OccultTree
	],
	Class = [],
	Profession = [
		::Const.Perks.HealerProfessionTree,
	],
	Magic = [
		::Const.Perks.SeerMagicTree,
		::Const.Perks.IllusionistMagicTree,
		::Const.Perks.StavesMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendShieldmaiden <- {
	Weapon = [
		::Const.Perks.SpearTree,
		::Const.Perks.AxeTree,
		::Const.Perks.SwordTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.ThrowingTree,
	],
	Defense = [
		::Const.Perks.HeavyArmorTree,
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.TrainedTree,
		::Const.Perks.FitTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.LargeTree,
		::Const.Perks.FastTree
	],
	Enemy = [
		::Const.Perks.OutlawTree
	],
	Profession = [],
	Class = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendSurgeon <- {
	Weapon = [
		::Const.Perks.CleaverTree,
		::Const.Perks.SpearTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree,
		::Const.Perks.InspirationalTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendTaxidermist <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.SwordTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.ThrowingTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.MediumArmorTree
	],
	Traits = [
		::Const.Perks.OrganisedTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.FastTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.BeastTree,
		::Const.Perks.OccultTree
	],
	Profession = [
		::Const.Perks.WoodworkingProfessionTree,
		::Const.Perks.RepairProfessionTree
	],
	Class = [
		::Const.Perks.TailorClassTree
	],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendVala <- {
	Weapon = [
		::Const.Perks.PolearmTree
	],
	Defense = [
		::Const.Perks.LightArmorTree,
		::Const.Perks.ClothArmorTree
	],
	Traits = [
		::Const.Perks.SturdyTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.IndestructibleTree
	],
	Enemy = [],
	Class = [
		::Const.Perks.StaffClassTree,
		::Const.Perks.HealerClassTree
	],
	Profession = [
		::Const.Perks.HealerProfessionTree,
		::Const.Perks.ChefProfessionTree,
		::Const.Perks.HerbalistProfessionTree
	],
	Magic = [
		::Const.Perks.ValaChantMagicTree,
		::Const.Perks.ValaTranceMagicTree,
		::Const.Perks.ValaSpiritMagicTree
	]
};;

::Legends.BackgroundPerkTrees.LegendWarlock <- {
	Weapon = [
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.CleaverTree
	],
	Defense = [
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = [
		::Const.Perks.WarlockMagicTree,
		::Const.Perks.StavesMagicTree
	]
};

::Legends.BackgroundPerkTrees.LegendWarlockSummoner <- {
	Weapon = [],
	Defense = [],
	Traits = [],
	Enemy = [],
	Class = [],
	Profession = [],
	Magic = []
};

::Legends.BackgroundPerkTrees.LegendYoungblood <- {
	Weapon = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree
	],
	Defense = [
		::Const.Perks.ClothArmorTree,
		::Const.Perks.LightArmorTree
	],
	Traits = [
		::Const.Perks.AgileTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.ViciousTree
	],
	Enemy = [
		::Const.Perks.UndeadTree,
		::Const.Perks.OccultTree
	],
	Class = [
		::Const.Perks.FaithClassTree
	],
	Profession = [
		::Const.Perks.ChefProfessionTree,
	],
	Magic = []
};
