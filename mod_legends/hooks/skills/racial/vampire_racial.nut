::mods_hookExactClass("skills/racial/vampire_racial", function (o) {
	o.m.EffectiveWeapons <- [
		"weapon.goblin_crossbow",
		"weapon.legend_wooden_stake",
		"weapon.legend_named_goblin_crossbow"
	];

	o.onBeforeDamageReceived <- function (_attacker, _skill, _hitInfo, _properties) {
		if (_skill != null) {
			local weapon = _skill.getItem();
			if (weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon)) {
				if (this.m.EffectiveWeapons.find(weapon.getID()) != null && _skill.isRanged()) {
					_hitInfo.DamageRegular += 100;
					_hitInfo.DamageArmor += 100;
				}

				if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow)) {
					_properties.DamageReceivedRegularMult *= 1.2;
				}
				if (weapon.getID() == "weapon.legend_wooden_spear") {
					_properties.DamageReceivedRegularMult *= 5.0;
				}
			}
		}
	}

	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (::Legends.S.isEntityNullOrDead(_targetEntity) || _targetEntity.getCurrentProperties().IsImmuneToBleeding) {
			return;
		}

		onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
	}
});
