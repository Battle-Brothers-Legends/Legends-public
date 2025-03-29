::mods_hookExactClass("entity/world/settlements/small_steppe_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"apprentice_background",
			"beggar_background",
			"brawler_background",
			"caravan_hand_background",
			"gambler_background",
			"daytaler_background",
			"daytaler_background",
			"peddler_background",
			"refugee_background",
			"tailor_background",
			"thief_background",
			"vagabond_background",
			"poacher_background",
			"apprentice_background",
			"female_beggar_background",
			"brawler_background",
			"caravan_hand_background",
			"gambler_background",
			"female_daytaler_background",
			"female_daytaler_background",
			"peddler_background",
			"refugee_background",
			"female_tailor_background",
			"female_thief_background",
			"vagabond_background",
			"poacher_background"
		];

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_nomad")
		{
			this.m.DraftList.push("nomad_background");
			this.m.DraftList.push("nomad_ranged_background");
		}
	}
});