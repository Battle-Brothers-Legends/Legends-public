this.perk_legend_ballistics <- this.inherit("scripts/skills/skill", {
	m = {
		BonusRange = 1,
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBallistics);
	}

	function onAfterUpdate( _properties ) {
		local s = ::Legends.Actives.get(this, ::Legends.Active.FireHandgonne);
		if (s != null) {
			s.m.MaxRange += this.m.BonusRange;
			// The getTooltip() function in fire_handgonne_skill has logic to display this bonus
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_targetEntity != null) {
			local actor = this.getContainer().getActor();
			local difference = actor.getTile().getDistanceTo(_targetEntity.getTile());
			_properties.DamageAdditionalWithEachTile += 2;
		}
	}

});

