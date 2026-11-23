::mods_hookExactClass("skills/actives/split_shield", function (o) {
	o.m.IsHammer <- false;
	o.m.OverflowDamage <- 0;

	local create = o.create;
	o.create = function () {
		create();
		this.m.DirectDamageMult = 0.4;
	}

	o.setItem <- function (_item) {
		this.skill.setItem(_item);
		if (this.m.IsHammer) {
			this.m.Name = "Shatter Shield";
		}
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		if (::Legends.Effects.has(this, ::Legends.Effect.DoubleGrip)
			&& ::Legends.Effects.get(this, ::Legends.Effect.DoubleGrip).canDoubleGrip())
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "[color=%positive%]25%[/color] bonus damage to shields from Double Grip"
			});
		}

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Any positive damage difference between the skill\'s shield damage and the target\'s shield condition will be dealt as damage to the body"
		});

		if (this.getContainer().hasPerk(::Legends.Perk.LegendSmashingShields)) {
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Destroying the shield will refund [color=%positive%]4[/color] Action Points"
			});

			local actor = this.getContainer().getActor();
			if (::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Axe)) {
				local oh = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
				if (oh != null) {
					ret.push({
						id = 11,
						type = "text",
						icon = "ui/icons/shield_damage.png",
						text = "[color=%positive%]+" + oh.getShieldDamage() + "[/color] shield damage from dual wielding axes"
					});
				}
			}
		}
		return ret;
	}

	o.calculateDamage <- function (_target) {
		local actor = this.getContainer().getActor();
		local mastery = this.m.ApplyAxeMastery && actor.getCurrentProperties().IsSpecializedInAxes;
		local damage = this.getItem().getShieldDamage();
		local shield = _target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (::Legends.Perks.has(actor, ::Legends.Perk.LegendSmashingShields)
			&& ::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Axe))
		{
			local oh = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			if (oh != null) {
				damage += oh.getShieldDamage();
			}
		}

		if (mastery) {
			damage += this.Math.max(1, damage / 2);
		}

		if (shield.getID() == "shield.legend_parrying_dagger"
			|| shield.getID() == "shield.legend_named_parrying_dagger")
		{
			damage *= 0.20;
		}

		return this.Math.floor(damage);
	}

	o.onUse = function (_user, _targetTile) {
		local target = _targetTile.getEntity();
		local shield = target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null) {
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);

			if (this.m.IsHammer) {
				if (::Legends.S.skillEntityAliveCheck(_user, target)) {
					return true;
				}

				local stagger = ::Legends.Effects.grant(target, ::Legends.Effect.Staggered);
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer && !target.getFlags().has("tail")) {
					this.Tactical.EventLog.log(stagger.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(target)));
				}
			}

			local damage = calculateDamage(target);

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);
			if (!this.Tactical.getNavigator().isTravelling(target)) {
				this.Tactical.getShaker().shake(target, _user.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}

			local overflowDamage = this.Math.floor(damage - conditionBefore);

			if (shield != null && shield.getCondition() == 0) {
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					local logMessage = this.Const.UI.getColorizedEntityName(_user) + " has destroyed " + this.Const.UI.getColorizedEntityName(target) + "\'s shield";
					if (this.getContainer().hasPerk(::Legends.Perk.LegendSmashingShields)) {
						_user.setActionPoints(this.Math.min(_user.getActionPointsMax(), _user.getActionPoints() + 4));
						this.Tactical.EventLog.log(logMessage + " and recovered 4 Action Points");
						if (overflowDamage > 0) {
							this.m.OverflowDamage = overflowDamage;
							this.attackEntity(_user, target);
							this.m.OverflowDamage = 0;
						}
					} else {
						this.Tactical.EventLog.log(logMessage);
					}
				}
			} else {
				if (this.m.SoundOnHit.len() != 0) {
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Split Shield and hits " + this.Const.UI.getColorizedEntityName(target) + "\'s shield for [b]" + (conditionBefore - shield.getCondition()) + "[/b] damage");
				}
			}

			if (::Legends.S.skillEntityAliveCheck(_user, target)) {
				return true;
			}

			local overwhelm = ::Legends.Perks.get(this, ::Legends.Perk.Overwhelm);

			if (overwhelm != null && target.isAlive() && !target.isDying()) {
				overwhelm.onTargetHit(this, _targetTile.getEntity(), this.Const.BodyPart.Body, 0, 0);
			}
		}

		return true;
	}

	o.onAfterUpdate = function (_properties) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.m.MaxRange == 2) {
			this.m.ActionPointCost -= 1;
		}
	}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill != this) {
			return;
		}

		if (this.m.MaxRange > 1) {
			if (_targetEntity != null
				&& !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes
				&& this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
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
