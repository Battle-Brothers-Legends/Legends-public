::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;
	o.m.IsStaffSlash <- false;
	o.m.IsBreachSlash <- false;
	o.m.IsGreatBreachSlash <- false;
	o.m.IsShamshirSlash <- false;
	o.m.IsExecutingSecondAttack <- false;

	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = 10;
	}
	
	o.setItem <- function (_item) {
		this.skill.setItem(_item);
		if (this.m.IsGreatSlash) {
			this.m.Name = "Great Slash";
			this.m.Description = "A hefty swift slashing attack dealing average damage.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
			this.m.ActionPointCost = this.m.IsStaffSlash ? 5 : 4;
		}
		else if (this.m.IsBreachSlash) {
			this.m.Name = "Breach";
			this.m.Description = "A swift slashing attack making good use of the light blade of the weapon to maneuver around longer weapons.";
		}
		else if (this.m.IsGreatBreachSlash) {
			this.m.Name = "Breach";
			this.m.Description = "A swift slashing attack making good use of the light blade of the weapon to maneuver around longer weapons.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
		}
		else if (this.m.IsShamshirSlash) {
			this.m.Name = "Flowing Slash";
			this.m.Description = "A skillful slash that flows quickly into another attack.";
		}
	}

	o.getTooltip = function() {
		local ret = this.getDefaultTooltip();
		if (this.m.IsBreachSlash || this.m.IsGreatBreachSlash)
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]15%[/color] extra damage done against enemies armed with polearms or melee weapons that can strike over a distance"
			});
		if (this.m.IsShamshirSlash && ::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties, this.getItem()))
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will attack again on miss for [color=%positive%]50%[/color] damage"
			});
		return ret;
	}

	local onUse = o.onUse;
	o.onUse = function( _user, _targetTile ) {
		local ret = onUse(_user, _targetTile);
		if (ret)
			return ret;

		this.m.IsExecutingSecondAttack = true;
		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)) {
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function ( _skill ) {
				if (target.isAlive()) {
					_skill.attackEntity(_user, target);
					_skill.m.IsDoingAttackMove = true;
				}
			}.bindenv(this), this);
			this.m.IsExecutingSecondAttack = false;
			return true;
		}
		else {
			return this.attackEntity(_user, target) || ret;
		}

	}

	o.onAfterUpdate = function( _properties ) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.MeleeSkill += 10;

			if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
				if ((this.m.IsBreachSlash || this.m.IsGreatBreachSlash) && _targetEntity != null && _targetEntity.isArmedWithPoleWeapon()) {
					_properties.DamageTotalMult *= 1.15;
				}
				if (this.m.IsExecutingSecondAttack) {
					_properties.DamageTotalMult *= 0.5;
				}
			}
		}
	}

});
