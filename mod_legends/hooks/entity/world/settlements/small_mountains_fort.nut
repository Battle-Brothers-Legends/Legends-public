::mods_hookExactClass("entity/world/settlements/small_mountains_fort", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"apprentice_background",
			"houndmaster_background",
			"beggar_background",
			"beggar_background",
			"brawler_background",
			"daytaler_background",
			"mason_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"vagabond_background",
			"witchhunter_background",
			"bastard_background",
			"deserter_background",
			"deserter_background",
			"retired_soldier_background",
			"retired_soldier_background",
			"apprentice_background",
			"houndmaster_background",
			"brawler_background",
			"female_daytaler_background",
			"mason_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"vagabond_background",
			"witchhunter_background",
			"bastard_background",
			"deserter_background",
			"deserter_background",
			"retired_soldier_background",
			"retired_soldier_background"
		];
		this.m.StablesList = [
			"legend_donkey_background",
			"legend_horse_rouncey"
		];
	}
});