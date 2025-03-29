::mods_hookExactClass("contracts/contracts/hunting_serpents_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Hissing Sands";
		this.m.DescriptionTemplates = [
			"Sand serpents. Fast, venomous, dangerous. Yet their scales are worth a small fortune.",
			"The serpents are fairly common in the dunes, whose swift strikes and potent venom make them feared predators.",
			"Beware the deadly serpents, whose sleek bodies glide effortlessly through the desert, hunting for prey.",
			"In nomad lore, sand serpents are revered as spirits of the desert, their sinuous forms embodying untamed power.",
			"In a flurry of sand and scales, desert serpents often launch deadly coordinated attacks to overwhelm travelers.",
			"They say you never forget your first snake attack. Sand, scales, screams, venom, bloody fang marks everywhere...",
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
