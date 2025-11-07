this.perk_legend_forceful_swing<- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendForcefulSwing);
	}


	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isRanged())
		{
			 return;
		}
		if (_skill.isAOE() && _skill.isAttack())
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

});

