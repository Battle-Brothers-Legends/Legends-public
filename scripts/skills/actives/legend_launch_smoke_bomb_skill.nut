this.legend_launch_smoke_bomb_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
		},
	function create()
	{
		this.m.ID = "actives.legend_launch_smoke_bomb";
		this.m.Name = "Launch Smoke Bomb";
		this.m.Description = "Ignite and launch, using your slingstaff, a pot filled with substances that upon impact will quickly create a dense cloud.";
		this.m.Icon = "skills/active_208.png";
		this.m.IconDisabled = "skills/active_208_sw.png";
		this.m.Overlay = "active_208";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/sling_use_01.wav",
			"sounds/combat/dlc4/sling_use_02.wav",
			"sounds/combat/dlc4/sling_use_03.wav",
			"sounds/combat/dlc4/sling_use_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc6/smoke_bomb_01.wav",
			"sounds/combat/dlc6/smoke_bomb_02.wav",
			"sounds/combat/dlc6/smoke_bomb_03.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 750;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = false;
		this.m.IsWeaponSkill = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 4;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 7;
		this.m.ProjectileType = this.Const.ProjectileType.Bomb2;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Covers [color=" + this.Const.UI.Color.DamageValue + "]7[/color] tiles in smoke for one round, allowing anyone inside to move freely and ignore zones of control"
		},
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases Ranged Defense by [color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color], but lowers Ranged Skill by [color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] for anyone inside"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Extinguishes existing tile effects like Fire or Miasma"
		}]);

		local ammo = 0;
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.smoke_bomb")
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
		if (!this.getContainer().hasSkill("perk.legend_slinger_spins"))
			return true;
		if (this.m.Item != null && !this.m.Item.isNull())
			if (this.m.Item.getAmmo() != 0)
				return false;

		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.smoke_bomb")
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

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = [];
		affectedTiles.push(_targetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				affectedTiles.push(tile);
			}
		}

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function onUse( _user, _targetTile )
	{
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.consumeAmmo();

		this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onApply.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
	}

	function onApply( _data )
	{
		local targets = [];
		targets.push(_data.TargetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _data.TargetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
		local p = {
			Type = "smoke",
			Tooltip = "Dense smoke covers the area, allowing anyone inside to move freely and ignore zones of control, and granting protection from ranged attacks",
			IsPositive = true,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = true,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 1,
			Callback = this.Const.Tactical.Common.onApplySmoke,
			function Applicable( _a )
			{
				return true;
			}

		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "smoke")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 1;
			}
			else
			{
				if (tile.Properties.Effect != null)
				{
					this.Tactical.Entities.removeTileEffect(tile);
				}

				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.SmokeParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.SmokeParticles[i].Brushes, tile, this.Const.Tactical.SmokeParticles[i].Delay, this.Const.Tactical.SmokeParticles[i].Quantity, this.Const.Tactical.SmokeParticles[i].LifeTimeQuantity, this.Const.Tactical.SmokeParticles[i].SpawnRate, this.Const.Tactical.SmokeParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);

				if (tile.IsOccupiedByActor)
				{
					this.Const.Tactical.Common.onApplySmoke(tile, tile.getEntity());
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
