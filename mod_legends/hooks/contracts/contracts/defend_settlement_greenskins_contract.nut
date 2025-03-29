::mods_hookExactClass("contracts/contracts/defend_settlement_greenskins_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Greenskins are heading this way, murdering and destroying all that stands before them. %s seeks sellsword aid.",
			"Desperation mounts in %s as the town faces the suddenly very real prospect of a greenskin raid.",
			"Fear grips the townsfolk of %s as they prepare for the imminent onslaught of an orc raid.",
			"Funds have hastily been made available to hire defenders for %s. Orcs do have a nice way of focusing the mind on current matters.",
			"Greenskins thrive on carnage, slaughter and war. You thrive on coin.",
			"The specter of an orc raid looms large over the town, casting a shadow of fear over its inhabitants.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		
		this.m.Description = r;
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = "Defend Settlement";
			}
		}
	}
});