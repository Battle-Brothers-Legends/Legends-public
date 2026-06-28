this.perk_legend_wind_reader <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWindReader);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function onBeingAttacked( _attacker, _skill, _properties ) {
		local dist = _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		_properties.RangedDefense += this.Math.max(10, this.Math.floor(dist * (1 + this.getContainer().getActor().getBaseProperties().getRangedDefense() * 0.1)));
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_targetEntity != null) {
			local actor = this.getContainer().getActor();
			local difference = actor.getTile().getDistanceTo(_targetEntity.getTile());
			_properties.DamageRegularMin += difference * 2;
			_properties.DamageRegularMax += difference * 2;
		}
	}
});
