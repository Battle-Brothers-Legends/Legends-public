::mods_hookExactClass("skills/actives/split_shield", function(o)
{
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
			if (shield.getID() == "weapon.legend_parrying_dagger")
			{
				damage = damage * 0.20;
			}
			else if (shield.getID() == "shield.legend_named_parrying_dagger")
			{
				damage = damage * 0.20;
			}

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);

			if (shield != null && shield.getCondition() == 0)
			{
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					local logMessage = this.Const.UI.getColorizedEntityName(_user) + " has destroyed " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s shield"
					if (this.getContainer().hasPerk(::Const.Perks.PerkDefs.LegendSmashingShields))
					{
						_user.setActionPoints(this.Math.min(_user.getActionPointsMax(), _user.getActionPoints() + 4));
						this.Tactical.EventLog.log(logMessage + " and recovered 4 Action Points");
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

			if (!this.Tactical.getNavigator().isTravelling(target))
			{
				this.Tactical.getShaker().shake(target, _user.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetHit(this, _targetTile.getEntity(), this.Const.BodyPart.Body, 0, 0);
			}
		}

		return true;
	}

});
