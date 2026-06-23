::mods_hookExactClass("skills/actives/stab", function(o) {
	o.m.IsBackstab <- false;
	o.m.IsQatalStab <- false;

	o.setItem <- function(_item) {
		this.skill.setItem(_item);
		if (this.m.IsEstocStab) {
			this.m.Name = "Thrust";
			this.m.Description = "A swift stab aiming for the weak points between the armor. You have a chance to attack up to 3 additional times based on the initiative difference between you and your target. The chance for each attack to be executed is rolled independently in increments of 100.";
			this.m.Icon = "skills/skewer_general.png";
			this.m.IconDisabled = "skills/skewer_general_bw.png";
			this.m.Overlay = "skewer_general";
			this.m.DirectDamageMult = 0.2;
			this.m.ActionPointCost = 4;
			this.m.FatigueCost = 10;
		}
		if (this.m.IsBackstab) {
			this.m.Name = "Backstab";
			this.m.Description = "A quick and fast stab that takes advantage of a distracted target. Deals an additional 5% damage and 3% penetration per target surrounding the target.";
		}
		if (this.m.IsQatalStab) {
			this.m.Description = "A quick and fast stab. If you are within a smoke cloud you will attack an additional time.";
		}
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function() {
		local ret = getTooltip();
		if (!this.m.IsEstocStab) {
			return ret;
		}

		if (::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties, this.getItem())) {
			ret.extend([{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You have a chance to attack up to [color=%positive%]3[/color] additional times based on the initiative difference between you and your target"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The chance for each attack to be executed is rolled independently in increments of 100"
			}]);
		}
		else {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You have a chance to attack an additional time based on the initiative difference between you and your target"
			});
		}

		return ret;
	}

	local onUse = o.onUse;
	o.onUse = function(_user, _targetTile) {
		if (this.m.IsEstocStab) {
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
			local ret = onUse(_user, _targetTile);
			if (::Legends.S.isEntityNullOrDead(_user))
				return ret;

			local target = _targetEntity.getEntity();

			if (::Legends.S.isEntityNullOrDead(target)) {
				return ret;
			}

			local maxIni = ::Legends.S.isCharacterWeaponSpecialized(_user.getCurrentProperties(), this.getItem()) ? 300 : 100;
			local diff = this.Math.min(target.getInitiative() - _user.getInitiative(), 300);
			while (diff > 0) {
				if (!this.Math.rand(1, 100) < diff) {
					diff -= 100;
					continue;
				}
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
					ret = this.attackEntity(_user, target) || ret;
				}
				diff -= 100;
			}

			return true;
		}
		local ret = onUse(_user, _targetTile);
		if (!this.m.IsQatalStab)
			return ret;

		if (!this.getContainer().hasEffect(::Legends.Effect.Smoke))
			return ret;

		if (::Legends.S.isEntityNullOrDead(_user))
			return ret;

		local target = _targetEntity.getEntity();

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
