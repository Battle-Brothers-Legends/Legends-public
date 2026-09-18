this.perk_legend_horrify <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorrify);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.HorrificScream)) {
			::Legends.Actives.grant(this, ::Legends.Active.HorrificScream, function (_skill) {
				_skill.m.ActionPointCost = 6;
				_skill.m.FatigueCost = 30;
				_skill.m.MaxRange = 4;
				_skill.m.Icon = "skills/legend_horrific_scream.png";
				_skill.m.IconDisabled = "skills/legend_horrific_scream_bw.png";
			}.bindenv(this));
		}
	}

	function onRemoved() {
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendHorrify)) {
			::Legends.Actives.remove(this, ::Legends.Active.HorrificScream);
		}
	}
});
