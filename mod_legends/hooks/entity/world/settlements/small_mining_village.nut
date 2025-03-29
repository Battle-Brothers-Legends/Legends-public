::mods_hookExactClass("entity/world/settlements/small_mining_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"apprentice_background",
			"beggar_background",
			"brawler_background",
			"daytaler_background",
			"graverobber_background",
			"mason_background",
			"messenger_background",
			"miner_background",
			"miner_background",
			"miner_background",
			"miner_background",
			"peddler_background",
			"thief_background",
			"poacher_background",
			"apprentice_background",
			"female_beggar_background",
			"brawler_background",
			"female_daytaler_background",
			"graverobber_background",
			"mason_background",
			"messenger_background",
			"miner_background",
			"miner_background",
			"miner_background",
			"miner_background",
			"peddler_background",
			"female_thief_background",
			"poacher_background"
		];
	}
});