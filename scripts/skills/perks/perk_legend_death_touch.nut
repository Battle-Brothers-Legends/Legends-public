this.perk_legend_death_touch <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDeathTouch);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendDeathTouch)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendDeathTouch);
		}
	}
	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendDeathTouch);
	}
});
