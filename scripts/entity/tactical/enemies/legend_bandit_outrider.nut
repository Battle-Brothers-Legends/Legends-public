this.legend_bandit_outrider <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Variant = 1,
		LastBodyPartHit = this.Const.BodyPart.Body,
		Info = null
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditOutrider;
		this.m.XP = this.Const.Tactical.Actor.BanditOutrider.XP;
		this.human.create();
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
			"sounds/misc/donkey_hurt_01.wav",
			"sounds/misc/donkey_hurt_02.wav",
			"sounds/misc/donkey_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other2] = [
			"sounds/misc/donkey_death_01.wav",
			"sounds/misc/donkey_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/misc/donkey_idle_01.wav",
			"sounds/misc/donkey_idle_02.wav",
			"sounds/misc/donkey_idle_03.wav",
			"sounds/misc/donkey_idle_04.wav",
			"sounds/misc/donkey_idle_05.wav",
			"sounds/misc/donkey_idle_06.wav",
			"sounds/misc/donkey_idle_07.wav",
			"sounds/misc/donkey_idle_08.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 0.6;
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/werewolf_fatigue_01.wav"
		];
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_outrider_agent"); //todo: change the ai agent
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditOutrider);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;

		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		this.getSprite("head").setBrush(this.Const.Faces.AllHuman[this.Math.rand(0, this.Const.Faces.AllHuman.len() - 1)]);
		this.getSprite("head").setHorizontalFlipping(true);
		this.getSprite("helmet").setHorizontalFlipping(true);


		local playerOffset = this.createVec(7, 12);
		this.setAlwaysApplySpriteOffset(true);
		this.setSpriteOffset("body", playerOffset);
		this.setSpriteOffset("armor", playerOffset);
		this.setSpriteOffset("head", playerOffset);
		this.setSpriteOffset("injury", playerOffset);
		this.setSpriteOffset("helmet", playerOffset);
		this.setSpriteOffset("helmet_damage", playerOffset);
		this.setSpriteOffset("body_blood", playerOffset);

		local variant = this.Math.rand(0, 7);
		this.m.Variant = variant;
		local wolf = this.addSprite("wolf");
		wolf.setBrush("bust_naked_body_10" + variant);
		wolf.varySaturation(0.15);
		wolf.setHorizontalFlipping(true);
		local wolf = this.addSprite("wolf_head");
		wolf.setBrush("bust_head_10" + variant);
		wolf.Saturation = wolf.Saturation;
		wolf.Color = wolf.Color;
		wolf.setHorizontalFlipping(true);
		this.removeSprite("injury_body");
		local wolf_injury = this.addSprite("injury_body");
		wolf_injury.setBrush("bust_naked_body_100_injured");
		wolf_injury.Visible = false;

		local wolf_armor = this.addSprite("wolf_armor");
		wolf_armor.setBrush("bust_wolf_02_armor_01");
		local offset = this.createVec(-6, -20);
		this.setSpriteOffset("wolf", offset);
		this.setSpriteOffset("wolf_head", offset);
		this.setSpriteOffset("wolf_armor", offset);
		this.setSpriteOffset("injury_body", offset);
		this.addDefaultStatusSprites();

		this.setSpriteOffset("arms_icon", this.createVec(15, 15));
		this.getSprite("arms_icon").Rotation = 13.0;

		//change to horse kick later
		::Legends.Actives.grant(this, ::Legends.Active.LegendHorseKick, function (_skill) {
			_skill.setRestrained(true);
			_skill.m.ActionPointCost = 0;
		}.bindenv(this));
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHorseMovement);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHorseCharge);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHorsePirouette);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
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
		if (_tile == null)
		{
			return;
		}

		local flip = this.Math.rand(0, 100) < 50;
		local decal;
		this.m.IsCorpseFlipped = flip;
		decal = _tile.spawnDetail(this.getSprite("wolf").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
		decal.setBrightness(0.9);
		decal.Scale = 0.95;
		decal = _tile.spawnDetail("bust_wolf_02_armor_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
		decal.setBrightness(0.9);
		decal.Scale = 0.95;

		if (_fatalityType != this.Const.FatalityType.Decapitated)
		{
			decal = _tile.spawnDetail(this.getSprite("wolf_head").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.setBrightness(0.9);
			decal.Scale = 0.95;
		}
		else if (_fatalityType == this.Const.FatalityType.Decapitated)
		{
			local layers = [
				this.getSprite("wolf_head").getBrush().Name + "_dead"
			];
			local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-20, 15), 0.0, "bust_wolf_head_bloodpool");
			decap[0].setBrightness(0.9);
			decap[0].Scale = 0.95;
		}
		else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
		{
			decal = _tile.spawnDetail(this.getSprite("wolf").getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Scale = 0.95;
		}
		else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
		{
			decal = _tile.spawnDetail(this.getSprite("wolf").getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Scale = 0.95;
		}

		this.spawnTerrainDropdownEffect(_tile);
		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "A Horse";
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
		corpse.IsResurrectable = false;
		_tile.Properties.set("Corpse", corpse);
		this.Tactical.Entities.addCorpse(_tile);
	}

	function spawnWolf( _info )
	{
		this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived].len() - 1)], this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1], _info.Tile.Pos, 1.0);
		local entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_horse", _info.Tile.Coords.X, _info.Tile.Coords.Y);

		if (entity != null)
		{
			entity.setVariant(this.m.Variant);
			entity.setFaction(_info.Faction);
			entity.setMoraleState(_info.Morale);
		}
	}

	function spawnGoblin( _info )
	{
		this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other1][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other1].len() - 1)], this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1], _info.Tile.Pos, 1.0);
		local entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug", _info.Tile.Coords.X, _info.Tile.Coords.Y);

		if (entity != null)
		{
			// local newBody = entity.getSprite("body");
			// newBody.setBrush(_info.Body);
			// newBody.Color = _info.Color;
			// newBody.Saturation = _info.Saturation;
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
		local r;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		local item = this.Const.World.Common.pickArmor([
			[3, "gambeson"],
			[1, "padded_surcoat"]
		]);
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 75)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "open_leather_cap"],
				[1, "headscarf"],
				[1, "mouth_piece"],
				[1, "full_leather_cap"],
				[1, "aketon_cap"]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

	function getHeadNames() {
		local r = this.Math.rand(0,1);

		//I only see these two, feel free to fix. Just needs to assign "bust_head_xx" for horse to work properly, not from Heads array for some reason
		if (r == 0) {
			return "bust_head_5" + this.Math.rand(0,1);
		}
		else {
			local r = this.Math.rand(0,1);
			if (r == 0) {
				return "bust_head_female_0" + this.Math.rand(1, 9);
			}
			else {
				return "bust_head_female_1" + this.Math.rand(0,6);
			}
		}
	}

});

