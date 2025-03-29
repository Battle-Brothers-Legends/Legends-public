::mods_hookExactClass("contracts/contracts/break_greenskin_siege_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Greenskins are besieging %s. With local forces depleted the inhabitants face a terrible slaughter.",
			"Every dawn brings fresh horrors as %s wakes to another day of orc siege.",
			"The citizens of %s cowers behind its walls, besieged by the relentless onslaught of orcs.",
			"Attacking an army of relentless greenskin besiegers is a task nobody wants.",
			"Homes burn and streets run red as %s faces the brutal siege of greenskin invaders.",
			"People are praying for the salvation of %s, which is good, as salvation never comes cheap.",
		];
	}

	// Ran when we actually add the contract
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
				s.Title = "Break the Siege";
			}
		}
	}
});