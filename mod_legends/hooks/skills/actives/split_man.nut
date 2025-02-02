::mods_hookExactClass("skills/actives/split_man", function(o)
{
	o.m.IsOrcWeapon <- false;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.isHidden <- function()
	{
		return this.m.IsOrcWeapon && !this.getContainer().getActor().getSkills().getSkillByID("special.double_grip").canDoubleGrip();
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

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local targetEntity = _targetTile.getEntity();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && this.m.ApplyBonusToBodyPart != -1 && !_targetTile.IsEmpty && targetEntity.isAlive())
		{
			local p = this.getContainer().buildPropertiesForUse(this, targetEntity);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			local damageRegular = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult * 0.5;
			local damageArmor = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageArmorMult * 0.5;
			local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
			hitInfo.DamageRegular = damageRegular;
			hitInfo.DamageArmor = damageArmor;
			hitInfo.DamageDirect = damageDirect;
			hitInfo.BodyPart = this.m.ApplyBonusToBodyPart;
			hitInfo.BodyDamageMult = 1.0;
			local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd));
			hitInfo.DamageDirect = damageDirect;
			targetEntity.onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			this.m.ApplyBonusToBodyPart = -1;
		}

		return success;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate( _properties );
		if (this.m.IsOrcWeapon)
			this.m.ActionPointCost = 5;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTooltipMinMult *= 1.5
			_properties.DamageTooltipMaxMult *= 1.5
		}
	}

});
