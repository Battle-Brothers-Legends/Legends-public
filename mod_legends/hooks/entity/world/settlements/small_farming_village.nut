::mods_hookExactClass("entity/world/settlements/small_farming_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			"beggar_background",
			"beggar_background",
			"daytaler_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"peddler_background",
			"tailor_background",
			"vagabond_background",
			"vagabond_background",
			"female_beggar_background",
			"female_beggar_background",
			"female_daytaler_background",
			"female_butcher_background",
			"female_butcher_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"peddler_background",
			"female_tailor_background",
			"vagabond_background",
			"vagabond_background"
		];
	}
});