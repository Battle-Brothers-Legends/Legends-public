this.legend_haunted_02_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_haunted_02";
		this.m.Name = "Spooked by spirit runes";
		this.m.Icon = "ui/traits/trait_haunted_02.png";
		this.m.Description = "This character is carrying two spirit enchanted runes. If these work, then that must mean spirits are real. Are they carrying the souls of the dead? An unsettling thought.";
		this.m.Excluded = [
		];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve at morale checks against fear, panic or mind control effects"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Has either [color=" + this.Const.UI.Color.PositiveValue + "]+6[/color] or [color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve randomly at every morale check"
			}

		];
	}
	
});

