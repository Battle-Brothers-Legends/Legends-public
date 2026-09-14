this.legend_goblin_rider_abstract <- this.inherit("scripts/entity/tactical/goblin", {
	m = {
		Variant = 1,
		LastBodyPartHit = this.Const.BodyPart.Body,
		Info = null,
		AssignAIAgent = "scripts/ai/tactical/agents/goblin_wolfrider_agent",
		AssignEntityType = this.Const.EntityType.GoblinWolfrider,
		AssignActor = this.Const.Tactical.Actor.GoblinWolfrider,
		WolfScript = "scripts/entity/tactical/enemies/wolf",
		GoblinScript = "scripts/entity/tactical/enemies/goblin_fighter"
	},
	function create()
	{
		this.m.Type = this.m.AssignEntityType;
		this.m.XP = this.m.AssignActor.XP;
		this.goblin.create();
		this.m.ShakeLayers = [
			[
				"wolf",
				"wolf_head",
				"wolf_injury"
			],
			[
				"body",
				"head",
				"injury",
				"helmet",
				"helmet_damage"
			]
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/werewolf_hurt_01.wav",
			"sounds/enemies/werewolf_hurt_02.wav",
			"sounds/enemies/werewolf_hurt_03.wav",
			"sounds/enemies/werewolf_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other2] = [
			"sounds/enemies/werewolf_death_01.wav",
			"sounds/enemies/werewolf_death_02.wav",
			"sounds/enemies/werewolf_death_03.wav",
			"sounds/enemies/werewolf_death_04.wav",
			"sounds/enemies/werewolf_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_04.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav",
			"sounds/enemies/werewolf_idle_09.wav",
			"sounds/enemies/werewolf_idle_10.wav",
			"sounds/enemies/werewolf_idle_11.wav",
			"sounds/enemies/werewolf_idle_12.wav",
			"sounds/enemies/werewolf_idle_13.wav",
			"sounds/enemies/werewolf_idle_14.wav",
			"sounds/enemies/werewolf_idle_15.wav",
			"sounds/enemies/werewolf_idle_16.wav",
			"sounds/enemies/werewolf_idle_17.wav",
			"sounds/enemies/werewolf_idle_18.wav",
			"sounds/enemies/werewolf_idle_19.wav",
			"sounds/enemies/werewolf_idle_20.wav",
			"sounds/enemies/werewolf_idle_21.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 0.6;
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/werewolf_fatigue_01.wav",
			"sounds/enemies/werewolf_fatigue_02.wav",
			"sounds/enemies/werewolf_fatigue_03.wav",
			"sounds/enemies/werewolf_fatigue_04.wav",
			"sounds/enemies/werewolf_fatigue_05.wav",
			"sounds/enemies/werewolf_fatigue_06.wav",
			"sounds/enemies/werewolf_fatigue_07.wav"
		];
		this.m.AIAgent = this.new(this.m.AssignAIAgent);
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.m.AssignActor);
		b.AdditionalActionPointCost = 1;
		b.DamageDirectMult = 1.25;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.createSprites();
		this.assignSkills();
		this.applySpriteOffset(0, -20);
	}

	function createSprites()
	{
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.setAlwaysApplySpriteOffset(true);
		local offset = this.createVec(8, 14);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("armor", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("helmet", offset);
		this.setSpriteOffset("helmet_damage", offset);
		this.setSpriteOffset("body_blood", offset);
		local variant = this.Math.rand(1, 2);
		local wolf = this.addSprite("wolf");
		wolf.setBrush("bust_wolf_0" + variant + "_body");
		wolf.varySaturation(0.15);
		wolf.varyColor(0.07, 0.07, 0.07);
		local wolf = this.addSprite("wolf_head");
		wolf.setBrush("bust_wolf_0" + variant + "_head");
		wolf.Saturation = wolf.Saturation;
		wolf.Color = wolf.Color;
		this.removeSprite("injury_body");
		local wolf_injury = this.addSprite("injury_body");
		wolf_injury.setBrush("bust_wolf_01_injured");
		wolf_injury.Visible = false;
		local wolf_armor = this.addSprite("wolf_armor");
		wolf_armor.setBrush("bust_wolf_02_armor_01");
	}

	function applySpriteOffset(_x, _y, _armsX=15, _armsY=15, _rotation=13.0)
	{
		local offset = this.createVec(_x, _y);
		this.setSpriteOffset("wolf", offset);
		this.setSpriteOffset("wolf_head", offset);
		this.setSpriteOffset("wolf_armor", offset);
		this.setSpriteOffset("injury_body", offset);
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(_armsX, _armsY));
		this.getSprite("arms_icon").Rotation = _rotation;
	}

	function assignSkills()
	{
		::Legends.Actives.grant(this, ::Legends.Active.WolfBite, function (_skill) {
			_skill.setRestrained(true);
			_skill.m.ActionPointCost = 0;
		}.bindenv(this));
		::Legends.Perks.remove(this, ::Legends.Perk.Backstabber); // remove vanilla backstabber
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function onAfterInit()
	{
		this.getSprite("status_rooted").Scale = 0.57;
		this.setSpriteOffset("status_rooted", this.createVec(-2, -3));
		this.actor.onAfterInit();
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		this.m.LastBodyPartHit = _hitInfo.BodyPart;
		this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.m.Info = {
			Tile = this.getTile(),
			Faction = this.getFaction(),
			Body = this.getSprite("body").getBrush().Name,
			Head = this.getSprite("head").getBrush().Name,
			Color = this.getSprite("body").Color,
			Saturation = this.getSprite("body").Saturation,
			WolfColor = this.getSprite("wolf").Color,
			WolfSaturation = this.getSprite("wolf").Saturation,
			Morale = this.Math.max(this.Const.MoraleState.Breaking, this.getMoraleState())
		};

		if (this.m.LastBodyPartHit == this.Const.BodyPart.Body)
		{
			this.spawnDeadWolf(_killer, _skill, _tile, _fatalityType);
		}
		else
		{
			this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
		}
	}

	function onAfterDeath( _tile )
	{
		if (this.Tactical.Entities.getHostilesNum() == 0)
		{
			return;
		}

		if (!this.m.Info.Tile.IsEmpty)
		{
			local changed = false;

			for( local i = 0; i != 6; i = ++i )
			{
				if (!this.m.Info.Tile.hasNextTile(i))
				{
				}
				else
				{
					local tile = this.m.Info.Tile.getNextTile(i);

					if (tile.IsEmpty && this.Math.abs(tile.Level - this.m.Info.Tile.Level) <= 1)
					{
						this.m.Info.Tile = tile;
						changed = true;
						break;
					}
				}
			}

			if (!changed)
			{
				return;
			}
		}

		if (this.m.LastBodyPartHit == this.Const.BodyPart.Body)
		{
			this.spawnGoblin(this.m.Info);
		}
		else
		{
			this.spawnWolf(this.m.Info);
		}
	}

	function spawnDeadWolf( _killer, _skill, _tile, _fatalityType )
	{
	}

	function spawnWolf( _info )
	{
		this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived].len() - 1)], this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1], _info.Tile.Pos, 1.0);
		local entity = this.Tactical.spawnEntity(this.m.WolfScript, _info.Tile.Coords.X, _info.Tile.Coords.Y);

		if (entity != null)
		{
			entity.setVariant(this.m.Variant, _info.WolfColor, _info.WolfSaturation, 0.45);
			entity.setFaction(_info.Faction);
			entity.setMoraleState(_info.Morale);
		}
	}

	function spawnGoblin( _info )
	{
		this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other1][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other1].len() - 1)], this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1], _info.Tile.Pos, 1.0);
		local entity = this.Tactical.spawnEntity(this.m.GoblinScript, _info.Tile.Coords.X, _info.Tile.Coords.Y);
		if (this.m.IsMiniboss)
		{
			entity.makeMiniboss();
		}
		if (entity != null)
		{
			local newBody = entity.getSprite("body");
			newBody.setBrush(_info.Body);
			newBody.Color = _info.Color;
			newBody.Saturation = _info.Saturation;
			local newHead = entity.getSprite("head");
			newHead.setBrush(_info.Head);
			newHead.Color = _info.Color;
			newHead.Saturation = _info.Saturation;
			entity.setFaction(_info.Faction);
			entity.getItems().clear();
			this.m.Items.transferTo(entity.getItems());
			entity.setMoraleState(_info.Morale);
			entity.setHitpoints(entity.getHitpointsMax() * 0.45);
			entity.onUpdateInjuryLayer();
		}
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.DamageReceived && this.m.LastBodyPartHit == this.Const.BodyPart.Body)
		{
			_type = this.Const.Sound.ActorEvent.Other1;
		}
		else if (_type == this.Const.Sound.ActorEvent.Death && this.m.LastBodyPartHit == this.Const.BodyPart.Body)
		{
			_type = this.Const.Sound.ActorEvent.Other2;
			this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.7;
		}

		this.actor.playSound(_type, _volume, _pitch);
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 1.0;
	}

	function assignRandomEquipment()
	{
	}

});

