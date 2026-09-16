::mods_hookExactClass("skills/racial/golem_racial", function(o)
{
	o.onBeforeDamageReceived = function ( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowGolem))
		{
			_properties.DamageReceivedTotalMult = 0.0;
			return;
		}

		switch (_hitInfo.DamageType)
		{
			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.2;
				}
				else if (_skill.isRanged())
				{
					local weapon = _skill.getItem();		
					if (weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon))
					{
						if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
						{
							_properties.DamageReceivedRegularMult *= 0.1;
						}
						else if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
						{
							_properties.DamageReceivedRegularMult *= 0.33;
						}
						else if (weapon.isWeaponType(::Const.Items.WeaponType.Throwing) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
						{
							_properties.DamageReceivedRegularMult *= 0.25;
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.2;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.1;
					}
				}
				else
				{
					_properties.DamageReceivedRegularMult *= 0.5;
				}
				break;

			case ::Const.Damage.DamageType.Burning:				
				_properties.DamageReceivedRegularMult *= 0.1;
				break;
		}
	}
});
