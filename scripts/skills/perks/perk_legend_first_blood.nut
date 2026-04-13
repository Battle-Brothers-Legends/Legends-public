this.perk_legend_first_blood <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFirstBlood);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == null || !_skill.isAttack())
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		if (_targetEntity.getHitpointsPct() == 1.0)
		{
			_properties.DamageTotalMult *= 1.2;
			_properties.ThresholdToInflictInjuryMult *= 1.5;
		}
	}

});
