::mods_hookExactClass("contracts/contracts/investigate_cemetery_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Disturbed Rest";
		this.m.DescriptionTemplates = [
			"Something is defiling a local cemetery. Wicked tales of ghosts, ghouls and graverobbers are spreading.",
			"Rumors abound of an eerie disturbance at the local cemetery, sending shivers down the spines of the locals.",
			"Grim rumors are spreading of dark forces at play in the nearby cemetery.",
			"Unsettling rumors swirl of strange occurrences plaguing the local cemetery.",
			"Folk speak in hushed tones of eerie sights and mysterious sounds emanating from the cemetery, fueling speculation and fear among those who dare to listen.",
			"Troubling rumors of necromancy grip the village, sparking superstition and dread among the wary inhabitants.",
			"Local gossip is running wild with tales of spirits and otherworldly terrors haunting nearby tombstones.",
			"The dead are not staying buried, causing great fear and upset among the locals.",
			"Something is wrong at the local burial grounds. The locals are too frightened to speak of it beyond fearful murmurs.",
			"Anxiety mounts as rumors circulate of a malevolent presence haunting the nearby graveyard.",
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
			if (s.ID == "Failure1")
			{
				foreach (option in s.Options)
				{
					option.Text = "Damn this! (Increase Moral Reputation)";
				}
			}
			if (s.ID == "Failure2")
			{
				foreach (option in s.Options)
				{
					option.Text = "Hrm. (Increase Moral Reputation)";
				}
			}
		}
	}
});