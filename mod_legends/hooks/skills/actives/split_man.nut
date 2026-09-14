::mods_hookExactClass("skills/actives/split_man", function(o)
{
	o.m.IsOrcWeapon <- false;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.isHidden <- function() {
		local dg = this.getContainer().getActor().getSkills().getSkillByID("special.double_grip");
		local canDoubleGrip = dg != null && ("canDoubleGrip" in dg) && dg.canDoubleGrip();
		return this.m.IsOrcWeapon && !canDoubleGrip;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hits both head and body for additional damage"
		});
		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate( _properties );
		if (this.m.IsOrcWeapon)
			this.m.ActionPointCost = 5;
	}

	o.onUse = function (_user, _targetTile) {
		local targetEntity = _targetTile.getEntity();

		if (::Legends.S.isEntityNullOrDead(targetEntity)) {
			return false;
		}

		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, targetEntity);

		if (success	&& this.m.ApplyBonusToBodyPart != -1 && !_targetTile.IsEmpty && !::Legends.S.isEntityNullOrDead(_user, targetEntity) && this.getContainer() != null) {
			local p = this.getContainer().buildPropertiesForUse(this, targetEntity);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			local damageMult = p.MeleeDamageMult * p.DamageTotalMult;
			local damageRegular = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult * 0.5;
			local damageArmor = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageArmorMult * 0.5;
			local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
			hitInfo.DamageRegular = damageRegular * damageMult;
			hitInfo.DamageArmor = damageArmor * damageMult;
			hitInfo.DamageDirect = damageDirect;
			hitInfo.BodyPart = this.m.ApplyBonusToBodyPart;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 1.0;
			targetEntity.onDamageReceived(_user, this, hitInfo);
		}

		this.m.ApplyBonusToBodyPart = -1;
		return success;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTooltipMinMult *= 1.5;
			_properties.DamageTooltipMaxMult *= 1.5;
		}
	}

});
