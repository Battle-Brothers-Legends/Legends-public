this.perk_legend_darkflight <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDarkflight);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.Darkflight)) {
			::Legends.Actives.grant(this, ::Legends.Active.Darkflight, function (_skill) {
				_skill.m.FatigueCost = 40;
			}.bindenv(this));
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.Darkflight);
	}

	function onUpdate(_properties) {
		_properties.TargetAttractionMult *= 1.33;
	}

});
