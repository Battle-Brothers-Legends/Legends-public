this.perk_legend_raise_undead <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRaiseUndead);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.RaiseUndead)) {
			::Legends.Actives.grant(this, ::Legends.Active.RaiseUndead, function (_skill) {
				_skill.m.ActionPointCost = 4;
				_skill.m.FatigueCost = 20;
				_skill.m.MinRange = 1;
				_skill.m.MaxRange = 8;
				_skill.m.MaxLevelDifference = 4;
			}.bindenv(this));
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.RaiseUndead);
	}

});