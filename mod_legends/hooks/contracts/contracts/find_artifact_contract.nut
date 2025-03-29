::mods_hookExactClass("contracts/contracts/find_artifact_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Relic Hunt";
		this.m.DescriptionTemplates = [
			"Scholars have identified a relic of immense power with which to combat the undead scourge. In these dark times, who will be the first to claim it?",
			"Ancient texts speak of a divine weapon, whispered to have been crafted to cleanse the land of the undead.",
			"Amongst the ruins of a kingdom lies the secret of a relic, said to hold the power to vanquish the undead hordes that threaten the world.",
			"Gossip is abound of stories of a relic, capable of purifying the undead with its divine radiance.",
			"In the dark corners of the world, shadows gather and whispers spread of a relic whose power could either save or doom the realm, depending on who claims it first.",
			"As the undead march ever closer, rival factions race uncover a relic that could spell the difference between life and death.",
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
				s.Title = "Relic Hunt";
			}
		}
	}
});