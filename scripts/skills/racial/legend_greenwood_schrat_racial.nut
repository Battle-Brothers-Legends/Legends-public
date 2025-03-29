this.legend_greenwood_schrat_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_greenwood_schrat";
		this.m.Name = "Shielded";
		this.m.Description = "";
		this.m.Icon = "skills/status_effect_86.png";
		this.m.IconMini = "status_effect_86_mini";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isArmedWithShield();
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.isArmedWithShield())
		{
			_properties.DamageReceivedTotalMult *= 0.3;
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.25; 
				}
				else
				{					
					if (_skill.isRanged())
					{				
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
						{
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
							{
								_properties.DamageReceivedRegularMult *= 0.25;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
							{
								_properties.DamageReceivedRegularMult *= 0.5;
							}
							else
							{
								_properties.DamageReceivedRegularMult *= 0.5;
							}
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.25;
						}
					}
				}
				break;

			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.50; //+50%
				break;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();

		if (_damageHitpoints >= actor.getHitpointsMax() * 0.01)
		{
			local candidates = [];
			local myTile = actor.getTile();

			for( local i = 0; i < 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = myTile.getNextTile(i);

					if (nextTile.IsEmpty && this.Math.abs(myTile.Level - nextTile.Level) <= 1)
					{
						candidates.push(nextTile);
					}
				}
			}

			if (candidates.len() != 0)
			{
				local spawnTile = candidates[this.Math.rand(0, candidates.len() - 1)];
				local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_greenwood_schrat_small", spawnTile.Coords);
				sapling.setFaction(actor.getFaction());
				sapling.riseFromGround();
			}
		}
	}
});
