this.perk_legend_forceful_swing<- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendForcefulSwing);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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

