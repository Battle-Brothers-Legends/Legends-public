::mods_hookExactClass("skills/racial/alp_racial", function(o) {
	o.onBeforeDamageReceived = function(_attacker, _skill, _hitInfo, _properties) {
		switch (_hitInfo.DamageType) {
			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null) {
					_properties.DamageReceivedRegularMult *= 0.2;
					break;
				}
				if (!_skill.isRanged()) {
					_properties.DamageReceivedRegularMult *= 0.5;
					break;
				}
				local weapon = _skill.getItem();
				if (!(weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon))) {
					_properties.DamageReceivedRegularMult *= 0.2;
				}
				if (weapon.isWeaponType(::Const.Items.WeaponType.Bow)) {
					_properties.DamageReceivedRegularMult *= 0.1;
				} else if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm)) {
					_properties.DamageReceivedRegularMult *= 0.33;
				} else if (weapon.isWeaponType(::Const.Items.WeaponType.Throwing)) {
					if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowSpear)) {
						_properties.DamageReceivedRegularMult *= 0.5;
					} else {
						_properties.DamageReceivedRegularMult *= 0.25;
					}
				} else {
					_properties.DamageReceivedRegularMult *= 0.25;
				}
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.25;
				break;

			case ::Const.Damage.DamageType.Cutting:
				if (_skill != null) {
					if (::Legends.S.oneOf(_skill.getID(),
						::Legends.Actives.getID(::Legends.Active.WardogBite),
						::Legends.Actives.getID(::Legends.Active.WolfBite),
						::Legends.Actives.getID(::Legends.Active.WarhoundBite)
					)) {
						_properties.DamageReceivedRegularMult *= 0.33;
					} else if (this.getContainer().getActor().getFlags().has("demon")) {
						_properties.DamageReceivedRegularMult *= 0.9;
					}
				}
				break;
		}
	}
});
