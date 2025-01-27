this.legend_alp_realm_of_shadow_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendAlpRealmOfShadow);
		this.m.Description = "";
		this.m.Icon = "skills/nightvision_square.png";
		this.m.IconDisabled = "skills/nightvision_square.png";
		this.m.Overlay = "bust_nightmare";
		this.m.SoundOnUse = [
			"sounds/enemies/miasma_spell_01.wav",
			"sounds/enemies/miasma_spell_02.wav",
			"sounds/enemies/miasma_spell_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 4;
	}

	function isViableTarget( _user, _target )
	{
		return _target.getTile().Properties.Effect == null;
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [];
		ret.push(_targetTile);

		for( local i = 0; i != 6; ++i )
		{
			if (_targetTile.hasNextTile(i))
				ret.push(_targetTile.getNextTile(i));
		}

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local func = this.onApplyShadowMistEffect;
		local p = {
			Type = "shadows",
			Tooltip = "A pitch black mist lingers here, eminating a bone chilling air from within",
			IsPositive = true,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = true,
			IsByPlayer = false,
			Timeout = this.Time.getRound() + 3,
			Callback = func,
			function Applicable( _a )
			{
				return _a.getFlags().has("alp") || _a.getMoraleState != this.Const.MoraleState.Ignore;
			}
		};

		foreach( tile in this.getAffectedTiles(_targetTile) )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "shadows")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				continue;
			}

			if (tile.Properties.Effect != null)
				this.Tactical.Entities.removeTileEffect(tile);

			tile.Properties.Effect = clone p;
			local particles = [];

			for( local i = 0; i < this.Const.Tactical.ShadowParticles.len(); ++i )
			{
				particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.ShadowParticles[i].Brushes, tile, this.Const.Tactical.ShadowParticles[i].Delay, this.Const.Tactical.ShadowParticles[i].Quantity, this.Const.Tactical.ShadowParticles[i].LifeTimeQuantity, this.Const.Tactical.ShadowParticles[i].SpawnRate, this.Const.Tactical.ShadowParticles[i].Stages));
			}

			this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);

			if (!tile.IsOccupiedByActor)
				continue;

			this.onApplyShadowMistEffect(tile, tile.getEntity());
		}

		return true;
	}

	function onApplyShadowMistEffect( _tile, _entity )
	{
		if (!_entity.getFlags().has("alp") && _entity.getMoraleState == this.Const.MoraleState.Ignore)
			return;

		if (_entity.getSkills().hasEffect(::Legends.Effect.LegendAlpRealmOfShadow))
			return;

		this.Sound.play(::MSU.Array.rand([
			"sounds/enemies/dlc2/alp_nightmare_01.wav",
			"sounds/enemies/dlc2/alp_nightmare_02.wav",
			"sounds/enemies/dlc2/alp_nightmare_03.wav",
			"sounds/enemies/dlc2/alp_nightmare_04.wav",
			"sounds/enemies/dlc2/alp_nightmare_05.wav",
			"sounds/enemies/dlc2/alp_nightmare_06.wav"
		]), this.Const.Sound.Volume.Actor, _entity.getPos());

		::Legends.Effects.grant(_entity, ::Legends.Effect.LegendAlpRealmOfShadow);
	}

});

