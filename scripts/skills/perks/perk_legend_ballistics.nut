this.perk_legend_ballistics <- this.inherit("scripts/skills/skill", {
	m = {
		BonusRange = 1,
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBallistics);
	}

	function onUpdate( _properties ) {
		_properties.HitChanceAdditionalWithEachTile += 2;
	}

	function onAfterUpdate( _properties ) {
		local s = ::Legends.Actives.get(this, ::Legends.Active.FireHandgonne);
		if (s != null) {
			s.m.MaxRange += this.m.BonusRange;
			// The getTooltip() function in fire_handgonne_skill has logic to display this bonus
		}
	}

});

