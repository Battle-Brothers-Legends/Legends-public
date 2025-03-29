::mods_hookExactClass("entity/world/settlements/large_lumber_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"legend_shieldmaiden_background", // added missing (,) here. Abyss 5/15/23
			"apprentice_background",
			"beggar_background",
			"female_bowyer_background",
			"female_bowyer_background",
			"female_bowyer_background",
			"brawler_background",
			"female_butcher_background",
			"cultist_background",
			"daytaler_background",
			"hunter_background",
			"hunter_background",
			"hunter_background",
			"killer_on_the_run_background",
			"lumberjack_background",
			"lumberjack_background",
			"lumberjack_background",
			"militia_background",
			"militia_background",
			"minstrel_background",
			"peddler_background",
			"poacher_background",
			"poacher_background",
			"poacher_background",
			"ratcatcher_background",
			"refugee_background",
			"female_servant_background",
			"tailor_background",
			"thief_background",
			"vagabond_background",
			"wildman_background",
			"wildman_background",
			"witchhunter_background",
			"bastard_background",
			"disowned_noble_background",
			"hedge_knight_background",
			"retired_soldier_background",
			"cripple_background",
			"eunuch_background",
			"legend_inventor_background",
			"anatomist_background",
			"beast_hunter_background",
			"beast_hunter_background"
		];
	}

});