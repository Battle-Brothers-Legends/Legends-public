this.perk_legend_holy_flame <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHolyFlame);
		this.m.Icon = "ui/perks/holyfire_circle.png";
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendHolyFlame)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendHolyFlame);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendHolyFlame);
	}
});
