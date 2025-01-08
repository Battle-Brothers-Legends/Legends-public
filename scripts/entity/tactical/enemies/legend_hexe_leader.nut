this.legend_hexe_leader <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		IsCharming = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendHexeLeader;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendHexeLeader.XP;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.DecapitateSplatterOffset = this.createVec(-8, -26);
		this.m.IsUsingZoneOfControl = false;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc2/hexe_hurt_01.wav",
			"sounds/enemies/dlc2/hexe_hurt_02.wav",
			"sounds/enemies/dlc2/hexe_hurt_03.wav",
			"sounds/enemies/dlc2/hexe_hurt_04.wav",
			"sounds/enemies/dlc2/hexe_hurt_05.wav",
			"sounds/enemies/dlc2/hexe_hurt_06.wav",
			"sounds/enemies/dlc2/hexe_hurt_07.wav",
			"sounds/enemies/dlc2/hexe_hurt_08.wav",
			"sounds/enemies/dlc2/hexe_hurt_09.wav",
			"sounds/enemies/dlc2/hexe_hurt_10.wav",
			"sounds/enemies/dlc2/hexe_hurt_11.wav",
			"sounds/enemies/dlc2/hexe_hurt_12.wav",
			"sounds/enemies/dlc2/hexe_hurt_13.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc2/hexe_death_01.wav",
			"sounds/enemies/dlc2/hexe_death_02.wav",
			"sounds/enemies/dlc2/hexe_death_03.wav",
			"sounds/enemies/dlc2/hexe_death_04.wav",
			"sounds/enemies/dlc2/hexe_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc2/hexe_idle_01.wav",
			"sounds/enemies/dlc2/hexe_idle_02.wav",
			"sounds/enemies/dlc2/hexe_idle_03.wav",
			"sounds/enemies/dlc2/hexe_idle_04.wav",
			"sounds/enemies/dlc2/hexe_idle_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/dlc2/hexe_idle_06.wav",
			"sounds/enemies/dlc2/hexe_idle_07.wav",
			"sounds/enemies/dlc2/hexe_idle_08.wav",
			"sounds/enemies/dlc2/hexe_idle_09.wav",
			"sounds/enemies/dlc2/hexe_idle_05.wav",
			"sounds/enemies/dlc2/hexe_idle_10.wav",
			"sounds/enemies/dlc2/hexe_idle_11.wav",
			"sounds/enemies/dlc2/hexe_idle_12.wav",
			"sounds/enemies/dlc2/hexe_idle_13.wav",
			"sounds/enemies/dlc2/hexe_idle_14.wav",
			"sounds/enemies/dlc2/hexe_idle_15.wav",
			"sounds/enemies/dlc2/hexe_idle_16.wav",
			"sounds/enemies/dlc2/hexe_idle_17.wav",
			"sounds/enemies/dlc2/hexe_idle_18.wav",
			"sounds/enemies/dlc2/hexe_idle_19.wav",
			"sounds/enemies/dlc2/hexe_idle_20.wav",
			"sounds/enemies/dlc2/hexe_idle_21.wav",
			"sounds/enemies/dlc2/hexe_idle_22.wav",
			"sounds/enemies/dlc2/hexe_idle_23.wav",
			"sounds/enemies/dlc2/hexe_idle_24.wav",
			"sounds/enemies/dlc2/hexe_idle_25.wav",
			"sounds/enemies/dlc2/hexe_idle_26.wav",
			"sounds/enemies/dlc2/hexe_idle_27.wav",
			"sounds/enemies/dlc2/hexe_idle_28.wav",
			"sounds/enemies/dlc2/hexe_idle_29.wav",
			"sounds/enemies/dlc2/hexe_idle_30.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/dlc2/hexe_flee_01.wav",
			"sounds/enemies/dlc2/hexe_flee_02.wav",
			"sounds/enemies/dlc2/hexe_flee_03.wav",
			"sounds/enemies/dlc2/hexe_flee_04.wav",
			"sounds/enemies/dlc2/hexe_flee_05.wav",
			"sounds/enemies/dlc2/hexe_flee_06.wav",
			"sounds/enemies/dlc2/hexe_flee_07.wav",
			"sounds/enemies/dlc2/hexe_flee_08.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 5.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] = 2.5;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/hexe_agent");
		this.m.AIAgent.setActor(this);
	}

	function playIdleSound()
	{
		local r = this.Math.rand(1, 30);

		if (r <= 5)
		{
			this.playSound(this.Const.Sound.ActorEvent.Idle, this.Const.Sound.Volume.Actor * this.Const.Sound.Volume.ActorIdle * this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] * this.m.SoundVolumeOverall * (this.Math.rand(60, 100) * 0.01) * (this.isHiddenToPlayer ? 0.33 : 1.0), this.m.SoundPitch * (this.Math.rand(85, 115) * 0.01));
		}
		else
		{
			this.playSound(this.Const.Sound.ActorEvent.Other1, this.Const.Sound.Volume.Actor * this.Const.Sound.Volume.ActorIdle * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] * this.m.SoundVolumeOverall * (this.Math.rand(60, 100) * 0.01) * (this.isHiddenToPlayer ? 0.33 : 1.0), this.m.SoundPitch * (this.Math.rand(85, 115) * 0.01));
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("BagAHag", 1, 1);
		}

		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local hair = this.getSprite("hair");
			body.Alpha = 255;
			head.Alpha = 255;
			hair.Alpha = 255;
			decal = _tile.spawnDetail(body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
				decal = _tile.spawnDetail(hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead",
					hair.getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 45.0, head.getBrush().Name + "_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;
				decap[1].Scale = 0.95;
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A Hexe";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					local r = this.Math.rand(1, 100);
					local loot;

					if (r <= 50)
					{
						loot = this.new("scripts/items/misc/legend_witch_leader_hair_item");
					}
					else if (r <= 70)
					{
						loot = this.new("scripts/items/misc/mysterious_herbs_item");
					}
					else
					{
						loot = this.new("scripts/items/misc/poisoned_apple_item");
					}

					loot.drop(_tile);

					if (this.Math.rand(1, 100) <= 50)
					{
						local food = this.new("scripts/items/supplies/black_marsh_stew_item");
						food.randomizeAmount();
						food.randomizeBestBefore();
						food.drop(_tile);
					}
				}

				if (this.Math.rand(1, 100) <= 20)
				{
					local rune;
					local selected = this.Math.rand(11,13);
					switch(selected)
					{
						case 11:
							rune = this.new("scripts/items/legend_helmets/runes/legend_rune_clarity");
							break;

						case 12:
							rune = this.new("scripts/items/legend_helmets/runes/legend_rune_bravery");
							break;

						case 13:
							rune = this.new("scripts/items/legend_helmets/runes/legend_rune_luck");
							break;
					}
					rune.setRuneVariant(selected);
					rune.setRuneBonus(true);
					rune.drop(_tile);
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);
		this.getSprite("charm_body").setHorizontalFlipping(flip);
		this.getSprite("charm_armor").setHorizontalFlipping(flip);
		this.getSprite("charm_head").setHorizontalFlipping(flip);
		this.getSprite("charm_hair").setHorizontalFlipping(flip);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Hexe);
		b.TargetAttractionMult = 3.0;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_hexenleader_body_01");
		body.varySaturation(0.1);
		body.varyColor(0.05, 0.05, 0.05);
		local charm_body = this.addSprite("charm_body");
		charm_body.setBrush("bust_hexen_charmed_body_01");
		charm_body.Visible = false;
		local charm_armor = this.addSprite("charm_armor");
		charm_armor.setBrush("bust_hexen_charmed_dress_0" + this.Math.rand(1, 3));
		charm_armor.Visible = false;
		local head = this.addSprite("head");
		head.setBrush("bust_hexenleader_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local charm_head = this.addSprite("charm_head");
		charm_head.setBrush("bust_hexen_charmed_head_0" + this.Math.rand(1, 2));
		charm_head.Visible = false;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_hexen_01_injured");
		local hair = this.addSprite("hair");
		hair.setBrush("bust_hexen_hair_0" + this.Math.rand(1, 4));
		local charm_hair = this.addSprite("charm_hair");
		charm_hair.setBrush("bust_hexen_charmed_hair_0" + this.Math.rand(1, 5));
		charm_hair.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;

		this.m.Skills.add(this.new("scripts/skills/actives/legend_intensely_charm_skill"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
		this.m.Skills.add(this.new("scripts/skills/actives/hex_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_wither_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/sleep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_magic_missile_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_teleport_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/fake_drink_night_vision_skill"));


		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/racial/schrat_racial"));
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.InspiringPresence);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLevitate);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.HoldOut);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		if (!this.Tactical.State.isScenarioMode())
		{
			local dateToSkip = 0;
			switch (this.World.Assets.getCombatDifficulty())
			{
				case this.Const.Difficulty.Easy:
					dateToSkip = 250;
					break;
				case this.Const.Difficulty.Normal:
					dateToSkip = 200
					break;
				case this.Const.Difficulty.Hard:
					dateToSkip = 150
					break;
				case this.Const.Difficulty.Legendary:
					dateToSkip = 100
					break;
			}

			if (this.World.getTime().Days >= dateToSkip)
			{
				local bonus = this.Math.min(1, this.Math.floor( (this.World.getTime().Days - dateToSkip) / 20.0));
				b.MeleeSkill += this.Math.floor(bonus / 2);
				b.RangedSkill += bonus;
				b.MeleeDefense += this.Math.floor(bonus / 2);
				b.RangedDefense += this.Math.floor(bonus / 2);
				b.Hitpoints += this.Math.floor(bonus * 2);
				b.Initiative += bonus;
				b.Stamina += bonus;
			//	b.XP += this.Math.floor(bonus * 4);
				b.Bravery += bonus;
				b.FatigueRecoveryRate += this.Math.floor(bonus / 4);
			}
		}
	}

	function onUpdateInjuryLayer()
	{
		if (!this.hasSprite("injury"))
		{
			return;
		}

		if (this.m.IsCharming)
		{
			return;
		}

		local injury = this.getSprite("injury");
		local p = this.getHitpointsPct();

		if (p > 0.5)
		{
			if (injury.Visible)
			{
				injury.Visible = false;
				this.setDirty(true);
			}
		}
		else if (!injury.Visible)
		{
			injury.Visible = true;
			this.setDirty(true);
		}
	}

	function assignRandomEquipment()
	{
		 this.m.Items.equip(this.new("scripts/items/weapons/legend_staff_gnarled"));
	}

	function setCharming( _f )
	{
		if (_f == this.m.IsCharming)
		{
			return;
		}

		this.m.IsCharming = _f;
		local t = 300;

		if (this.m.IsCharming)
		{
			local sprite;
			sprite = this.getSprite("charm_body");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("charm_armor");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("charm_head");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("charm_hair");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("body");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("head");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("hair");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("injury");
			sprite.fadeOutAndHide(t);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, t + 100, function ( _e )
			{
				if (!_e.isAlive())
				{
					return;
				}

				local sprite;
				sprite = _e.getSprite("body");
				sprite.Visible = false;
				sprite = _e.getSprite("head");
				sprite.Visible = false;
				sprite = _e.getSprite("hair");
				sprite.Visible = false;
				sprite = _e.getSprite("injury");
				sprite.Visible = false;
				_e.setDirty(true);
			}, this);
		}
		else
		{
			local sprite;
			sprite = this.getSprite("charm_body");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("charm_armor");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("charm_head");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("charm_hair");
			sprite.fadeOutAndHide(t);
			sprite = this.getSprite("body");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("head");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("hair");
			sprite.Visible = true;
			sprite.fadeIn(t);
			sprite = this.getSprite("injury");
			sprite.fadeIn(t);
			this.onUpdateInjuryLayer();
			this.Time.scheduleEvent(this.TimeUnit.Virtual, t + 100, function ( _e )
			{
				if (!_e.isAlive())
				{
					return;
				}

				local sprite;
				sprite = _e.getSprite("charm_body");
				sprite.Visible = false;
				sprite = _e.getSprite("charm_armor");
				sprite.Visible = false;
				sprite = _e.getSprite("charm_head");
				sprite.Visible = false;
				sprite = _e.getSprite("charm_hair");
				sprite.Visible = false;
				_e.setDirty(true);
			}, this);
		}

		local effect = {
			Delay = 0,
			Quantity = 50,
			LifeTimeQuantity = 50,
			SpawnRate = 1000,
			Brushes = [
				"effect_heart_01"
			],
			Stages = [
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("fff3e50f"),
					ColorMax = this.createColor("ffffff5f"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.5, 0.0),
					DirectionMax = this.createVec(0.5, 1.0),
					SpawnOffsetMin = this.createVec(-30, -70),
					SpawnOffsetMax = this.createVec(30, 30),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("fff3e500"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.1,
					ScaleMax = 0.1,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.5, 0.0),
					DirectionMax = this.createVec(0.5, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, this.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
	}

});

