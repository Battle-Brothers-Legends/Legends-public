::mods_hookExactClass("contracts/contracts/last_stand_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Death Denied";
		this.m.DescriptionTemplates = [
			"The dead have come for %s. Only the mad or the desperate remain there to stand against them.",
			"Life in %s is currently a grim existence, with every day bringing fresh horrors as the undead close in.",
			"Time has run out for %s, for the dead have come to claim it.",
			"Without aid, the defenders of %s will soon perish and join the ranks of the dead.",
			"As the army of the dead advances, the air grows heavy with the stench of decay. Soon they will engulf %s.",
			"With each passing moment, the army of the dead draws closer to %s. Folk have started to flee.",
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
				s.Title = this.m.Name;
			}
		}
	}
});