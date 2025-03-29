::Const.World.TerrainScript.extend([
	"world.tile.swamp_green",
	"world.tile.swamp_forest",
]);

::Const.World.TerrainTypeSpeedMult = [
	0.0,
	0.0,
	1.0,
	0.5,
	0.64,
	0.64,
	0.64,
	0.64,
	0.64,
	0.25,
	0.5,
	1.0,
	0.75,
	0.9,
	0.9,
	1.0,
	0.5,
	0.75,
	0.9,
	0.64,
	0.64,
];
::Const.World.TerrainTypeVisibilityMult = [
	1.0,
	1.0,
	1.0,
	0.9,
	0.9,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	0.9,
	0.9,
	0.9,
];
::Const.World.TerrainTypeVisionRadiusMult = [
	1.0,
	1.0,
	1.0,
	1.0,
	1.25,
	1.0,
	1.0,
	1.0,
	1.0,
	2.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
];

::Const.World.TerrainFoodConsumption = [
	0.0,
	1.0,
	1.0,
	1.1,
	1.1,
	1.0,
	1.1,
	1.0,
	1.0,
	2.0,
	1.0,
	1.0,
	1.1,
	1.25,
	1.0,
	1.1,
	1.0,
	1.5,
	1.0,
	0.9,
	0.9
];

::Const.World.TerrainTypeLineBattle = [
	false,
	false,
	true,
	false,
	true,
	false,
	false,
	false,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true
];

::Const.World.TerrainTacticalTemplate.extend([
	"tactical.swamp_green",
	"tactical.swamp_forest"
]);

::Const.World.TerrainTacticalImage.extend([
	"engage/engage_swamp_green",
	"engage/engage_swamp_forest"
]);

::Const.World.TerrainSettlementImages.extend([
	{
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/village_bg_07",
		Ramp = "ui/settlements/ramp_06",
		Mood = "ui/settlements/mood_swamp"
	},
	{
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/village_bg_07",
		Ramp = "ui/settlements/ramp_06",
		Mood = "ui/settlements/mood_swamp"
	}
]);

::Const.World.SpeedSettings.FastMult = 2.5;
::Const.World.SpeedSettings.EscortMult = 4;
::Const.World.SpeedSettings.CampMult = 2.5;

local reset = ::Const.World.Buildings.reset;
::Const.World.Buildings.reset = function()
{
	reset();
	this.Stables = 0;
};
