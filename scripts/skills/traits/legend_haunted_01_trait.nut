this.legend_haunted_01_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_haunted_01";
		this.m.Name = "Unsettled by spirit runes";
		this.m.Icon = "ui/traits/trait_haunted_01.png";
		this.m.Description = "This character is carrying an enchanted rune. The otherworldly power is unsettling, sometimes they feel protected, other times afeared. Is it the work of spirits, or all in their mind?";
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
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+6[/color] or [color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve randomly at every morale check"
			}
		];
	}

});

