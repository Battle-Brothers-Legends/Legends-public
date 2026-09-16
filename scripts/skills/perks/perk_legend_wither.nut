this.perk_legend_wither <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWither);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.Wither)) {
			::Legends.Actives.grant(this, ::Legends.Active.Wither, function (_skill) {
				_skill.m.ActionPointCost = 5;
				_skill.m.FatigueCost = 15;
				_skill.m.MinRange = 1;
				_skill.m.MaxRange = 6;
				_skill.m.MaxLevelDifference = 8;
			}.bindenv(this));
		}
	}
	
	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.Wither);
	}

});
