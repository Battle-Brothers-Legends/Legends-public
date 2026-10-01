this.perk_legend_prayer_of_hope <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrayerOfHope);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendPrayerOfHope)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrayerOfHope);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrayerOfHope);
	}
});
