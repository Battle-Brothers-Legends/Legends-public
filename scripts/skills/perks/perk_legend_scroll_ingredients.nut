this.perk_legend_scroll_ingredients <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendScrollIngredients);
	}
});
