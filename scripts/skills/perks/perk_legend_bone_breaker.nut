this.perk_legend_bone_breaker <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBoneBreaker);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == null)
			return;

		if (!_skill.isAttack())
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		if (!_targetEntity.isPlacedOnMap())
			return;

		if (_hitInfo.DamageRegular == 0 && _hitInfo.DamageArmor == 0)
			return;

		if (_hitInfo.DamageDirect >= 1.0)
			return;

		// recalculating everything cause there's nowhere to hook
		local actor = this.getContainer().getActor();
		local p = _targetEntity.m.Skills.buildPropertiesForBeingHit(actor, _skill, _hitInfo);
		_targetEntity.m.Items.onBeforeDamageReceived(actor, _skill, _hitInfo, p);
		local dmgMult = p.DamageReceivedTotalMult * (_skill.isRanged() ? p.DamageReceivedRangedMult : p.DamageReceivedMeleeMult);
		local armorDamage = _hitInfo.DamageArmor - p.DamageArmorReduction;
		local armor = p.Armor[_hitInfo.BodyPart] * p.ArmorMult[_hitInfo.BodyPart];
		armorDamage *= p.DamageReceivedArmorMult * dmgMult;
		armorDamage = this.Math.max(this.Math.min(armor, armorDamage), 0);
		_hitInfo.DamageRegular += armorDamage * 0.1;
	}
});
