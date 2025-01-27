this.legend_demon_alp <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendDemonAlp;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.XP = this.Const.Tactical.Actor.LegendDemonAlp.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.IsUsingZoneOfControl = false;
		this.m.IsFlashingOnHit = false;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc2/alp_idle_01.wav",
			"sounds/enemies/dlc2/alp_idle_02.wav",
			"sounds/enemies/dlc2/alp_idle_03.wav",
			"sounds/enemies/dlc2/alp_idle_04.wav",
			"sounds/enemies/dlc2/alp_idle_05.wav",
			"sounds/enemies/dlc2/alp_idle_06.wav",
			"sounds/enemies/dlc2/alp_idle_07.wav",
			"sounds/enemies/dlc2/alp_idle_08.wav",
			"sounds/enemies/dlc2/alp_idle_09.wav",
			"sounds/enemies/dlc2/alp_idle_10.wav",
			"sounds/enemies/dlc2/alp_idle_11.wav",
			"sounds/enemies/dlc2/alp_idle_12.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/dlc2/alp_idle_13.wav",
			"sounds/enemies/dlc2/alp_idle_14.wav",
			"sounds/enemies/dlc2/alp_idle_15.wav",
			"sounds/enemies/dlc2/alp_idle_16.wav",
			"sounds/enemies/dlc2/alp_idle_17.wav",
			"sounds/enemies/dlc2/alp_idle_18.wav",
			"sounds/enemies/dlc2/alp_idle_19.wav",
			"sounds/enemies/dlc2/alp_idle_20.wav",
			"sounds/enemies/dlc2/alp_idle_21.wav",
			"sounds/enemies/dlc2/alp_idle_22.wav",
			"sounds/enemies/dlc2/alp_idle_23.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc2/alp_death_01.wav",
			"sounds/enemies/dlc2/alp_death_02.wav",
			"sounds/enemies/dlc2/alp_death_03.wav",
			"sounds/enemies/dlc2/alp_death_04.wav",
			"sounds/enemies/dlc2/alp_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc2/alp_hurt_01.wav",
			"sounds/enemies/dlc2/alp_hurt_02.wav",
			"sounds/enemies/dlc2/alp_hurt_03.wav",
			"sounds/enemies/dlc2/alp_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/dlc2/alp_flee_01.wav",
			"sounds/enemies/dlc2/alp_flee_02.wav",
			"sounds/enemies/dlc2/alp_flee_03.wav",
			"sounds/enemies/dlc2/alp_flee_04.wav",
			"sounds/enemies/dlc2/alp_flee_05.wav"
		];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 2.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] = 1.0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_demonalp_agent");
		this.m.AIAgent.setActor(this);
		this.m.Flags.add("demon");
		this.m.Flags.add("alp");
	}

	function playIdleSound()
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.playSound(this.Const.Sound.ActorEvent.Other1, this.Const.Sound.Volume.Actor * this.Const.Sound.Volume.ActorIdle * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] * this.m.SoundVolumeOverall * (this.Math.rand(50, 90) * 0.01) * (this.isHiddenToPlayer ? 0.5 : 1.0), this.m.SoundPitch * (this.Math.rand(50, 100) * 0.01));
		}
		else
		{
			this.playSound(this.Const.Sound.ActorEvent.Idle, this.Const.Sound.Volume.Actor * this.Const.Sound.Volume.ActorIdle * this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] * this.m.SoundVolumeOverall * (this.Math.rand(50, 100) * 0.01) * (this.isHiddenToPlayer ? 0.5 : 1.0), this.m.SoundPitch * (this.Math.rand(60, 105) * 0.01));
		}
	}

	function loadResources()
	{
		this.actor.loadResources();

		foreach( r in [
			"sounds/enemies/dlc2/alp_nightmare_01.wav",
			"sounds/enemies/dlc2/alp_nightmare_02.wav",
			"sounds/enemies/dlc2/alp_nightmare_03.wav",
			"sounds/enemies/dlc2/alp_nightmare_04.wav",
			"sounds/enemies/dlc2/alp_nightmare_05.wav",
			"sounds/enemies/dlc2/alp_nightmare_06.wav"
		])
		{
			this.Tactical.addResource(r);
		}

		foreach( r in [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		])
		{
			this.Tactical.addResource(r);
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("SleepTight", 1, 1);
		}

		this.m.IsCorpseFlipped = this.Math.rand(0, 100) > 50;
		local isResurrectable = _fatalityType != this.Const.FatalityType.Decapitated;
		local skin = this.getSprite("body");
		local sprite_head = this.getSprite("head");

		if (_tile != null)
		{
			skin.Alpha = 255;
			local decal = _tile.spawnDetail("bust_demonalp_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), [sprite_head.getBrush().Name + "_dead"], this.createVec(-45, 30), 180.0, sprite_head.getBrush().Name + "_bloodpool");

				foreach( sprite in decap )
				{
					sprite.Color = skin.Color;
					sprite.Saturation = skin.Saturation;
					sprite.Scale = 0.9;
					sprite.setBrightness(0.9);
				}
			}
			else
			{
				decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped);
				decal.Color = skin.Color;
				decal.Saturation = skin.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_demonalp_guts", this.Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}
			else if (_fatalityType == this.Const.FatalityType.Smashed)
			{
				decal = _tile.spawnDetail("bust_alp_skull", this.Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_demonalp_body_01_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_demonalp_body_01_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An " + this.getName();
			corpse.Tile = _tile;
			corpse.Value = 2.0;
			corpse.IsResurrectable = false;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
				this.onDropLootForPlayer(_tile);
		}

		this.onKillAllSummonedMinions();
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onKillAllSummonedMinions()
	{
		local id = this.getID();

		foreach( a in this.Tactical.Entities.getAllInstancesAsArray() )
		{
			if (!a.getFlags().has("living_nightmare"))
				continue;

			if (a.getFlags().get("living_nightmare") != id)
				continue;

			a.killSilently();
		}
	}

	function onDropLootForPlayer( _tile )
	{
		local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

		for( local i = 0; i < n; ++i )
		{
			if (this.Math.rand(1, 100) <= 33)
				this.new("scripts/items/misc/legend_demon_alp_skin_item").drop(_tile);

			this.new("scripts/items/misc/" + (this.Math.rand(1, 100) <= 50 ? "legend_demon_third_eye_item" : "legend_demon_alp_skin_item")).drop(_tile);
			this.new("scripts/items/misc/petrified_scream_item").drop(_tile);
		}

		local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
		token.setRuneVariant(::Math.rand(1, 6));
		token.setRuneBonus(true);
		token.updateRuneSigilToken();
		token.drop(_tile);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendDemonAlp);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRoot = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_demonalp_body_01");
		body.varySaturation(0.2);
		local head = this.addSprite("head");
		head.setBrush("demon_alp_head")
		//head.setBrush("bust_demonalp_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.setBrush("demon_alp_wounds");
		//injury.setBrush("bust_demonalp_01_injured");
		injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 10));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_super_sleep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_super_nightmare_skill"));
		::Legends.Actives.grant(this, ::Legends.Active.LegendAlpRealmOfShadow);
		::Legends.Actives.grant(this, ::Legends.Active.LegendAlpSummonNightmare);
		::Legends.Actives.grant(this, ::Legends.Active.LegendAlpNightmareManifestation);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialAlp);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);

		if (::Legends.isLegendaryDifficulty())
		{
			b.Hitpoints -= 100;
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

});

