::mods_hookExactClass("entity/world/settlements/small_tundra_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"brawler_background",
			"daytaler_background",
			"daytaler_background",
			"farmhand_background",
			"miner_background",
			"peddler_background",
			"poacher_background",
			"shepherd_background",
			"tailor_background",
			"vagabond_background",
			"wildman_background",
			"brawler_background",
			"female_daytaler_background",
			"female_daytaler_background",
			"female_farmhand_background",
			"miner_background",
			"peddler_background",
			"poacher_background",
			"shepherd_background",
			"female_tailor_background",
			"vagabond_background",
			"wildman_background",
			"wildman_background"
		];
	}
});