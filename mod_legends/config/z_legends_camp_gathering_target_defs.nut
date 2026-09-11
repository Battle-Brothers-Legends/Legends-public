::Legends.GatheringLoot <- {};
::Legends.GatheringLoot.TargetDefs <- {};
// Design document for hunting / foraging: https://docs.google.com/spreadsheets/d/1UHcwQFuL0dFtThlDFAXlAt7Lj4dNgWHKjO1palEq1to/edit?usp=sharing
::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging] <- {
	Dates = {
		Name = "Dates",
		Difficulty = 250,
		Loot = "scripts/items/supplies/legend_fresh_dates_item",
	},
	Fruits = {
		Name = "Fruit",
		Difficulty = 150,
		Loot = "scripts/items/supplies/legend_fresh_fruit_item",
	},
	Grubs = {
		Name = "Grubs",
		Difficulty = 70,
		Loot = "scripts/items/supplies/legend_bug_meat_item",
	},
	Milk = {
		Name = "Milk",
		Difficulty = 100,
		Loot = "scripts/items/supplies/legend_fresh_milk_item",
	},
	Mushrooms = {
		Name = "Mushrooms",
		Difficulty = 200,
		Loot = "scripts/items/supplies/legend_fresh_mushrooms_item",
	},
	NutsAndSeeds = {
		Name = "Nuts and Seeds",
		Difficulty = 100,
		Loot = "scripts/items/supplies/legend_nuts_and_seeds_item",
	},
	RootsAndBerries = {
		Name = "Roots and Berries",
		Difficulty = 150,
		Loot = "scripts/items/supplies/legend_fresh_roots_and_berries_item",
	},
	MedicinalSpores = {
		Name = "Medicinal Spores",
		Difficulty = 250,
		Loot = "scripts/items/supplies/legend_medicine_small_item"
	}
	WildHerbs = {
		Name = "Wild Herbs",
		Difficulty = 300,
		Loot = "scripts/items/supplies/legend_fresh_roots_and_berries_item",
		ExtraLoot = [
			[9, "scripts/items/misc/legend_mistletoe_item"],
			[1, "scripts/items/misc/mysterious_herbs_item"]
			// add more herbs here?
		]
	},
	Grain = {
		Name = "Grain",
		Difficulty = 100,
		Loot = "scripts/items/supplies/ground_grains_item",
	},
	TundraMoss = {
		Name = "Tundra Moss",
		Difficulty = 100,
		Loot = "scripts/item/supplies/legend_edible_moss_item"
	},
	DryHerbs = {
		Name = "Dry Herbs",
		Loot = "scripts/items/supplies/legend_nuts_and_seeds_item",
		ExtraLoot = [
			[9, "scripts/items/misc/legend_mistletoe_item"],
			[1, "scripts/items/misc/mysterious_herbs_item"]
			// add more herbs here?
		]
	},
	Clams = {
		Name = "Clams",
		Difficulty = 120,
		Loot = "scripts/items/supplies/legend_clams_item",
		ExtraLoot = [
			[19, "scripts/items/trade/legend_seashells_item"],
			[1, "scripts/items/loot/white_pearls_item"]
		],
	},
	Seaweed = {
		Name = "Seaweed",
		Difficulty = 80,
		Loot = "scripts/items/supplies/legend_edible_moss_item",
	},
	CactusStems = {
		Name = "Cactus Stems",
		Difficulty = 150,
		Loot = "scripts/items/supplies/legend_fresh_fruit_item"
	},
}

::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting] <- {
	Bear = {
		Name = "Bear",
		Difficulty = 800,
		Loot = "scripts/items/supplies/legend_bear_meat_item",
		ExtraLoot = [
			[1, "scripts/items/loot/legend_bear_fur_item"]
		],
		Tier = 2
	},
	Boar = {
		Name = "Boar",
		Difficulty = 400,
		Loot = "scripts/items/supplies/legend_boar_meat_item",
		ExtraLoot = [
			[4, "scripts/items/trade/legend_small_furs_item"],
			[2, "scripts/items/loot/sabertooth_item"],
			[1, "scripts/items/trade/furs_item"]
		],
		Tier = 1
	},
	Crab = {
		Name = "Crab",
		Difficulty = 200,
		Loot = "scripts/items/supplies/legend_crab_meat_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_seashells_item"]
		],
		Tier = 0
	},
	Deer = {
		Name = "Deer",
		Difficulty = 300,
		Loot = "scripts/items/supplies/legend_fresh_meat_item",
		ExtraLoot = [
			[3, "scripts/items/trade/legend_small_furs_item"],
			[1, "scripts/items/trade/furs_item"]
		],
		Tier = 0
	},
	Direwolf = {
		Name = "Direwolf",
		Difficulty = 500,
		Loot = "scripts/items/supplies/legend_wolf_meat_item",
		ExtraLoot = [
			[3, "scripts/items/misc/werewolf_pelt_item"],
			[1, "scripts/items/misc/adrenaline_gland_item"]
		],
		Tier = 1
	},
	Fish = {
		Name = "Fish",
		Difficulty = 150,
		Loot = "scripts/items/supplies/legend_fresh_fish_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_seashells_item"]
		],
		Tier = 0
	},
	Ghoul = {
		Name = "Ghoul",
		Difficulty = 250,
		Loot = "scripts/items/supplies/strange_meat_item",
		ExtraLoot = [
			[3, "scripts/items/loot/growth_pearls_item"],
			[3, "scripts/items/misc/ghoul_brain_item"],
			[3, "scripts/items/misc/ghoul_teeth_item"],
			[2, "scripts/items/misc/ghoul_horn_item"]
		],
		Tier = 1
	},
	Goblin = {
		Name = "Goblin",
		Difficulty = 250,
		Loot = "scripts/items/supplies/strange_meat_item",
		ExtraLoot = [
			[4, "scripts/items/loot/goblin_carved_ivory_iconographs_item"],
			[3, "scripts/items/loot/goblin_minted_coins_item"],
			[2, "scripts/items/loot/goblin_rank_insignia_item"]
		],
		Tier = 2
	},
	Hexen = {
		Name = "Hexen",
		Difficulty = 1200,
		Loot = "scripts/items/supplies/strange_meat_item", // placeholder?
		ExtraLoot = [
			[3, "scripts/items/misc/poisoned_apple_item"],
			[2, "scripts/items/misc/mysterious_herbs_item"],
			[1, "scripts/items/misc/witch_hair_item"]
		],
		Tier = 3
	},
	Hyena = {
		Name = "Hyena",
		Difficulty = 500,
		Loot = "scripts/items/supplies/legend_dog_meat_item",
		ExtraLoot = [
			[2, "scripts/items/loot/sabertooth_item"],
			[1, "scripts/items/misc/acidic_saliva_item"],
			[1, "scripts/items/misc/hyena_fur_item"]
		],
		Tier = 1
	},
	MountainGoat = {
		Name = "Mountain Goat",
		Difficulty = 350,
		Loot = "scripts/items/supplies/legend_mutton_item",
		ExtraLoot = [ // placeholder?
			[5, "scripts/items/trade/legend_small_furs_item"],
			[1, "scripts/items/trade/furs_item"]
		],
		Tier = 0
	},
	Pheasant = {
		Name = "Pheasant",
		Difficulty = 200,
		Loot = "scripts/items/supplies/legend_fresh_poultry_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_small_furs_item"] // placeholder
		],
		Tier = 0
	},
	Rabbit = {
		Name = "Rabbit",
		Difficulty = 200,
		Loot = "scripts/items/supplies/legend_rabbit_meat_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_small_furs_item"] // placeholder
		],
		Tier = 0
	},
	Serpent = {
		Name = "Serpent",
		Difficulty = 800,
		Loot = "scripts/items/supplies/legend_snake_meat_item",
		ExtraLoot = [
			[3, "scripts/items/misc/serpent_skin_item"],
			[2, "scripts/items/misc/glistening_scales_item"],
			[4, "scripts/items/loot/rainbow_scale_item"]
		],
		Tier = 2
	},
	Squirrel = {
		Name = "Squirrel",
		Difficulty = 200,
		Loot = "scripts/items/supplies/legend_squirrel_meat_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_small_furs_item"]
		],
		Tier = 0
	},

	Unhold = {
		Name = "Unhold",
		Difficulty = 1500,
		Loot = "scripts/items/supplies/strange_meat_item",
		ExtraLoot = [
			[3, "scripts/items/misc/unhold_bones_item"],
			[3, "scripts/items/misc/unhold_heart_item"],
			[4, "scripts/items/misc/unhold_hide_item"]
		],
		Tier = 3
	},
	FrostUnhold = {
		Name = "Frost Unhold",
		Difficulty = 1500,
		Loot = "scripts/items/supplies/strange_meat_item",
		ExtraLoot = [
			[3, "scripts/items/misc/unhold_bones_item"],
			[3, "scripts/items/misc/unhold_heart_item"],
			[4, "scripts/items/misc/unhold_hide_item"],
			[3, "scripts/items/misc/frost_unhold_fur_item"]
		],
		Tier = 3
	},

	Webknecht = {
		Name = "Webknecht",
		Difficulty = 500,
		Loot = "scripts/items/supplies/legend_bug_meat_item",
		ExtraLoot = [
			[3, "scripts/items/misc/poison_gland_item"],
			[2, "scripts/items/misc/spider_silk_item"]
		],
		Tier = 1
	},
	Wicent = {
		Name = "Wicent",
		Difficulty = 700,
		Loot = "scripts/items/supplies/legend_beef_item",
		ExtraLoot = [
			[1, "scripts/items/trade/furs_item"]
		],
		Tier = 1
	},
	Rat = {
		Name = "Rat",
		Difficulty = 200,
		Loot = "scripts/items/supplies/strange_meat_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_small_furs_item"]
		],
		Tier = 0
	}
}

::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting] <- {
	ScrapWood = {
		Name = "Scrap Wood",
		Difficulty = 150,
		Loot = "scripts/items/trade/legend_firewood_item"
	},
	Firewood = {
		Name = "Firewood",
		Difficulty = 150,
		Loot = "scripts/items/trade/legend_firewood_item"
	},
	Driftwood = {
		Name = "Driftwood",
		Difficulty = 200,
		Loot = "scripts/items/trade/legend_firewood_item"
	},
	RottenWood = {
		Name = "Rotten Wood",
		Difficulty = 250,
		Loot = "scripts/items/trade/legend_firewood_item"
	},
	RawWood = {
		Name = "Raw Wood",
		Difficulty = 400,
		Loot = "scripts/items/trade/legend_raw_wood_item"
	},
	Hardwood = {
		Name = "Hardwood",
		Difficulty = 500,
		Loot = "scripts/items/trade/legend_hardwood_item",
		ExtraLoot = [
			[29, "scripts/items/trade/legend_resin_item"],
			[1, "scripts/items/trade/glowing_resin_item"]
		]
	},
	Heartwood = {
		Name = "Schrat Wood",
		Difficulty = 1000,
		Loot = "scripts/items/misc/ancient_wood_item",
		ExtraLoot = [
			[80, "scripts/items/trade/legend_resin_item"],
			[20, "scripts/items/trade/glowing_resin_item"]
		]
	},
	PetrifiedWood = {
		Name = "Petrified Wood",
		Difficulty = 600,
		Loot = "scripts/items/trade/legend_petrified_wood_item",
	}
}

::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining] <- {
	Sandstone = {
		Name = "Sandstone",
		Difficulty = 150,
		Loot = "scripts/items/trade/legend_stone_item",
		ExtraLoot = [
			[1, "scripts/items/trade/legend_amber_item"]
		]
	},
	Slate = {
		Name = "Slate",
		Difficulty = 150,
		Loot = "scripts/items/trade/legend_stone_item"
	},
	Stone = {
		Name = "Stone",
		Difficulty = 200,
		Loot = "scripts/items/trade/legend_stone_item",
		ExtraLoot = [
			[2, "scripts/items/trade/legend_amber_item"]
		]
	},
	Granite = {
		Name = "Granite",
		Difficulty = 250,
		Loot = "scripts/items/trade/legend_stone_item",
		ExtraLoot = [
			[4, "scripts/items/trade/legend_gem_shards_item"],
			[1, "scripts/items/trade/uncut_gems_item"]
		]
	},
	Peat = {
		Name = "Peat",
		Difficulty = 250,
		Loot = "scripts/items/trade/legend_coal_item"
	},
	Coal = {
		Name = "Coal",
		Difficulty = 250,
		Loot = "scripts/items/trade/legend_coal_item"
	},
	Salt = {
		Name = "Salt",
		Difficulty = 400,
		Loot = "scripts/items/trade/salt_item"
	},
	CopperOre = {
		Name = "Copper Ore",
		Difficulty = 300,
		Loot = "scripts/items/trade/legend_copper_ore_item",
		ExtraLoot = [
			[29, "scripts/items/trade/legend_gem_shards_item"],
			[3, "scripts/items/trade/legend_amber_item"],
			[1, "scripts/items/trade/uncut_gems_item"]
		]
	},
	BogIron = {
		Name = "Bog Iron",
		Difficulty = 400,
		Loot = "scripts/items/trade/legend_iron_ore_item",
		ExtraLoot = [
			[5, "scripts/items/trade/legend_gem_shards_item"],
			[2, "scripts/items/trade/legend_amber_item"]
		]
	},
	IronOre = {
		Name = "Iron Ore",
		Difficulty = 400,
		Loot = "scripts/items/trade/legend_iron_ore_item",
		ExtraLoot = [
			[29, "scripts/items/trade/legend_gem_shards_item"],
			[2, "scripts/items/trade/legend_amber_item"],
			[1, "scripts/items/trade/uncut_gems_item"]
		]
	},
	SilverOre = {
		Name = "Silver Ore",
		Difficulty = 600,
		Loot = "scripts/items/trade/legend_silver_ore_item",
		ExtraLoot = [
			[19, "scripts/items/trade/legend_gem_shards_item"],
			[1, "scripts/items/trade/uncut_gems_item"]
		]
	},
	GoldOre = {
		Name = "Gold Ore",
		Difficulty = 900,
		Loot = "scripts/items/trade/legend_gold_ore_item",
		ExtraLoot = [
			[9, "scripts/items/trade/legend_gem_shards_item"],
			[1, "scripts/items/trade/uncut_gems_item"]
		]
	},
	Gemstones = {
		Name = "Gemstones",
		Difficulty = 1000,
		Loot = "scripts/items/trade/legend_gem_shards_item",
		ExtraLoot = [
			[2, "scripts/items/trade/legend_gem_shards_item"],
			[1, "scripts/items/trade/uncut_gems_item"]
		]
	}
}
