::mods_hookExactClass("contracts/contracts/drive_away_nomads_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Desert Raiders";
		this.m.DescriptionTemplates = [
			"A nomadic camp has been preying on roads to %s. Elusive and evasive, the desert tribes have been here for centuries.",
			"Life among the sand nomads is a constant journey beneath the scorching sun. Help them journey elsewhere.",
			"Amidst the dunes, the sand nomads carve out a life of resilience and adaptability. Do not underestimate them.",
			"Among the sand nomads, kinship and tradition are the bedrock of their society. Sounds lovely, but you\'ve seen what they do to unarmed traders on the roads.",
			"Sand nomads strike swiftly, their raids leaving nothing but dust and despair.",
			"Nomads haunt the desert around %s, their raids a constant threat to those who traverse the sands.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}
});
