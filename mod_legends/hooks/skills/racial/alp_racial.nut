::mods_hookExactClass("skills/racial/alp_racial", function(o)
{
	o.onBeforeDamageReceived = function ( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.2; 
				}
				else
				{					
					if (_skill.isRanged())
					{				
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
						{
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
							{
								_properties.DamageReceivedRegularMult *= 0.1;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(this.Const.Items.WeaponType.Firearm))
							{
								_properties.DamageReceivedRegularMult *= 0.33;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
							{
								if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowSpear))
								{
									_properties.DamageReceivedRegularMult *= 0.5;
								}
								else
								{
									_properties.DamageReceivedRegularMult *= 0.25;
								}								
							}
							else
							{
								_properties.DamageReceivedRegularMult *= 0.25;
							}
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.2;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.5;
					}
				}
				break;

			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.25;
				break;

			case this.Const.Damage.DamageType.Cutting:
				if (_skill != null)
				{
					if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.WardogBite) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.WolfBite) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.WarhoundBite))
					{
						_properties.DamageReceivedRegularMult *= 0.33;
					}
					else if (this.getContainer().getActor().getFlags().has("demon"))
					{
						_properties.DamageReceivedRegularMult *= 0.9;
					}
				}
				break;
		}
	}
});
