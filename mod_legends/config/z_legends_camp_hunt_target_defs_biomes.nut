// Example Setup; Also serves as default for any biome we haven't covered
::Const.HuntingLoot.BiomesDefault <- [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Fruits],
		[3, ::Const.HuntingLoot.TargetDefs.Deer],
		[1, ::Const.HuntingLoot.TargetDefs.Direwolf],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];


::Const.HuntingLoot.Biomes <- array(::Const.World.TerrainType.COUNT, null);

// Ocean Tile is inaccessible?
::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Ocean] = [
	// Targets
	[],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Plains] = [
	// Targets
	[
		[2, ::Const.HuntingLoot.TargetDefs.Fruits],
		[3, ::Const.HuntingLoot.TargetDefs.Milk],
		[3, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[1, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[2, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[3, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[1, ::Const.HuntingLoot.TargetDefs.Wicent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Swamp] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[3, ::Const.HuntingLoot.TargetDefs.Mushrooms],
		[3, ::Const.HuntingLoot.TargetDefs.Crab],
		[2, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[2, ::Const.HuntingLoot.TargetDefs.Goblin],
		[1, ::Const.HuntingLoot.TargetDefs.Hexen],
		[4, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[2, ::Const.HuntingLoot.TargetDefs.Serpent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Hills] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[2, ::Const.HuntingLoot.TargetDefs.Bear],
		[2, ::Const.HuntingLoot.TargetDefs.Direwolf],
		[3, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[4, ::Const.HuntingLoot.TargetDefs.MountainGoat],
		[1, ::Const.HuntingLoot.TargetDefs.Unhold],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Forest] = [
	// Targets
	[
		[3, ::Const.HuntingLoot.TargetDefs.Fruits],
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[3, ::Const.HuntingLoot.TargetDefs.Mushrooms],
		[5, ::Const.HuntingLoot.TargetDefs.NutsAndSeeds],
		[3, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[1, ::Const.HuntingLoot.TargetDefs.Bear],
		[2, ::Const.HuntingLoot.TargetDefs.Boar],
		[3, ::Const.HuntingLoot.TargetDefs.Deer],
		[2, ::Const.HuntingLoot.TargetDefs.Direwolf],
		[1, ::Const.HuntingLoot.TargetDefs.Hexen],
		[5, ::Const.HuntingLoot.TargetDefs.Squirrel],
		[3, ::Const.HuntingLoot.TargetDefs.Webknecht],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];


::Const.HuntingLoot.Biomes[::Const.World.TerrainType.SnowyForest] = [
	// Targets
	[
		[4, ::Const.HuntingLoot.TargetDefs.NutsAndSeeds],
		[4, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[2, ::Const.HuntingLoot.TargetDefs.Bear],
		[3, ::Const.HuntingLoot.TargetDefs.Boar],
		[3, ::Const.HuntingLoot.TargetDefs.Deer],
		[2, ::Const.HuntingLoot.TargetDefs.Direwolf],
		[5, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[1, ::Const.HuntingLoot.TargetDefs.FrostUnhold],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.LeaveForest] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Fruits],
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[4, ::Const.HuntingLoot.TargetDefs.Mushrooms],
		[4, ::Const.HuntingLoot.TargetDefs.NutsAndSeeds],
		[3, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[2, ::Const.HuntingLoot.TargetDefs.Boar],
		[2, ::Const.HuntingLoot.TargetDefs.Deer],
		[3, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[4, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[5, ::Const.HuntingLoot.TargetDefs.Squirrel],
		[2, ::Const.HuntingLoot.TargetDefs.Webknecht],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.AutumnForest] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Fruits],
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[4, ::Const.HuntingLoot.TargetDefs.Mushrooms],
		[4, ::Const.HuntingLoot.TargetDefs.NutsAndSeeds],
		[2, ::Const.HuntingLoot.TargetDefs.Boar],
		[2, ::Const.HuntingLoot.TargetDefs.Deer],
		[3, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[4, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[5, ::Const.HuntingLoot.TargetDefs.Squirrel],
		[2, ::Const.HuntingLoot.TargetDefs.Webknecht],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Mountains] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[2, ::Const.HuntingLoot.TargetDefs.Bear],
		[2, ::Const.HuntingLoot.TargetDefs.Direwolf],
		[3, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[4, ::Const.HuntingLoot.TargetDefs.MountainGoat],
		[5, ::Const.HuntingLoot.TargetDefs.Squirrel],
		[1, ::Const.HuntingLoot.TargetDefs.Unhold],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

// Unused in-game?
::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Urban] = [
	// Targets
	[],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

// Unused in-game?
::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Farmland] = [
	// Targets
	[],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Snow] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[2, ::Const.HuntingLoot.TargetDefs.Bear],
		[2, ::Const.HuntingLoot.TargetDefs.Direwolf],
		[5, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[1, ::Const.HuntingLoot.TargetDefs.FrostUnhold],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

// Unused in-game?
::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Badlands] = [
	// Targets
	[],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Tundra] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.RootsAndBerries],
		[2, ::Const.HuntingLoot.TargetDefs.Bear],
		[3, ::Const.HuntingLoot.TargetDefs.Deer],
		[2, ::Const.HuntingLoot.TargetDefs.Direwolf],
		[5, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[1, ::Const.HuntingLoot.TargetDefs.FrostUnhold],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Steppe] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Fruits],
		[5, ::Const.HuntingLoot.TargetDefs.Milk],
		[2, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[3, ::Const.HuntingLoot.TargetDefs.Hyena],
		[4, ::Const.HuntingLoot.TargetDefs.MountainGoat],
		[5, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[1, ::Const.HuntingLoot.TargetDefs.Wicent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Shore] = [
	// Targets
	[
		[3, ::Const.HuntingLoot.TargetDefs.Clams],
		[1, ::Const.HuntingLoot.TargetDefs.Crab],
		[3, ::Const.HuntingLoot.TargetDefs.Fish],
		[2, ::Const.HuntingLoot.TargetDefs.Pheasant],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Desert] = [
	// Targets
	[
		[3, ::Const.HuntingLoot.TargetDefs.Dates],
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[2, ::Const.HuntingLoot.TargetDefs.Hyena],
		[4, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[1, ::Const.HuntingLoot.TargetDefs.Serpent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.Oasis] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Dates],
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[5, ::Const.HuntingLoot.TargetDefs.NutsAndSeeds],
		[2, ::Const.HuntingLoot.TargetDefs.Hyena],
		[3, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[4, ::Const.HuntingLoot.TargetDefs.Rabbit],
		[1, ::Const.HuntingLoot.TargetDefs.Serpent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.SwampGreen] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[3, ::Const.HuntingLoot.TargetDefs.Mushrooms],
		[3, ::Const.HuntingLoot.TargetDefs.Crab],
		[2, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[2, ::Const.HuntingLoot.TargetDefs.Goblin],
		[1, ::Const.HuntingLoot.TargetDefs.Hexen],
		[4, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[2, ::Const.HuntingLoot.TargetDefs.Serpent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];

::Const.HuntingLoot.Biomes[::Const.World.TerrainType.SwampForest] = [
	// Targets
	[
		[5, ::Const.HuntingLoot.TargetDefs.Grubs],
		[3, ::Const.HuntingLoot.TargetDefs.Mushrooms],
		[3, ::Const.HuntingLoot.TargetDefs.Crab],
		[2, ::Const.HuntingLoot.TargetDefs.Ghoul],
		[2, ::Const.HuntingLoot.TargetDefs.Goblin],
		[1, ::Const.HuntingLoot.TargetDefs.Hexen],
		[4, ::Const.HuntingLoot.TargetDefs.Pheasant],
		[2, ::Const.HuntingLoot.TargetDefs.Serpent],
	],
	// Brew Loot (Always the same for now until further rework)
	[
		[1, "scripts/items/supplies/beer_item"],
		[1, "scripts/items/supplies/wine_item"],
	]
];
