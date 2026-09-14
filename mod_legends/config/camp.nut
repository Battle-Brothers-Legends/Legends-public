if (!("Camp" in ::Legends))
	::Legends.Camp <- {};

::Legends.Camp.CampBuildings <- {
	Commander = "camp.commander",
	Barber = "camp.barber",
	Crafting = "camp.crafting",
	Enchanter = "camp.enchanter",
	Fletcher = "camp.fletcher",
	Gatherer = "camp.gatherer",
	Healer = "camp.healer",
	//Hunter = "camp.hunter",
	Kitchen = "camp.kitchen",
	Repair = "camp.repair",
	Rest = "camp.rest",
	Scout = "camp.scout",
	Training = "camp.training",
	Workshop = "camp.workshop",
	Painter = "camp.painter"
};
::Legends.Camp.TerrainCampImages <- {
	[::Const.World.TerrainType.Impassable] = {
		Foreground = null,
		Background = null,
		Mood = null,
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Ocean] = {
		Foreground = null,
		Background = null,
		Mood = null,
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Plains] = {
		Foreground = null,
		Background = "ui/settlements/camp_bg_01",
		Mood = "ui/settlements/mood_grass",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Swamp] = {
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/camp_bg_07",
		Mood = "ui/settlements/mood_swamp",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Hills] = {
		Foreground = "ui/settlements/foreground_01",
		Background = "ui/settlements/camp_bg_06",
		Mood = "ui/settlements/mood_dark_mountains",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Forest] = {
		Foreground = "ui/settlements/foreground_05",
		Background = "ui/settlements/camp_bg_05",
		Mood = "ui/settlements/mood_dark_forest",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.SnowyForest] = {
		Foreground = "ui/settlements/foreground_05",
		Background = "ui/settlements/camp_bg_04",
		Mood = "ui/settlements/mood_snow",
		BuildingVariant = 4
	},
	[::Const.World.TerrainType.LeaveForest] = {
		Foreground = "ui/settlements/foreground_02",
		Background = "ui/settlements/camp_bg_02",
		Mood = "ui/settlements/mood_forest",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.AutumnForest] = {
		Foreground = "ui/settlements/foreground_07",
		Background = "ui/settlements/camp_bg_03",
		Mood = "ui/settlements/mood_forest",
		BuildingVariant = 9
	},
	[::Const.World.TerrainType.Mountains] = {
		Foreground = "ui/settlements/foreground_01",
		Background = "ui/settlements/camp_bg_04",
		Mood = "ui/settlements/mood_dark_mountains",
		BuildingVariant = 4
	},
	[::Const.World.TerrainType.Urban] = {
		Foreground = null,
		Background = "ui/settlements/camp_bg_01",
		Mood = null,
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Farmland] = {
		Foreground = null,
		Background = "ui/settlements/camp_bg_01",
		Mood = "ui/settlements/mood_grass",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Snow] = {
		Foreground = "ui/settlements/foreground_03",
		Background = "ui/settlements/camp_bg_04",
		Mood = "ui/settlements/mood_snow",
		BuildingVariant = 4
	},
	[::Const.World.TerrainType.Badlands] = {
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/camp_bg_08",
		Mood = "ui/settlements/mood_dark_mountains",
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Tundra] = {
		Foreground = null,
		Background = "ui/settlements/camp_bg_09",
		Mood = "ui/settlements/mood_tundra",
		BuildingVariant = 9
	},
	[::Const.World.TerrainType.Steppe] = {
		Foreground = null,
		Background = "ui/settlements/camp_bg_08",
		Mood = "ui/settlements/mood_steppe",
		BuildingVariant = 8
	},
	[::Const.World.TerrainType.Shore] = {
		Foreground = null,
		Background = "ui/settlements/camp_bg_01",
		Mood = null,
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Desert] = {
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/camp_bg_10",
		Mood = null,
		BuildingVariant = 0
	},
	[::Const.World.TerrainType.Oasis] = {
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/camp_bg_10",
		Mood = null,
		BuildingVariant = 0
	}
};

/*
	Flags define if tent in camp screen is visible.
	Used in
*/
::Legends.Camp.Flag <- {
	[::Legends.Camp.CampBuildings.Barber] = "HasLegendCampBarber",
	[::Legends.Camp.CampBuildings.Crafting] = "HasLegendCampCrafting",
	[::Legends.Camp.CampBuildings.Fletcher] = "HasLegendCampFletching",
	[::Legends.Camp.CampBuildings.Gatherer] = "HasLegendCampGathering",
	[::Legends.Camp.CampBuildings.Healer] = "HasLegendCampHealing",
	//[::Legends.Camp.CampBuildings.Hunter] = "HasLegendCampHunting",
	[::Legends.Camp.CampBuildings.Kitchen] = "HasLegendCampCooking",
	[::Legends.Camp.CampBuildings.Painter] = "HasLegendCampPainter",
	[::Legends.Camp.CampBuildings.Scout] = "HasLegendCampScouting",
	[::Legends.Camp.CampBuildings.Workshop] = "HasLegendCampScrapping",
	[::Legends.Camp.CampBuildings.Training] = "HasLegendCampTraining"
}

::Legends.Camp.Upgrades <- {
	[::Legends.Camp.CampBuildings.Crafting] = "upgrade.crafting",
	[::Legends.Camp.CampBuildings.Enchanter] = "upgrade.enchanter",
	[::Legends.Camp.CampBuildings.Fletcher] = "upgrade.fletcher",
	[::Legends.Camp.CampBuildings.Gatherer] = "upgrade.gatherer",
	[::Legends.Camp.CampBuildings.Healer] = "upgrade.healer",
	[::Legends.Camp.CampBuildings.Kitchen] = "upgrade.kitchen",
	[::Legends.Camp.CampBuildings.Repair] = "upgrade.repair",
	[::Legends.Camp.CampBuildings.Scout] = "upgrade.scout",
	[::Legends.Camp.CampBuildings.Training] = "upgrade.training",
	[::Legends.Camp.CampBuildings.Workshop] = "upgrade.workshop",
};

::Legends.Camp.Tent <- {
	Craft = "tent.craft_tent",
	Enchant = "tent.enchant_tent",
	Fletcher = "tent.fletcher_tent",
	Gather = "tent.gather_tent",
	Healer = "tent.healer_tent",
	Kitchen = "tent.kitchen_tent",
	Hunter = "tent.hunter_tent", //mfd
	Repair = "tent.repair_tent",
	Scout = "tent.scout_tent",
	Scrap = "tent.scrap_tent",
	Training = "tent.training_tent"
};

::Legends.Camp.Tents <- [{
		ID = ::Legends.Camp.Tent.Craft,
		Script = "tents/legend_tent_craft"
	}, {
		ID = ::Legends.Camp.Tent.Enchant,
		Script = "tents/legend_tent_enchant"
	}, {
		ID = ::Legends.Camp.Tent.Fletcher,
		Script = "tents/legend_tent_fletcher"
	}, {
		ID = ::Legends.Camp.Tent.Gather,
		Script = "tents/legend_tent_gather"
	}, {
		ID = ::Legends.Camp.Tent.Healer,
		Script = "tents/legend_tent_heal"
	}, /*{
		ID = ::Legends.Camp.Tent.Hunter,
		Script = "tents/legend_tent_hunter"
	},{
		ID = ::Legends.Camp.Tent.Kitchen,
		Script = "tents/legend_tent_kitchen"
	},*/
	 {
		ID = ::Legends.Camp.Tent.Repair,
		Script = "tents/legend_tent_repair"
	}, {
		ID = ::Legends.Camp.Tent.Scout,
		Script = "tents/legend_tent_scout"
	}, {
		ID = ::Legends.Camp.Tent.Scrap,
		Script = "tents/legend_tent_scrap"
	}, {
		ID = ::Legends.Camp.Tent.Training,
		Script = "tents/legend_tent_train"
	}
];
