// Unfortunately we have to manually add any backgrounds that are used in TargetDefs, as there's no way to dynamically do it
// MAKE SURE ANY BACKGROUNDS ADDED IN TargetDefs IS ALSO ADDED HERE
::Const.HuntingLoot.RequiredBackgrounds <- {};
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Barbarian)] <- "Barbarian";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer)] <- "Beast Slayer";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker)] <- "Berserker";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker)] <- "Berserker Commander";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Cultist)] <- "Cultist";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist)] <- "Converted Cultist";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Fisherman)] <- "Fisherman";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Hunter)] <- "Hunter";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LindwurmSlayer)] <- "Lindwurm Slayer";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendMasterArcher)] <- "Master Archer";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendMuladi)] <- "Muladí";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Nomad)] <- "Nomad";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Poacher)] <-	"Poacher";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendRanger)] <- "Ranger";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger)] <- "Ranger Commander";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Ratcatcher)] <- "Ratcatcher";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Shepherd)] <- "Shepherd";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Wildman)] <- "Wildman";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Witchhunter)] <- "Witch Hunter";
// Foragers
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Anatomist)] <- "Anatomist";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Daytaler)] <- "Daytaler";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendDruid)] <- "Druid";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Farmhand)] <- "Farmhand";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Gravedigger)] <- "Gravedigger";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.LegendHerbalist)] <- "Herbalist / Apothecary";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Miller)] <- "Miller";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Monk)] <- "Monk";
::Const.HuntingLoot.RequiredBackgrounds[::Legends.Backgrounds.getID(::Legends.Background.Vagabond)] <- "Vagabond";

// These backgrounds will contribute to Hunt Level (and hence Hunt Tier)
// NOTE: The "ExpertHunter" Background Type defined in each background needs to be manually maintained)
::Const.HuntingLoot.ExpertHunterBackgrounds <- [
	::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
	::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
	::Legends.Backgrounds.getID(::Legends.Background.Hunter),
	::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger),
	::Legends.Backgrounds.getID(::Legends.Background.LegendMuladi),
	::Legends.Backgrounds.getID(::Legends.Background.LegendMasterArcher),
	::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
	::Legends.Backgrounds.getID(::Legends.Background.Nomad),
	::Legends.Backgrounds.getID(::Legends.Background.Poacher),
	::Legends.Backgrounds.getID(::Legends.Background.Ratcatcher),
	::Legends.Backgrounds.getID(::Legends.Background.Wildman)
];

// Cook Backgrounds. No BackgroundType defined at this time
::Const.HuntingLoot.CookBackgrounds <- [
	::Legends.Backgrounds.getID(::Legends.Background.Miller),
	::Legends.Backgrounds.getID(::Legends.Background.Butcher),
	::Legends.Backgrounds.getID(::Legends.Background.Servant),
];

// Define the various targets that can be hunted / looted
// Design document: https://docs.google.com/spreadsheets/d/1UHcwQFuL0dFtThlDFAXlAt7Lj4dNgWHKjO1palEq1to/edit?usp=sharing
::Const.HuntingLoot.TargetDefs <- {

	// Foraging Targets
	Dates = {
		Name = "Dates",
		Text = "dates",
		Type = "Forage",
		Difficulty = 250,
		Food = "scripts/items/supplies/legend_fresh_dates_item",
		Cook = "scripts/items/supplies/dates_item",
	},

	Fruits = {
		Name = "Fruit",
		Text = "fruit",
		Type = "Forage",
		Difficulty = 150,
		Food = "scripts/items/supplies/legend_fresh_fruit_item",
		Cook = "scripts/items/supplies/dried_fruits_item",
	},

	Grubs = {
		Name = "Grubs",
		Text = "grubs",
		Type = "Forage",
		Difficulty = 70,
		Food = "scripts/items/supplies/legend_bug_meat_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder
	},

	Milk = {
		Name = "Milk",
		Text = "milk",
		Type = "Forage",
		Difficulty = 100,
		Food = "scripts/items/supplies/legend_fresh_milk_item",
		Cook = "scripts/items/supplies/goat_cheese_item", // placeholder?
	},

	Mushrooms = {
		Name = "Mushrooms",
		Text = "mushrooms",
		Type = "Forage",
		Difficulty = 200,
		Food = "scripts/items/supplies/legend_fresh_mushrooms_item",
		Cook = "scripts/items/supplies/pickled_mushrooms_item",
	},

	NutsAndSeeds = {
		Name = "Nuts and Seeds",
		Text = "nuts and seeds",
		Type = "Forage",
		Difficulty = 100,
		Food = "scripts/items/supplies/legend_nuts_and_seeds_item",
		Cook = "scripts/items/supplies/roots_and_berries_item", // placeholder
	},

	RootsAndBerries = {
		Name = "Roots and Berries",
		Text = "roots and berries",
		Type = "Forage",
		Difficulty = 150,
		Food = "scripts/items/supplies/legend_fresh_roots_and_berries_item",
		Cook = "scripts/items/supplies/roots_and_berries_item",
	},

	// Hunting Targets
	Bear = {
		Name = "Bear",
		Text = "a bear",
		Type = "Hunt",
		Tier = 2,
		Difficulty = 800,
		Food = "scripts/items/supplies/legend_bear_meat_item",
		Cook = "scripts/items/supplies/legend_pie_item", // placeholder
		Loot = [
			[1,"scripts/items/loot/legend_bear_fur_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Boar = {
		Name = "Boar",
		Text = "a wild boar",
		Type = "Hunt",
		Tier = 1,
		Difficulty = 400,
		Food = "scripts/items/supplies/legend_boar_meat_item",
		Cook = "scripts/items/supplies/smoked_ham_item", // placeholder?
		Loot = [ // placeholder
			[4,"scripts/items/trade/legend_small_furs_item"],
			[2,"scripts/items/loot/sabertooth_item"],
			[1,"scripts/items/trade/furs_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.Poacher),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Clams = {
		Name = "Clams",
		Text = "some clams",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 100,
		Food = "scripts/items/supplies/legend_clams_item",
		Cook = "scripts/items/supplies/dried_fish_item", // placeholder
		Loot = [
			[19,"scripts/items/trade/legend_seashells_item"],
			[1,"scripts/items/loot/white_pearls_item"]
		],
	},

	Crab = {
		Name = "Crab",
		Text = "a crab",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 200,
		Food = "scripts/items/supplies/legend_crab_meat_item",
		Cook = "scripts/items/supplies/legend_pie_item", // placeholder
		Loot = [ // placeholder
			[1,"scripts/items/trade/legend_seashells_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Fisherman),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Deer = {
		Name = "Deer",
		Text = "a deer",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 300,
		Food = "scripts/items/supplies/legend_fresh_meat_item",
		Cook = "scripts/items/supplies/cured_venison_item",
		Loot = [ // placeholder?
			[3,"scripts/items/trade/legend_small_furs_item"],
			[1,"scripts/items/trade/furs_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.Poacher),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Direwolf = {
		Name = "Direwolf",
		Text = "a direwolf",
		Type = "Hunt",
		Tier = 1,
		Difficulty = 500,
		Food = "scripts/items/supplies/legend_wolf_meat_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder
		Loot = [
			[3,"scripts/items/misc/werewolf_pelt_item"],
			[1,"scripts/items/misc/adrenaline_gland_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Fish = {
		Name = "Fish",
		Text = "a fish",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 150,
		Food = "scripts/items/supplies/legend_fresh_fish_item",
		Cook = "scripts/items/supplies/dried_fish_item",
		Loot = [ // placeholder
			[1,"scripts/items/trade/legend_seashells_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Fisherman),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Ghoul = {
		Name = "Ghoul",
		Text = "a nachzehrer",
		Type = "Hunt",
		Tier = 1,
		Difficulty = 250,
		Food = "scripts/items/supplies/strange_meat_item", // placeholder?
		Cook = "scripts/items/supplies/legend_pie_item", // placeholder
		Loot = [
			[3,"scripts/items/loot/growth_pearls_item"],
			[3,"scripts/items/misc/ghoul_brain_item"],
			[3,"scripts/items/misc/ghoul_teeth_item"],
			[2,"scripts/items/misc/ghoul_horn_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Cultist),
			::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist),
			::Legends.Backgrounds.getID(::Legends.Background.Witchhunter)
		]
	},

	Goblin = {
		Name = "Goblin",
		Text = "a goblin",
		Type = "Hunt",
		Tier = 2,
		Difficulty = 250,
		Food = "scripts/items/supplies/strange_meat_item", // placeholder?
		Cook = "scripts/items/supplies/legend_pie_item", // placeholder
		Loot = [
			[4,"scripts/items/loot/goblin_carved_ivory_iconographs_item"],
			[3,"scripts/items/loot/goblin_minted_coins_item"],
			[2,"scripts/items/loot/goblin_rank_insignia_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman)
		]
	},

	Hexen = {
		Name = "Hexen",
		Text = "a hexen",
		Type = "Hunt",
		Tier = 3,
		Difficulty = 1200,
		Food = "scripts/items/supplies/strange_meat_item", // placeholder?
		Cook = "scripts/items/supplies/black_marsh_stew_item",
		Loot = [
			[3,"scripts/items/misc/poisoned_apple_item"],
			[2,"scripts/items/misc/mysterious_herbs_item"],
			[1,"scripts/items/misc/witch_hair_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Cultist),
			::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist),
			::Legends.Backgrounds.getID(::Legends.Background.Witchhunter)
		]
	},

	Hyena = {
		Name = "Hyena",
		Text = "a hyena",
		Type = "Hunt",
		Tier = 1,
		Difficulty = 500,
		Food = "scripts/items/supplies/legend_dog_meat_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder?
		Loot = [
			[2,"scripts/items/loot/sabertooth_item"],
			[1,"scripts/items/misc/acidic_saliva_item"],
			[1,"scripts/items/misc/hyena_fur_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.Nomad),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger)
		]
	},

	MountainGoat = {
		Name = "Mountain Goat",
		Text = "a mountain goat",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 350,
		Food = "scripts/items/supplies/legend_mutton_item",
		Cook = "scripts/items/supplies/dried_lamb_item",
		Loot = [ // placeholder?
			[5,"scripts/items/trade/legend_small_furs_item"],
			[1,"scripts/items/trade/furs_item"]
		],
	},

	Pheasant = {
		Name = "Pheasant",
		Text = "a pheasant",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 200,
		Food = "scripts/items/supplies/legend_fresh_poultry_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder
		Loot = [
			[1,"scripts/items/trade/legend_small_furs_item"] // placeholder
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.Nomad),
			::Legends.Backgrounds.getID(::Legends.Background.Poacher),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger)
		]
	},

	Rabbit = {
		Name = "Rabbit",
		Text = "a rabbit",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 200,
		Food = "scripts/items/supplies/legend_rabbit_meat_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder
		Loot = [
			[1,"scripts/items/trade/legend_small_furs_item"] // placeholder
		],
	},

	Serpent = {
		Name = "Serpent",
		Text = "a serpent",
		Type = "Hunt",
		Tier = 2,
		Difficulty = 800,
		Food = "scripts/items/supplies/legend_snake_meat_item",
		Cook = "scripts/items/supplies/legend_pie_item", // placeholder
		Loot = [
			[3,"scripts/items/misc/serpent_skin_item"],
			[2,"scripts/items/misc/glistening_scales_item"],
			[4,"scripts/items/loot/rainbow_scale_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.LindwurmSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.Nomad)
		]
	},

	Squirrel = {
		Name = "Squirrel",
		Text = "a squirrel",
		Type = "Hunt",
		Tier = 0,
		Difficulty = 200,
		Food = "scripts/items/supplies/legend_squirrel_meat_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder
		Loot = [
			[1,"scripts/items/trade/legend_small_furs_item"]
		],
	},

	Unhold = {
		Name = "Unhold",
		Text = "an unhold",
		Type = "Hunt",
		Tier = 3,
		Difficulty = 1500,
		Food = "scripts/items/supplies/strange_meat_item",
		Cook = "scripts/items/supplies/fermented_unhold_heart_item",
		Loot = [
			[3,"scripts/items/misc/unhold_bones_item"],
			[3,"scripts/items/misc/unhold_heart_item"],
			[4,"scripts/items/misc/unhold_hide_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger)
		]
	},

	FrostUnhold = {
		Name = "Frost Unhold",
		Text = "a frost unhold",
		Type = "Hunt",
		Tier = 3,
		Difficulty = 1500,
		Food = "scripts/items/supplies/strange_meat_item",
		Cook = "scripts/items/supplies/fermented_unhold_heart_item",
		Loot = [
			[3,"scripts/items/misc/unhold_bones_item"],
			[3,"scripts/items/misc/unhold_heart_item"],
			[4,"scripts/items/misc/unhold_hide_item"],
			[3,"scripts/items/misc/frost_unhold_fur_item"]
		],
		Backgrounds = [
			::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
			::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger)
		]
	},

	Webknecht = {
		Name = "Webknecht",
		Text = "a webknecht",
		Type = "Hunt",
		Tier = 1,
		Difficulty = 500,
		Food = "scripts/items/supplies/legend_bug_meat_item",
		Cook = "scripts/items/supplies/legend_yummy_sausages", // placeholder?
		Loot = [
			[3,"scripts/items/misc/poison_gland_item"],
			[2,"scripts/items/misc/spider_silk_item"]
		],
	},

	Wicent = {
		Name = "Wicent",
		Text = "a wicent",
		Type = "Hunt",
		Tier = 1,
		Difficulty = 700,
		Food = "scripts/items/supplies/legend_beef_item",
		Cook = "scripts/items/supplies/legend_pie_item", // placeholder?
		Loot = [
			[1,"scripts/items/trade/furs_item"]
		],
	},
}

// Gather all the backgrounds that enable hunting / foraging for convenient reference at runtime
::Const.HuntingLoot.AllRequiredBackgrounds <- {
	All = [],
	Forage = [],
	Hunt = [],
}
foreach(t in ::Const.HuntingLoot.TargetDefs)
{
	if ("Backgrounds" in t)
	{
		foreach (b in t.Backgrounds)
		{
			if (!(b in ::Const.HuntingLoot.AllRequiredBackgrounds.All))
			{
				::Const.HuntingLoot.AllRequiredBackgrounds.All.push(b);
			}
			if (t.Type == "Forage" && !(b in ::Const.HuntingLoot.AllRequiredBackgrounds.Forage))
			{
				::Const.HuntingLoot.AllRequiredBackgrounds.Forage.push(b);
			}
			else if (t.Type == "Hunt" && !(b in ::Const.HuntingLoot.AllRequiredBackgrounds.Hunt))
			{
				::Const.HuntingLoot.AllRequiredBackgrounds.Hunt.push(b);
			}
		}
	}
}
