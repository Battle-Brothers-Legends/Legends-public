::mods_hookExactClass("contracts/contracts/root_out_undead_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Purge the Undead";
		this.m.DescriptionTemplates = [
			"The fiends must be driven back, lest the dead consume us all.",
			"Even reanimated bones can fall, even the dead can die again.",
			"Driving out the unholy corruption is an endless battle, but one that must be fought.",
			"Death cannot be escaped. But with the right actions, it can be postponed.",
		];
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