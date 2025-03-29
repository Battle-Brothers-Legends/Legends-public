::mods_hookExactClass("contracts/contracts/hunting_hexen_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Secrets, magic, contracts in blood. The local lord\'s firstborn is in danger after a foolish deal with a Hag.",
			"Her beauty is flawless, her heart cruel, her talons razor sharp. Careful she does not claim your soul.",
			"With a mere whisper, the witch can ensnare the hearts of men, twisting their desires to serve her own dark purposes.",
			"Beware the witch\'s beauty, for behind her beguiling facade lies a heart as cold and merciless as winter\'s frost.",
			"Most who cross paths with a hexen are doomed to fall under her spell, their minds clouded until they are nothing but pawns in her sinister games.",
			"Hexen cunning knows no bounds. They prey upon the weaknesses of men, enthralling them with promises of power and pleasure.",
			"Beneath her seductive guise lies a heart as black as pitch.",
			"Beware the hexen, for she is a creature of unfathomable malice, whose thirst for power knows no bounds.",
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
