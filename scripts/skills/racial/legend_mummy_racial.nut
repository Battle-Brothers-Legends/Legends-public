this.legend_mummy_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_mummy";
		this.m.Name = "Resistant to Ranged Attacks";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.2;
				}
				else
				{
					if (_skill.isRanged())
					{
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon))
						{
							if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
							{
								_properties.DamageReceivedRegularMult *= 0.2;
							}
							else if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
							{
								_properties.DamageReceivedRegularMult *= 0.66;
							}
							else if (weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
							{
								_properties.DamageReceivedRegularMult *= 0.5;
							}
							else
							{
								_properties.DamageReceivedRegularMult *= 0.2;
							}
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.2;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.75;
					}
				}
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.25;
				break;
		}

		if (_skill != null && ::Legends.isLegendaryDifficulty())
		{
			_properties.DamageReceivedRegularMult *= 0.75;
		}
	}

	function onDeathWithInfo( _killer, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_killer != null)
		{
			::Legends.Effects.grant(_killer, ::Legends.Effect.LegendMummyCurse);
		}
	}
});
