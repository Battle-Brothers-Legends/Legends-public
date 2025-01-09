this.perk_legend_bloody_harvest <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBloodyHarvest);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAOE() && _skill.isAttack())
		{
			_properties.DamageTotalMult *= 1.1;
			_properties.MeleeSkill += 10;
		}
	}

});

