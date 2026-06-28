::mods_hookExactClass("skills/actives/stab", function(o) {
	o.m.IsBackstab <- false;
	o.m.IsQatalStab <- false;

	o.setItem <- function(_item) {
		this.skill.setItem(_item);
		if (this.m.IsQatalStab) {
			this.m.Description = "A quick and fast stab.";
		}
		if (this.m.IsBackstab) {
			this.m.Name = "Backstab";
			this.m.Description = "A quick and fast stab that takes advantage of a distracted target.";
		}
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function() {
		local ret = getTooltip();
		if (this.m.IsBackstab) {
			if (::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties, this.getItem())) {
				ret.extend([{
					id = 7,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "Deal an additional [color=%positive%]5%[/color] Damage per target surrounding the target up to a maximum of [color=%positive%]25%[/color]"
				},
				{
					id = 8,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = "An additional [color=%positive%]3%[/color] of any damage ignores armor per target surrounding the target up to a maximum of [color=%positive%]15%[/color]"
				}]);
			}
		}
		if (this.m.IsQatalStab) {
			if (::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties, this.getItem())) {
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Attack an additional time if standing in smoke"
				});
			}
		}

		return ret;
	}

	local onUse = o.onUse;
	o.onUse = function(_user, _targetTile) {
		local ret = onUse(_user, _targetTile);
		if (!this.m.IsQatalStab)
			return ret;

		if (!this.getContainer().hasEffect(::Legends.Effect.Smoke))
			return ret;

		if (::Legends.S.isEntityNullOrDead(_user))
			return ret;

		local target = _targetTile.getEntity();

		if (::Legends.S.isEntityNullOrDead(target))
			return ret;

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)) {
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function ( _skill ) {
				if (target.isAlive()) {
					_skill.attackEntity(_user, target);
					_skill.m.IsDoingAttackMove = true;
				}
			}.bindenv(this), this);
			return true;
		}
		else {
			return this.attackEntity(_user, target) || ret;
		}

	}

	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) { //!this.m.IsEstocStab &&
			this.m.ActionPointCost -= 1;
		}
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties ) {
		if (_skill != this)
			return;

		if (_targetEntity == null)
			return;

		if (!this.m.IsBackstab)
			return;

		local surroundedCount = _targetEntity.getSurroundedCount();
		if (surroundedCount > 0) {
			_properties.DamageRegularMult *= 1.0 + surroundedCount * 0.05;
			_properties.DamageDirectMult *= 1.0 + surroundedCount * 0.03;
		}

	}

});
