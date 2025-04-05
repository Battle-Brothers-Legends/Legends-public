this.legend_launch_holy_water_skill <- this.inherit("scripts/skills/actives/throw_holy_water", {
	m = {
		Item = null
		},
	function create()
	{
		this.throw_holy_water.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendLaunchHolyWater);
		this.m.Description = "Launch a flask of blessed water, with your slingstaff, towards a target, where it will shatter and spray its contents. The blessed water will burn the undead, but will not affect other targets.";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/sling_use_01.wav",
			"sounds/combat/dlc4/sling_use_02.wav",
			"sounds/combat/dlc4/sling_use_03.wav",
			"sounds/combat/dlc4/sling_use_04.wav"
		];
		this.m.Delay = 750;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 4;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 7;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
		{
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]20[/color] damage to hitpoints for [color=" + this.Const.UI.Color.DamageValue + "]3[/color] turns, all of which ignores armor"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] chance to hit bystanders at the same or lower height level as well."
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only affects undead targets"
		}]);

		local ammo = 0;
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.holy_water")
			{
				if (item.getAmmo() != 0)
				{
					ammo += item.getAmmo();
				}
			}
		}

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] use left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]No ammo left in backpack[/color]"
			});
		}

		return ret;
	}

	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function isHidden()
	{
		if (!this.getContainer().hasPerk(::Legends.Perk.LegendSlingerSpins))
			return true;
		if (this.m.Item != null && !this.m.Item.isNull())
			if (this.m.Item.getAmmo() != 0)
				return false;

		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.holy_water")
			{
				if (item.getAmmo() != 0)
				{
					this.setItem(item);
					return false;
				}
			}
		}
		this.m.Item = null;
		return true;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		if (this.m.Item != null && !this.m.Item.isNull())
			return this.m.Item.getAmmo();

		return 0;
	}

	function consumeAmmo()
	{
		if (this.m.Item != null && !this.m.Item.isNull())
			this.m.Item.consumeAmmo();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 0;
			_properties.DamageRegularMax = 0;
		}
	}

	function applyEffect( _target )
	{
		if (!_target.getFlags().has("undead"))
			return;

		::Legends.Effects.grant(_target, ::Legends.Effect.HolyWater, function(_effect) {
			_effect.resetTime();
		});
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_originTile.Level + 1 < _targetTile.Level)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.consumeAmmo();

		this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onApplyEffect.bindenv(this), {
			Skill = this,
			TargetTile = _targetTile
		});
	}

	function onApplyEffect( _data )
	{
		local targetEntity = _data.TargetTile.getEntity();

		if (_data.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
		}

		_data.Skill.applyEffect(targetEntity);

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = _data.TargetTile.getNextTile(i);

				if (this.Math.rand(1, 100) > 33)
				{
				}
				else if (nextTile.Level > _data.TargetTile.Level)
				{
				}
				else if (!nextTile.IsOccupiedByActor)
				{
				}
				else
				{
					local entity = nextTile.getEntity();
					_data.Skill.applyEffect(entity);
				}
			}
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.MaxRange + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});

