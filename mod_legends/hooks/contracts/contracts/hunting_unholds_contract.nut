::mods_hookExactClass("contracts/contracts/hunting_unholds_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Folks are reporting there\'s a giant roaming around these parts, stealing livestock from farms.",
			"Giant marauders are slowly plundering the region of crops, livestock, and anything else tasty-lookin\' they can lay their colossal hands upon.",
			"Tearful shepherds claim a hungry stone giant has come down from the mountains, one which has a taste for sheep.",
			"While usually peaceful, unholds can make formidable adversaries when angered, capable of crushing men with ease.",
			"The bards may love to sing of the \'gentle giants of mountain-holm\', but in your experience unholds tend to break your arms with a single swipe and then devour your horse.",
			"Though their movements may be ponderous, unholds possess an unstoppable strength that allows them to overpower their enemies with sheer brute force, shattering armor and bones alike.",
			"Stone giants may lack speed, but their resilience and titanic strength make them fearsome adversaries.",
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
