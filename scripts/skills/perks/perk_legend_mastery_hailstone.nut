// Hailstone Perk - increase hailstone base da
this.perk_legend_mastery_hailstone <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryHailstone);
	}

});
