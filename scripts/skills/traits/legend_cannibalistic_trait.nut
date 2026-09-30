this.legend_cannibalistic_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},

	function create() {
		this.character_trait.create();
		::Legends.Traits.onCreate(this, ::Legends.Trait.LegendCannibalistic);
		this.m.Description = "This character has tasted forbidden meat and has since developed a craving for it.";
	}

	function getTooltip() {
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
				id = 3,
				type = "text",
				text = "Provides additional recipes at camp crafting"
			}
		];
	}
});
