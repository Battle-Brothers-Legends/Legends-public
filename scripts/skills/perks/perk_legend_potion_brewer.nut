this.perk_legend_potion_brewer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPotionBrewer);
	}

});

