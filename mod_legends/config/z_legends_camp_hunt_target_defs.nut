// Unfortunately we have to manually add any backgrounds that are used in TargetDefs, as there's no way to dynamically do it
// MAKE SURE ANY BACKGROUNDS ADDED IN TargetDefs IS ALSO ADDED HERE
::Const.HuntingLoot.RequiredBackgrounds <- {};
::Const.HuntingLoot.RequiredBackgrounds["background.barbarian"] <- "Barbarian";
::Const.HuntingLoot.RequiredBackgrounds["background.beast_slayer"] <- "Beast Slayer";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_berserker"] <- "Berserker";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_commander_berserker"] <- "Berserker Commander";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_cannibal"] <- "Cannibal";
::Const.HuntingLoot.RequiredBackgrounds["background.cultist"] <- "Cultist";
::Const.HuntingLoot.RequiredBackgrounds["background.converted_cultist"] <- "Converted Cultist";
::Const.HuntingLoot.RequiredBackgrounds["background.fisherman"] <- "Fisherman";
::Const.HuntingLoot.RequiredBackgrounds["background.hunter"] <- "Hunter";
::Const.HuntingLoot.RequiredBackgrounds["background.lindwurm_slayer"] <- "Lindwurm Slayer";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_master_archer"] <- "Master Archer";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_muladi"] <- "Muladí";
::Const.HuntingLoot.RequiredBackgrounds["background.nomad"] <- "Nomad";
::Const.HuntingLoot.RequiredBackgrounds["background.poacher"] <-	"Poacher";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_ranger"] <- "Ranger";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_commander_ranger"] <- "Ranger Commander";
::Const.HuntingLoot.RequiredBackgrounds["background.ratcatcher"] <- "Ratcatcher";
::Const.HuntingLoot.RequiredBackgrounds["background.shepherd"] <- "Shepherd";
::Const.HuntingLoot.RequiredBackgrounds["background.wildman"] <- "Wildman";
::Const.HuntingLoot.RequiredBackgrounds["background.witchhunter"] <- "Witch Hunter";
// Foragers
::Const.HuntingLoot.RequiredBackgrounds["background.anatomist"] <- "Anatomist";
::Const.HuntingLoot.RequiredBackgrounds["background.daytaler"] <- "Daytaler";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_druid"] <- "Druid";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_commander_druid"] <- "Druid Commander";
::Const.HuntingLoot.RequiredBackgrounds["background.farmhand"] <- "Farmhand";
::Const.HuntingLoot.RequiredBackgrounds["background.gravedigger"] <- "Gravedigger";
::Const.HuntingLoot.RequiredBackgrounds["background.legend_herbalist"] <- "Herbalist / Apothecary";
::Const.HuntingLoot.RequiredBackgrounds["background.miller"] <- "Miller";
::Const.HuntingLoot.RequiredBackgrounds["background.monk"] <- "Monk";
::Const.HuntingLoot.RequiredBackgrounds["background.vagabond"] <- "Vagabond";

// These backgrounds will contribute to Hunt Level (and hence Hunt Tier)
// NOTE: The "ExpertHunter" Background Type defined in each background needs to be manually maintained)
::Const.HuntingLoot.ExpertHunterBackgrounds <- [
	"background.barbarian",
	"background.beast_slayer",
	"background.hunter",
	"background.legend_cannibal",
	"background.legend_commander_ranger",
	"background.legend_muladi",
	"background.legend_master_archer",
	"background.legend_ranger",
	"background.nomad",
	"background.poacher",
	"background.ratcatcher",
	"background.wildman"
];

// Cook Backgrounds. No BackgroundType defined at this time
::Const.HuntingLoot.CookBackgrounds <- [
	"background.miller",
	"background.butcher",
	"background.servant",
	"background.legend_cannibal",
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
			"background.barbarian",
			"background.beast_slayer",
			"background.legend_berserker",
			"background.legend_commander_berserker",
			"background.hunter",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.wildman"
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
			"background.barbarian",
			"background.legend_berserker",
			"background.legend_commander_berserker",
			"background.hunter",
			"background.poacher",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.wildman"
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
			"background.fisherman",
			"background.wildman"
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
			"background.hunter",
			"background.poacher",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.wildman"
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
			"background.barbarian",
			"background.beast_slayer",
			"background.legend_berserker",
			"background.legend_commander_berserker",
			"background.hunter",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.wildman"
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
			"background.fisherman",
			"background.wildman"
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
			"background.legend_cannibal",
			"background.cultist",
			"background.converted_cultist",
			"background.witchhunter"
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
			"background.legend_cannibal",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.wildman"
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
			"background.legend_cannibal",
			"background.cultist",
			"background.converted_cultist",
			"background.witchhunter"
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
			"background.beast_slayer",
			"background.hunter",
			"background.nomad",
			"background.legend_ranger",
			"background.legend_commander_ranger"
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
			"background.hunter",
			"background.nomad",
			"background.poacher",
			"background.legend_ranger",
			"background.legend_commander_ranger"
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
			"background.beast_slayer",
			"background.lindwurm_slayer",
			"background.nomad"
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
			"background.barbarian",
			"background.beast_slayer",
			"background.legend_berserker",
			"background.legend_commander_berserker",
			"background.legend_ranger",
			"background.legend_commander_ranger"
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
			"background.barbarian",
			"background.beast_slayer",
			"background.legend_berserker",
			"background.legend_commander_berserker",
			"background.legend_ranger",
			"background.legend_commander_ranger"
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
