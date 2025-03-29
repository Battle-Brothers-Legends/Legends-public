::mods_hookExactClass("contracts/contracts/hunting_schrats_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Lumberjacks keep disappearing in the forest. Some say the trees are coming alive to have their revenge.",
			"Beware the forest\'s haunted groves, where gnarled limbs and grasping roots hunger for the flesh of the living.",
			"In the depths of the forest, the possessed trees lie in wait, their twisted forms blending seamlessly with the shadows.",
			"Recently the haunted forest has claimed its toll, as lumberjacks vanish in the mist, their fate unknown.",
			"Many heedlessly enter those dark woods, only to become lost to its sinister embrace.",
			"Whispers of the vanished echo through the haunted forest, where sometimes people disappear into the shadows, never to return.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Banter")
			{
				s.Text = "[img]gfx/ui/events/event_25.png[/img]{The company is increasingly on edge, insomuch as a company would be in a forest while hunting murderous trees. Every crack of a branch has the men drawing swords and one of them screamed when a fallen leaf fell into the nape of their shirt. Your enemy is already scoring wins without even having to do anything! | The forest is making the men uneasy. You tell them to shape up for the enemy is out there one way or another, and it is not worth being fearful of that which is certain. It is you who shall be feared, the %companyname%, and these damned murderous trees will be wishing you were simple lumberjacks by the time you\'re done with them! | %randombrother% heaves %their_randombrother% weapon over %their_randombrother% shoulders and totters on with %their_randombrother% arms swinging around dramatically. %They_randombrother%\'s sizing up the forest foliage.%SPEECH_ON%Hey cap\', what you say we smash up one of these trees here and call it a day! Pitch \'em a pile of chopped wood and mulch and ain\'t no one gonna know the difference when it\'s all said and told. If they ask questions just tell \'em the bark had some bite!%SPEECH_OFF%The men laugh and you tell the sellsword you\'ll take %their_randombrother% idea into consideration.}";
			}
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
		}
	}
});
