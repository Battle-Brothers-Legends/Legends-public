::mods_hookExactClass("contracts/contracts/hunting_alps_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Locals report recurring nightmares... something haunts the dark. Gather your courage and await nightfall.",
			"Every night, the townsfolk are gripped by fear as their nightmares manifest in chilling clarity.",
			"Howls of terror echo through the night, as townsfolk are besieged by nightmares that seem all too real.",
			"Whispers of dread fill the streets as the locals are plagued by relentless nightmares, leaving them sleepless and afraid.",
			"Every night, the nightmares descend like a shroud, tormenting the locals with visions of horror and despair.",
			"As night falls the townsfolk huddle in fear, haunted by the nameless dread that lurks in the shadows.",
			"As dawn breaks each morning, the townsfolk awaken with a sense of dread, knowing that the nightmares that haunted their sleep will return with the setting sun.",
			"As night falls the townsfolk toss and turn in their beds, haunted by nightmares that refuse to release their grip.",
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
