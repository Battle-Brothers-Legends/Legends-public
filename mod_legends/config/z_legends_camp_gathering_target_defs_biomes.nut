::Legends.GatheringLoot.Biomes <- array(::Const.World.TerrainType.COUNT, null);

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Plains] = {
	Foraging = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Milk],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Fruits],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grain]
	],
	Hunting = [
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Ghoul],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Wicent]
	],
	Mining = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Slate],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone]
	],
	Woodcutting = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].ScrapWood],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Swamp] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grubs],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Mushrooms],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].MedicinalSpores],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].WildHerbs]
	],
	Hunting = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Crab],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Ghoul],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Goblin],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Hexen],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Serpent]
	],
	Mining = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Peat],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].BogIron]
	],
	Woodcutting = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RottenWood],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].PetrifiedWood]
	]	
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Hills] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].WildHerbs]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Bear],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Direwolf],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Ghoul],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].MountainGoat],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Unhold]
	],
	Mining = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Granite],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].CopperOre],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Coal],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].IronOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].SilverOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Gemstones]
	],
	Woodcutting = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Forest] = {
	Foraging = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Fruits],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grubs],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Mushrooms],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].NutsAndSeeds],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].WildHerbs]
	],
	Hunting = [
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Bear],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Boar],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Deer],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Direwolf],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Hexen],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Squirrel],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Webknecht]
	],
	Mining = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone]
	],
	Woodcutting = [
		[7, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Hardwood],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Heartwood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.SnowyForest] = {
	Foraging = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].NutsAndSeeds],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Bear],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Boar],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Deer],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Direwolf],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].FrostUnhold]
	],
	Mining = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Salt]
	],
	Woodcutting = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Hardwood],
	]	
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.LeaveForest] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Fruits],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grubs],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Mushrooms],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].NutsAndSeeds],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].WildHerbs]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Boar],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Deer],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Squirrel],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Webknecht]
	],
	Mining = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone]
	],
	Woodcutting = [
		[7, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Hardwood],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Heartwood]
	]	
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.AutumnForest] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Fruits],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grubs],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Mushrooms],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].NutsAndSeeds],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].WildHerbs]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Boar],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Deer],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Squirrel],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Webknecht]
	],
	Mining = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone]
	],
	Woodcutting = [
		[7, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Hardwood],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Heartwood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Mountains] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].NutsAndSeeds],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].WildHerbs],
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Bear],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Direwolf],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Ghoul],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].MountainGoat],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Squirrel],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Unhold]
	],
	Mining = [
		[6, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Granite],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].IronOre],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].CopperOre],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Coal],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Salt],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].SilverOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].GoldOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Gemstones]
	],
	Woodcutting = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
	]	
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Farmland] = {
	Foraging = [
		[6, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grain],
	],
	Hunting = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rat]
	],
	Mining = [
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Slate]
	],
	Woodcutting = [
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].ScrapWood],
	]	
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Snow] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Bear],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Direwolf],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].FrostUnhold]
	],
	Mining = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Salt]
	],
	Woodcutting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood]
	]	
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Tundra] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].RootsAndBerries],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].TundraMoss]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Bear],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Deer],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Direwolf],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].FrostUnhold]
	],
	Mining = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].IronOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].CopperOre]
	],
	Woodcutting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Steppe] = {
	Foraging = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Milk],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Fruits],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].DryHerbs],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grain]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Ghoul],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Hyena],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].MountainGoat],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Wicent]
	],
	Mining = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Stone],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Slate],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Salt]
	],
	Woodcutting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Shore] = {
	Foraging = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Clams],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Seaweed]
	],
	Hunting = [
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Crab],
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Fish],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant]
	],
	Mining = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Sandstone],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Salt]
	],
	Woodcutting = [
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Driftwood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Desert] = {
	Foraging = [
		[3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Dates],
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grubs],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].CactusStems]
	],
	Hunting = [
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Hyena],
		[4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Serpent]
	],
	Mining = [
		[5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Sandstone],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].CopperOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Gemstones]
	],
	Woodcutting = [
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].PetrifiedWood]
	]
};

::Legends.GatheringLoot.Biomes[::Const.World.TerrainType.Oasis] = {
	Foraging = [
        [5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Dates],
        [5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].Grubs],
        [5, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].NutsAndSeeds],
        [2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendForaging].DryHerbs]
    ],
    Hunting = [
        [2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Hyena],
        [3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Pheasant],
        [4, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Rabbit],
        [1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendHunting].Serpent]
    ],
	Mining = [
        [3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Sandstone],
        [1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].CopperOre],
		[1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendMining].Gemstones]
    ],
    Woodcutting = [
        [3, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Firewood],
		[2, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].RawWood],
        [1, ::Legends.GatheringLoot.TargetDefs[::Legends.Profession.LegendWoodcutting].Hardwood]
    ]
};
