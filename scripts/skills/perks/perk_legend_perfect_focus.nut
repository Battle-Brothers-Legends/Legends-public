this.perk_legend_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPerfectFocus);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.PerfectFocus)) {
			::Legends.Actives.grant(this, ::Legends.Active.PerfectFocus);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.PerfectFocus);
	}

	function onUpdate(_properties) {
		if (this.getContainer().getActor().getFlags().has("undead")) {
			_properties.ActionPoints += 3;
		}
	}

});
