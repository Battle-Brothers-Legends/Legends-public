this.perk_legend_thrust_master <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendThrustMaster);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (!_skill.isAttack())
			return;

		if (_skill.isRanged())
			return;

		if (!_skill.m.IsWeaponSkill)
			return;

		if (_skill.getItem() == null || _skill.getItem().isWeaponType(this.Const.WeaponType.Dagger))
			return;

		if (_hitInfo.DamageType == ::Const.Damage.DamageType.Piercing)
		{
			_properties.DamageTotalMult *= 1.15;
		}
	}

});

