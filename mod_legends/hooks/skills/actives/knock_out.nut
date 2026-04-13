::mods_hookExactClass("skills/actives/knock_out", function(o) {
	o.m.IsStaffKnockOut <- false;
	o.m.IsRangedKnockOut <- false;

	o.isHidden <- function() {
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		if (item != null
			&& (item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel")
			&& !this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistGravedigger))
		{
			return true;
		}

		return this.skill.isHidden();
	}

	o.setItem <- function(_item) {
		if (this.m.IsStaffKnockOut) {
			this.m.Name = "Staff Daze";
			this.m.Description = "A heavy blow intended to daze anyone unlucky enough to be hit for one turn, but not to do the most damage. Dazed targets have their damage, initiative and stamina reduced by 35%";
			this.m.Icon = "skills/staff_knock_out.png";
			this.m.IconDisabled = "skills/staff_knock_out_bw.png";
			this.m.MaxRange = 2;
		}
		if (this.m.IsRangedKnockOut) {
			this.m.Name = "Improvised Strike";
			this.m.Description = "Use the butt of your ranged weapon to hit the target. Not particularly damaging, but might get you out of a tricky situation.";
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function() {
		if (!this.m.IsStaffKnockOut && !this.m.IsRangedKnockOut) {
			return getTooltip();
		}

		local ret = this.skill.getDefaultTooltip();

		if (this.m.IsRangedKnockOut) {
			local fatExtra = 2 * this.Const.Combat.FatigueReceivedPerHit;
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=%damage%]" + fatExtra + "[/color] extra fatigue"
			});
		} else {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]2[/color] tiles"
			});
		}

		local properties = this.getContainer().getActor().getCurrentProperties();
		local effects = properties.IsSpecializedInStaffStun ? "daze, stagger and stun" : "daze";
		if (this.m.IsRangedKnockOut) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to daze and stagger on a hit, and stun if hitting the head"
			});
		} else if (properties.IsSpecializedInPolearms) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to" + effects + " on a hit"
			});
		} else if (!properties.IsSpecializedInPolearms) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]" + this.m.StunChance + "%[/color] chance to " + effects + " on a hit"
			});
		}

		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function(_properties) {
		if (this.m.IsStaffKnockOut) {
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		} else {
			onAfterUpdate(_properties);
		}
	}

	o.onUse = function(_user, _targetTile) {

		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());
		if (this.m.IsRangedKnockOut) {
			return success;
		}

		if (!_user.isAlive() || _user.isDying()) {
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor) {
			local target = _targetTile.getEntity();

			local stun = (this.m.IsStaffKnockOut ? _user.getCurrentProperties().IsSpecializedInPolearms : _user.getCurrentProperties().IsSpecializedInMaces)
				|| this.Math.rand(1, 100) <= this.m.StunChance;
			local canStun = !target.getCurrentProperties().IsImmuneToStun
				&& !target.getSkills().hasEffect(::Legends.Effect.Stunned);
			if (this.m.IsStaffKnockOut && stun) {
				if (!target.getCurrentProperties().IsImmuneToDaze) {
					::Legends.Effects.grant(target, ::Legends.Effect.Dazed);
				}

				if (_user.getCurrentProperties().IsSpecializedInStaffStun) {
					::Legends.Effects.grant(target, ::Legends.Effect.Staggered);

					if (canStun) {
						::Legends.Effects.grant(target, ::Legends.Effect.Stunned);
					}
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}
			} else if (!this.m.IsStaffKnockOut
				&& (_user.getCurrentProperties().IsSpecializedInMaces || stun)
				&& canStun)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}

				if (this.m.IsFromLute && _user.isPlayerControlled()) {
					this.updateAchievement("LuteStun", 1, 1);
				}
			}
		}

		return success;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function(_skill, _targetEntity, _properties) {
		if (this.m.IsRangedKnockOut && _skill == this) {
			_properties.DamageTotalMult *= 0.25;
			_properties.FatigueDealtPerHitMult += 2.0;
		} else {
			onAnySkillUsed(_skill, _targetEntity, _properties);
		}
	}

	o.onTargetHit <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (!this.m.IsRangedKnockOut) {
			return;
		}

		if (_skill != this) {
			return;
		}

		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) {
			return;
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered);

		if (!_targetEntity.getCurrentProperties().IsImmuneToDaze) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);
		}

		local targetTile = _targetEntity.getTile();
		local user = this.getContainer().getActor();

		if (_bodyPart == this.Const.BodyPart.Head) {
			if (!_targetEntity.getCurrentProperties().IsImmuneToStun) {
				::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Stunned);

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) {
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " stunned");
					return;
				}
			}
		}

	}

});
