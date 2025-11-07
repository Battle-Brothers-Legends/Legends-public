this.perk_legend_cascade <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCascade);
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 13;
	}

});
