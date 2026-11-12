::mods_hookExactClass("skills/actives/knock_out", function (o) {
	o.m.IsStaffKnockOut <- false;

	o.isHidden <- function () {
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (item != null && (item.getID() == "weapon.legend_shovel") && !this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistGravedigger)) {
			return true;
		}

		return this.skill.isHidden();
	}

	o.setItem <- function (_item) {
		if (this.m.IsStaffKnockOut) {
			this.m.Name = "Staff Daze";
			this.m.Description = "A heavy blow intended to daze anyone unlucky enough to be hit for one turn, but not to do the most damage. Dazed targets have their damage, initiative and stamina reduced by 35%";
			this.m.Icon = "skills/staff_knock_out.png";
			this.m.IconDisabled = "skills/staff_knock_out_bw.png";
			this.m.MaxRange = 2;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		if (!this.m.IsStaffKnockOut) {
			return getTooltip();
		}

		local ret = this.skill.getDefaultTooltip();
		local specialized = ::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem());
		local param = [
			["_stunChance", this.m.StunChance],
			["_effect", (specialized ? "daze, stagger and stun" : "daze")]
		];
		if (!specialized) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]%_stunChance%%[/color] chance to %_effect% on a hit",
				param = param
			});
		}

		return ret;
	}

	o.onAfterUpdate = function (_properties) {
		this.m.FatigueCostMult = ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.StunChance = ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? 100 : 75;
	}

	o.onUse = function (_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (::Legends.S.isEntityNullOrDead(_user) || ::Legends.S.isEntityNullOrDead(target)) {
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor) {
			local stun = ::Math.rand(1, 100) <= this.m.StunChance;
			local canStun = !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasEffect(::Legends.Effect.Stunned);
			if (this.m.IsStaffKnockOut && stun) {
				local appliedEffects = [];
				if (!target.getCurrentProperties().IsImmuneToDaze) {
					::Legends.Effects.grant(target, ::Legends.Effect.Dazed);
					appliedEffects.push("dazed");
				}

				if (_user.getCurrentProperties().IsSpecializedInStaffStun) {
					::Legends.Effects.grant(target, ::Legends.Effect.Staggered);
					appliedEffects.push("staggered");

					if (canStun) {
						::Legends.Effects.grant(target, ::Legends.Effect.Stunned);
						appliedEffects.push("stunned");
					}
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer && appliedEffects.len() > 0) {
					local effect = (appliedEffects.len() == 1 ? appliedEffects[0] : (appliedEffects.len() == 2 ? appliedEffects[0] + " and " + appliedEffects[1] : appliedEffects[0] + ", " + appliedEffects[1] + ", and " + appliedEffects[2]));
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has " + effect + " " + ::Const.UI.getColorizedEntityName(target) + " for one turn");
				}
			} else if (!this.m.IsStaffKnockOut && (_user.getCurrentProperties().IsSpecializedInMaces || stun) && canStun) {
				::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has stunned " + ::Const.UI.getColorizedEntityName(target) + " for one turn");
				}

				if (this.m.IsFromLute && _user.isPlayerControlled()) {
					this.updateAchievement("LuteStun", 1, 1);
				}
			}
		}

		return success;
	}
});
