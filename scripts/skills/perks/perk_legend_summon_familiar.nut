this.perk_legend_summon_cat <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonFamiliar);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendSummonFamiliar)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendSummonFamiliar);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendSummonFamiliar);
	}
});
