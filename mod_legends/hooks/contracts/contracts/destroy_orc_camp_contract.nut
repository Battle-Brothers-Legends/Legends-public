::mods_hookExactClass("contracts/contracts/destroy_orc_camp_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Orc Warcamp";
		this.m.DescriptionTemplates = [
			"A brutal greenskin warcamp has settled near %s, becoming the source of much death and strife in the region.",
			"To greenskins it\'s less of a camp and more of a recreational deathpit.",
			"The looming presence of a greenskin warcamp nearby casts a dark cloud over this town\'s future.",
			"Residents of %s live in constant dread with a greenskin warcamp lurking dangerously close by.",
			"Few are brave or stupid enough to walk into an orc camp. You reckon the company can provide plenty of both.",
			"Life in an orc warcamp is a never-ending cycle of violence. You plan to add to that.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Origin.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		
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
				s.Title = "The Orc Warcamp";
			}
		}
	}
});