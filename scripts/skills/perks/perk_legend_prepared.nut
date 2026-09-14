//Author: WNTR Jimmy
this.perk_legend_prepared <- this.inherit("scripts/skills/skill", {
	m  = {},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrepared);
	}
});
