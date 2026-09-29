this.perk_legend_paralyze <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendParalyze);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendParalyze)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendParalyze);
		}
	}
	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendParalyze);
	}
});
