this.legend_cannibalistic <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendCannibalistic);
		this.m.Name = "Cannibalistic";
		this.m.Icon = "ui/traits/legend_cannibalistic.png";
		this.m.Description = "This character has tasted forbidden meat and has since developed a craving for it.";
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
			}
		];
	}

	function onUpdate (_properties)
	{
	}
});
