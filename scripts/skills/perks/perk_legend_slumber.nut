this.perk_legend_slumber <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSlumber);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendSlumber)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendSlumber);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendSlumber);
	}
});
