this.perk_legend_net_casting <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNetCasting);
	}

	function onUpdate(_properties) {
		_properties.IsSpecializedInNetCasting = true;
	}
});
