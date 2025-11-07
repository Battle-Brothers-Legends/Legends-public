this.perk_legend_surpress_urges <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSurpressUrges);
	}


});
