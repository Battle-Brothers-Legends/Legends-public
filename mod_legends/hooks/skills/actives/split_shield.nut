::mods_hookExactClass("skills/actives/split_shield", function(o)
{
	o.m.IsOrcWeapon <- false;
	o.m.OverflowDamage <- 0;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.calculateDamage <- function (_target)
	{
		local mastery = this.m.ApplyAxeMastery && this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes;
		local damage = this.getItem().getShieldDamage();
		local shield = _target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (mastery)
			damage += this.Math.max(1, damage / 2);

		if (shield.getID() == "shield.legend_parrying_dagger" || shield.getID() == "shield.legend_named_parrying_dagger")
			damage *= 0.20;

		return this.Math.floor(damage);
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local shield = target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
			local damage = calculateDamage(target);

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
					local logMessage = this.Const.UI.getColorizedEntityName(_user) + " has destroyed " + this.Const.UI.getColorizedEntityName(target) + "\'s shield";
					if (this.getContainer().hasPerk(::Legends.Perk.LegendSmashingShields))
					{
						_user.setActionPoints(this.Math.min(_user.getActionPointsMax(), _user.getActionPoints() + 4));
						this.Tactical.EventLog.log(logMessage + " and recovered 4 Action Points");
						if (overflowDamage > 0)
						{
							this.m.OverflowDamage = overflowDamage;
							attackEntity(_user, target);
							this.m.OverflowDamage = 0;
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

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{	
		if (_skill != this)
			return;

		if (this.m.MaxRange > 1)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus -= 15;
			}
		}
		_properties.DamageRegularMin = this.m.OverflowDamage;
		_properties.DamageRegularMax = this.m.OverflowDamage;
		_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
	}

});
