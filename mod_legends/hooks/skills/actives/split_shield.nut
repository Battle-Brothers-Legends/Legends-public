::mods_hookExactClass("skills/actives/split_shield", function(o)
{
	o.m.IsOrcWeapon <- false;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local shield = target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
			local damage = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();

			if (this.m.ApplyAxeMastery && _user.getCurrentProperties().IsSpecializedInAxes)
			{
				damage = damage + this.Math.max(1, damage / 2);
			}
			if (shield.getID() == "weapon.legend_parrying_dagger" || shield.getID() == "shield.legend_named_parrying_dagger")
			{
				damage *= 0.20;
			}

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);
			if (!this.Tactical.getNavigator().isTravelling(target))
			{
				this.Tactical.getShaker().shake(target, _user.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}
			local overflowDamage = this.Math.floor(damage - conditionBefore);

			if (shield != null && shield.getCondition() == 0)
			{
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					local logMessage = this.Const.UI.getColorizedEntityName(_user) + " has destroyed " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s shield";
					if (this.getContainer().hasPerk(::Legends.Perk.LegendSmashingShields))
					{
						_user.setActionPoints(this.Math.min(_user.getActionPointsMax(), _user.getActionPoints() + 4));
						this.Tactical.EventLog.log(logMessage + " and recovered 4 Action Points");
						if (overflowDamage > 1)
						{
							local p = this.getContainer().buildPropertiesForUse(this, target);
							local hitInfo = clone this.Const.Tactical.HitInfo;
							local damageMult = p.MeleeDamageMult * p.DamageTotalMult;
							local damageRegular = overflowDamage * p.DamageRegularMult;
							local damageArmor = overflowDamage * p.DamageArmorMult;
							local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
							hitInfo.DamageRegular = damageRegular * damageMult;
							hitInfo.DamageArmor = damageArmor * damageMult;
							hitInfo.DamageDirect = damageDirect;
							hitInfo.BodyPart = this.Const.BodyPart.Body;
							hitInfo.BodyDamageMult = 1.0;
							hitInfo.FatalityChanceMult = 0.0;
							target.onDamageReceived(this.getContainer().getActor(), this, hitInfo);
						}
					}
					else
					{
						this.Tactical.EventLog.log(logMessage);
					}
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Split Shield and hits " + this.Const.UI.getColorizedEntityName(target) + "\'s shield for [b]" + (conditionBefore - shield.getCondition()) + "[/b] damage");
				}
			}

			local overwhelm = ::Legends.Perks.get(this, ::Legends.Perk.Overwhelm);

			if (overwhelm != null && target.isAlive() && !target.isDying())
			{
				overwhelm.onTargetHit(this, _targetTile.getEntity(), this.Const.BodyPart.Body, 0, 0);
			}
		}

		return true;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate( _properties );
		if (this.m.IsOrcWeapon)
			this.m.ActionPointCost = 5;
	}

});
