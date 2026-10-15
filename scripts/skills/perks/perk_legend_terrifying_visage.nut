this.perk_legend_terrifying_visage <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTerrifyingVisage);
	}

	function onUpdate(_properties) {
		_properties.Threat += 15;
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
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendTerrifyingVisage)) {
			::Legends.Actives.remove(this, ::Legends.Active.HorrificScream);
		}
	}
});
