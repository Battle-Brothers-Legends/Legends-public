this.perk_legend_draining_touch <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDrainingTouch);
		this.m.Overlay = "active_42";
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendDrainingTouch)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendDrainingTouch);
		}
	}
	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendDrainingTouch);
	}
});
