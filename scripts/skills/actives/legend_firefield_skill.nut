this.legend_firefield_skill <- this.inherit("scripts/skills/skill", {
	m = {
		LastForTurns = 3
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFirefield);
		this.m.Description = "Unleash a raging inferno at the target location that burns all beings, damaging them twice.";
		this.m.Icon = "skills/fire_square.png";
		this.m.IconDisabled = "skills/fire_square_bw.png";
		this.m.Overlay = "fire_circle";
		this.m.SoundOnUse = [
			"sounds/combat/fire_01.wav",
			"sounds/combat/fire_02.wav",
			"sounds/combat/fire_03.wav",
			"sounds/combat/fire_04.wav",
			"sounds/combat/fire_05.wav",
			"sounds/combat/fire_06.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/humans/0/human_light_01.wav",
			"sounds/humans/0/human_light_02.wav",
			"sounds/humans/0/human_light_03.wav",
			"sounds/humans/0/human_light_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted +10;
		this.m.Delay = 0;
		this.m.IsTargetingActor = false;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 50;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 6;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles on even ground"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts an additional [color=%damage%]15[/color] - [color=%damage%]30[/color] damage per turn for three turns across six tiles. Burns allies. Requires a staff"
			}
		]);
		return ret;
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

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;
	}

	function isUsable()
	{
		if (!this.getContainer().getActor().isArmedWithMagicStaff())
			return false;

		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile )
	{
		local targets = [];
		targets.push(_targetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
				continue
			}
			local tile = _targetTile.getNextTile(i);
			targets.push(tile);
		}

		local p = {
			Type = "fire",
			Tooltip = "Fire rages here, melting armor and flesh alike",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _user.isPlayerControlled(),
			Timeout = this.Time.getRound() + m.LastForTurns,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}
		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "legend_firefield")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + m.LastForTurns;
			}
			else
			{
				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
			}

			if (!tile.IsOccupiedByActor)
				continue;

			local entity = tile.getEntity();

			for (local i = 0; i < 2; ++i)
			{
				if (entity.isAlive() && !entity.isDying())
					this.Const.Tactical.Common.onApplyFire(tile, entity);
			}
		}

		return true;
	}

});
