this.perk_legend_pummel_into_submission <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPummelIntoSubmission);
		this.m.Order = this.Const.SkillOrder.First + 2;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) {
			return;
		}

		local hitCopy = clone _hitInfo;

		local actor = this.getContainer().getActor();
		local p = _targetEntity.getSkills().buildPropertiesForBeingHit(actor, _skill, hitCopy);
		local fatDamage = this.Math.round(hitCopy.DamageFatigue * p.FatigueEffectMult * p.FatigueReceivedPerHitMult * p.FatigueLossOnAnyAttackMult);
		local overflow = _targetEntity.getFatigue() + fatDamage - _targetEntity.getFatigueMax();
		if (overflow > 0)
		{
			local distanceToTarget = _targetEntity.getTile().getDistanceTo(actor.getTile());
			local properties = this.factoringOffhand(this.getContainer().buildPropertiesForUse(_skill, _targetEntity));
			local damageMult = this.m.IsRanged ? properties.RangedDamageMult : properties.MeleeDamageMult;
			damageMult = damageMult * properties.DamageTotalMult;
			local damageRegular = (this.Math.rand(properties.DamageRegularMin, properties.DamageRegularMax) + overflow) * properties.DamageRegularMult; // adding the overflow
			local damageArmor = (this.Math.rand(properties.DamageRegularMin, properties.DamageRegularMax) + overflow) * properties.DamageArmorMult;
			damageRegular = this.Math.max(0, damageRegular + distanceToTarget * properties.DamageAdditionalWithEachTile);
			damageArmor = this.Math.max(0, damageArmor + distanceToTarget * properties.DamageAdditionalWithEachTile);
			_hitInfo.DamageRegular = damageRegular * damageMult;
			_hitInfo.DamageArmor = damageArmor * damageMult;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatigueDealtAsPercentOfMaxFatigue += 0.05;
	}
});
