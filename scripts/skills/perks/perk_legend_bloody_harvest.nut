this.perk_legend_bloody_harvest <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBloodyHarvest);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAOE() && _skill.isAttack() && !_skill.isRanged())
		{
			_properties.DamageTotalMult *= 1.1;
			_properties.MeleeSkill += 10;
			_skill.m.HitChanceBonus += 10;
		}
	}

});

