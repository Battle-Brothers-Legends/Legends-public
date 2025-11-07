this.perk_legend_bone_breaker <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBoneBreaker);
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

		local hitCopy = clone _hitInfo;

		local actor = this.getContainer().getActor();
		local p = _targetEntity.m.Skills.buildPropertiesForBeingHit(actor, _skill, hitCopy);
		_targetEntity.m.Items.onBeforeDamageReceived(actor, _skill, hitCopy, p);

		local dmgMult = p.DamageReceivedTotalMult * (_skill.isRanged() ? p.DamageReceivedRangedMult : p.DamageReceivedMeleeMult);
		local armorDamage = hitCopy.DamageArmor - p.DamageArmorReduction;
		local armor = p.Armor[hitCopy.BodyPart] * p.ArmorMult[hitCopy.BodyPart];
		armorDamage *= p.DamageReceivedArmorMult * dmgMult;
		armorDamage = this.Math.max(this.Math.min(armor, armorDamage), 0);

		// --- Apply only our intended modification to the real hit info ---
		_hitInfo.DamageRegular += armorDamage * 0.1;
	}
});
