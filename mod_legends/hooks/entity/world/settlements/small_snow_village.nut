::mods_hookExactClass("entity/world/settlements/small_snow_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"beggar_background",
			"brawler_background",
			"brawler_background",
			"cultist_background",
			"daytaler_background",
			"lumberjack_background",
			"mason_background",
			"miner_background",
			"flagellant_background",
			"poacher_background",
			"thief_background",
			"vagabond_background",
			"wildman_background",
			"wildman_background",
			"female_beggar_background",
			"brawler_background",
			"brawler_background",
			"cultist_background",
			"female_daytaler_background",
			"lumberjack_background",
			"mason_background",
			"miner_background",
			"flagellant_background",
			"poacher_background",
			"female_thief_background",
			"vagabond_background",
			"wildman_background",
			"wildman_background"
		];
	}
});