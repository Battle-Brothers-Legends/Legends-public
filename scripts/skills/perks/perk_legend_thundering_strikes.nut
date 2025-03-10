this.perk_legend_thundering_strikes <- this.inherit("scripts/skills/skill", {
	m = {
		OrigArmorDirectDamageMitigationMult = 1.0,
		DidApply = false,
		ArmorEffectivenessMult = 0.15,
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendThunderingStrikes);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.m.AppliedMultiplier = _properties.DamageArmorMult * this.m.ArmorEffectivenessMult;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			local effect = _hitInfo.DamageType == ::Const.Damage.DamageType.Blunt ? 0.25 : 0.15;
			local properties = this.getContainer().getActor().getCurrentProperties();
			::Const.Combat.ArmorDirectDamageMitigationMult *= 1.0 - (properties.DamageArmorMult * effect);
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
