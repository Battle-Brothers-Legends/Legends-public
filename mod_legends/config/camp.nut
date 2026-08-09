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
	Painter = "camp.painter" //PaintingTent
};
::Legends.Camp.TerrainCampImages <- [
	{},
	{
		Foreground = null,
		Background = null,
		Ramp = null,
		Mood = null
	},
	{
		Foreground = null,
		Background = "ui/settlements/camp_bg_01",
		Mood = "ui/settlements/mood_grass"
	},
	{
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/camp_bg_07",
		Mood = "ui/settlements/mood_swamp"
	},
	{
		Foreground = "ui/settlements/foreground_01",
		Background = "ui/settlements/camp_bg_06",
		Mood = "ui/settlements/mood_dark_mountains"
	},
	{
		Foreground = "ui/settlements/foreground_05",
		Background = "ui/settlements/camp_bg_05",
		Mood = "ui/settlements/mood_dark_forest"
	},
	{
		Foreground = "ui/settlements/foreground_05",
		Background = "ui/settlements/camp_bg_05",
		Mood = "ui/settlements/mood_snow"
	},
	{
		Foreground = "ui/settlements/foreground_02",
		Background = "ui/settlements/camp_bg_02",
		Mood = "ui/settlements/mood_forest"
	},
	{
		Foreground = "ui/settlements/foreground_07",
		Background = "ui/settlements/camp_bg_03",
		Mood = "ui/settlements/mood_forest"
	},
	{
		Foreground = "ui/settlements/foreground_01",
		Background = "ui/settlements/camp_bg_06",
		Mood = "ui/settlements/mood_dark_mountains"
	},
	{},
	{},
	{
		Foreground = "ui/settlements/foreground_03",
		Background = "ui/settlements/camp_bg_04",
		Mood = "ui/settlements/mood_snow"
	},
	{},
	{
		Foreground = null,
		Background = "ui/settlements/camp_bg_09",
		Mood = "ui/settlements/mood_tundra"
	},
	{
		Foreground = null,
		Background = "ui/settlements/camp_bg_08",
		Mood = "ui/settlements/mood_steppe"
	},
	{
		Foreground = null,
		Background = null,
		Ramp = null
	},
	{
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/camp_bg_10",
		Mood = "ui/settlements/mood_steppe"
	},
	{
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/camp_bg_10",
		Mood = "ui/settlements/mood_steppe"
	},
	{
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/camp_bg_07",
		Mood = "ui/settlements/mood_swamp"
	},
	{
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/camp_bg_07",
		Mood = "ui/settlements/mood_swamp"
	}
];



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
