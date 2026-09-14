// Chain Lightning Perk - increase range and hit chance
// TODO strings.nut
this.perk_legend_mastery_chain_lightning <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryChainLightning);
	}

});
