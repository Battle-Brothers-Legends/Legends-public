this.legend_demon_hound <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = this.createVec(0, 0),
		DistortAnimationStartTimeC = 0
	},

	function create()
	{
		this.m.Type = this.Const.EntityType.LegendDemonHound;
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.LegendDemonHound.XP;
		this.m.IsEmittingMovementSounds = true;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/hollen_hurt_01.wav",
			"sounds/enemies/hollen_hurt_02.wav",
			"sounds/enemies/hollen_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/hollen_death_01.wav",
			"sounds/enemies/hollen_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/hollen_idle_01.wav",
			"sounds/enemies/hollen_idle_02.wav",
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/hollen_charge_01.wav",
			"sounds/enemies/hollen_charge_02.wav",
			"sounds/enemies/hollen_charge_03.wav",
			"sounds/enemies/hollen_charge_04.wav",
			"sounds/enemies/hollen_charge_05.wav"
		];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.getFlags().add("undead");
		this.getFlags().add("skeleton");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/wardog_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		this.actor.onDamageReceived(_attacker, _skill, _hitInfo);

		if (this.isDying())
		{
			return;
		}


		// This actually doesn't really work I didn't realize when making this: If it body shots first before headshot it'll just teleport anyways, leaving here as a ujst in case eventually

		// local BodyOrHeadShot = _hitInfo.BodyPart;
		// local SkillID = _skill.getID();
		// //Don't teleport if it was a headshot from split man attack, because we have to wait for body shot to teleport, otherwise it doesn't matter.
		// if (SkillID == "actives.split_man" && BodyOrHeadShot == this.Const.BodyPart.Head) {
		// 	return;
		// }

		local result = {
			TargetTile = this.getTile(),
			Destinations = []
		};
		this.Tactical.queryTilesInRange(this.getTile(), 2, 6, false, [], this.onQueryTiles, result);

		if (result.Destinations.len() == 0)
		{
			return;
		};

		local targetTile = result.Destinations[this.Math.rand(0, result.Destinations.len() - 1)]
		local tag = {
			User = this,
			TargetTile = targetTile,
			OnDone = this.onTeleportDone,
			OnFadeIn = this.onFadeIn,
			OnFadeDone = this.onFadeDone,
			OnTeleportStart = this.onTeleportStart,
			IgnoreColors = false
		};

		if (this.getTile().IsVisibleForPlayer)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.7,
						LifeTimeMax = 0.7,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.7,
						LifeTimeMax = 0.7,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, this.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
			this.storeSpriteColors();
			this.fadeTo(this.createColor("ffffff00"), 0);
			this.onTeleportStart(tag);
		}
		else if (targetTile.IsVisibleForPlayer)
		{
			this.storeSpriteColors();
			this.fadeTo(this.createColor("ffffff00"), 0);
			this.onTeleportStart(tag);
		}
		else
		{
			tag.IgnoreColors = true;
			this.onTeleportStart(tag);
		}
	}

	function onQueryTiles( _tile, _tag )
	{
		if (!_tile.IsEmpty)
		{
			return;
		}

		_tag.Destinations.push(_tile);
	}

	function onTeleportStart( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 0.0);
	}

	function onTeleportDone( _entity, _tag )
	{
		if (!_entity.isHiddenToPlayer())
		{
			local effect1 = {
				Delay = 0,
				Quantity = 4,
				LifeTimeQuantity = 4,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.0, -1.0),
						DirectionMax = this.createVec(0.0, -1.0),
						SpawnOffsetMin = this.createVec(-10, 40),
						SpawnOffsetMax = this.createVec(10, 50),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.0, -1.0),
						DirectionMax = this.createVec(0.0, -1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.0, -1.0),
						DirectionMax = this.createVec(0.0, -1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			local effect2 = {
				Delay = 0,
				Quantity = 4,
				LifeTimeQuantity = 4,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(1.0, 0.0),
						DirectionMax = this.createVec(1.0, 0.0),
						SpawnOffsetMin = this.createVec(-40, -10),
						SpawnOffsetMax = this.createVec(-50, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(1.0, 0.0),
						DirectionMax = this.createVec(1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(1.0, 0.0),
						DirectionMax = this.createVec(1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			local effect3 = {
				Delay = 0,
				Quantity = 4,
				LifeTimeQuantity = 4,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, 0.0),
						DirectionMax = this.createVec(-1.0, 0.0),
						SpawnOffsetMin = this.createVec(40, 10),
						SpawnOffsetMax = this.createVec(50, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.4,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, 0.0),
						DirectionMax = this.createVec(-1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, 0.0),
						DirectionMax = this.createVec(-1.0, 0.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect1.Brushes, _entity.getTile(), effect1.Delay, effect1.Quantity, effect1.LifeTimeQuantity, effect1.SpawnRate, effect1.Stages, this.createVec(0, 40));
			this.Tactical.spawnParticleEffect(false, effect2.Brushes, _entity.getTile(), effect2.Delay, effect2.Quantity, effect2.LifeTimeQuantity, effect2.SpawnRate, effect2.Stages, this.createVec(0, 40));
			this.Tactical.spawnParticleEffect(false, effect3.Brushes, _entity.getTile(), effect3.Delay, effect3.Quantity, effect3.LifeTimeQuantity, effect3.SpawnRate, effect3.Stages, this.createVec(0, 40));
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, _tag.OnFadeIn, _tag);
		}
		else
		{
			_tag.OnFadeIn(_tag);
		}
	}

	function onFadeIn( _tag )
	{
		if (!_tag.IgnoreColors)
		{
			if (_tag.User.isHiddenToPlayer())
			{
				_tag.User.restoreSpriteColors();
			}
			else
			{
				_tag.User.fadeToStoredColors(300);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, _tag.OnFadeDone, _tag);
			}
		}
	}

	function onFadeDone( _tag )
	{
		_tag.User.restoreSpriteColors();
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("OvercomingFear", 1, 1);
		}

		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;

		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_demon_hound_essence"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));

			local decal = _tile.spawnDetail("bust_demon_hound_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = false;
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					local r = this.Math.rand(1, 100);
					local loot;

					if (r <= 50)
					{
						loot = this.new("scripts/items/misc/legend_demon_hound_bones_item");
					}
					else
					{
						continue;
					}

					loot.drop(_tile);
				}
			}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	// function setBrushes(_body, _spirit)
	// {
	// 	local body = "bust_demon_hound_0" + _body
	// 	local spirit = "bust_demon_hound_spirit_0" + _spirit
	// 	this.m.Items.getAppearance().Body = body;
	// 	this.getSprite("body").setBrush(body);
	// 	this.getSprite("head").setBrush(spirit);
	// 	this.getSprite("blur_1").setBrush(spirit);
	// 	this.getSprite("blur_2").setBrush(spirit);
	// 	if (_body == 2)
	// 	{
	// 		this.getSprite("injury_body").Visible = true;
	// 	}

	// }

	function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendDemonHound);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsAffectedByRain = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		local _body = this.Math.rand(1,3)
		local _spirit = this.Math.rand(1,3)
		this.m.Items.getAppearance().Body = "bust_demon_hound_0" + _body;
		this.addSprite("socket").setBrush("bust_base_undead");
		//this.addSprite("fog").setBrush("bust_ghost_fog_02");

		local body = this.addSprite("body");
		body.setBrush("bust_demon_hound_0" + _body);
		// body.Saturation = 1.0;
		// body.setBrightness(0.7);
		// body.varySaturation(0.25);
		// body.varyColor(0.2, 0.2, 0.2);

		this.addSprite("injury")
		local injury = this.addSprite("injury_body");
		injury.Visible = false;
		injury.setBrush("bust_demon_hound_injury");

		local head = this.addSprite("head");
		head.setBrush("bust_demon_hound_spirit_0" + _spirit);
		//head.setBrightness(1.0)
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		//blur_1.setBrightness(1.0)
		blur_1.setBrush("bust_demon_hound_spirit_0" + _spirit);
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		//blur_2.setBrightness(1.0)
		blur_2.setBrush("bust_demon_hound_spirit_0" + _spirit);
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_demon_hound_bite_skill"));
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		 if (::Legends.isLegendaryDifficulty())
		 {
		 	::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		 }

	}

	function onRender()
	{
		this.actor.onRender();

		if (this.m.DistortTargetA == null)
		{
			this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA))
		{
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetB == null)
		{
			this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.9000001, this.m.DistortAnimationStartTimeB))
		{
			this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetC == null)
		{
			this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.3, this.m.DistortAnimationStartTimeC))
		{
			this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevC = this.m.DistortTargetC;
			this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}
	}

});

