this.perk_legend_bone_breaker <- this.inherit("scripts/skills/skill", {
	m = {
		AppliedMultiplier = 1.0,
		DidApply = false,
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBoneBreaker);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local effect = _skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt) ? 0.25 : 0.15;
		this.m.AppliedMultiplier = _properties.DamageArmorMult * this.m.ArmorEffectivenessMult;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			::Const.Combat.ArmorDirectDamageMitigationMult *= 1.0 - this.m.AppliedMultiplier;
			this.m.DidApply = true;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.DidApply)
		{
			::Const.Combat.ArmorDirectDamageMitigationMult /= 1.0 - this.m.AppliedMultiplier;
			this.m.DidApply = false;
		}
	}
});
