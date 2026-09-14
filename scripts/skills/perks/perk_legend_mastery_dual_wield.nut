this.perk_legend_mastery_dual_wield <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecDualWield);
	}

	// Implementation in perk_legend_ambidextrous.nut

});
