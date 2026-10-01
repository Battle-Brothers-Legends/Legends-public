this.perk_legend_possession <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPossession);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendPossessUndead)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendPossessUndead);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendPossessUndead);
	}
});
