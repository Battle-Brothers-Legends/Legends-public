::mods_hookExactClass("contracts/contracts/raze_attached_location_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Intimidation";
		this.m.DescriptionTemplates = [
			"Amid the power struggles of nobility, a series of unfortunate events can often lead to a town changing its allegiances.",
			"Misplaced pride and stubborn principles can earn a man an early grave in this world.",
			"Insulting a noble house is akin to playing with fire, as their wealth, status and connections afford them the means to exact vengeance with near impunity.",
			"Sometimes, regrettably, examples must be made of those who dare defy their noble lords.",
			"When faced with open defiance, razing problematic settlements is a favored course of action for nobility.",
			"Noblemen do not suffer insults or perceived challenges to their authority lightly.",
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
			if (s.ID == "Done")
			{
				foreach (option in s.Options)
				{
					option.Text = "We\'re done here. (Decrease Moral Reputation)";
				}
			}
		}
	}
});