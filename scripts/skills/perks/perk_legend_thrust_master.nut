this.perk_legend_thrust_master <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendThrustMaster);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack())
			return;

		if (_skill.isRanged())
			return;

		if (!_skill.m.IsWeaponSkill)
			return;

		if (!_skill.getDamageType().contains(::Const.Damage.DamageType.Piercing))
			return;

		if (_skill.getItem() == null || _skill.getItem().isWeaponType(::Const.Items.WeaponType.Dagger))
			return;

		_properties.DamageTotalMult *= 1.15;
	}
});
