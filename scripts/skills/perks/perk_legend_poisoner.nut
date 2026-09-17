this.perk_legend_poisoner <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPoisoner);
	}

	function onUpdate(_properties) {
		_properties.IsImmuneToPoison = true;
	}
});
