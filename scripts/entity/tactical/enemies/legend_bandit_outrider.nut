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
			"sounds/combat/rearing_01.wav",
			"sounds/combat/rearing_01.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other2] = [
			"sounds/enemies/wolf_death_00.wav",
			"sounds/enemies/wolf_death_01.wav",
			"sounds/enemies/wolf_death_02.wav",
			"sounds/enemies/wolf_death_03.wav",
			"sounds/enemies/wolf_death_04.wav",
			"sounds/enemies/wolf_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/wolf_idle_00.wav",
			"sounds/enemies/wolf_idle_01.wav",
			"sounds/enemies/wolf_idle_02.wav",
			"sounds/enemies/wolf_idle_03.wav",
			"sounds/enemies/wolf_idle_04.wav",
			"sounds/enemies/wolf_idle_06.wav",
			"sounds/enemies/wolf_idle_07.wav",
			"sounds/enemies/wolf_idle_08.wav",
			"sounds/enemies/wolf_idle_09.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 0.6;
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/combat/gallop.wav"
		];
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_wolfrider_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditOutrider);
		b.AdditionalActionPointCost = 1;
		b.DamageDirectMult = 1.25;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush(getHeadNames());
		this.getSprite("head").setBrush("bust_head_female_0" + this.Math.rand(1, 9));
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
		wolf.setBrush("bust_naked_body_10" + variant);
		wolf.varySaturation(0.15);
		wolf.varyColor(0.07, 0.07, 0.07);
		local wolf = this.addSprite("wolf_head");
		wolf.setBrush("bust_head_10" + variant);
		wolf.Saturation = wolf.Saturation;
		wolf.Color = wolf.Color;
		wolf.setHorizontalFlipping(this.isAlliedWithPlayer());
		this.removeSprite("injury_body");
		local wolf_injury = this.addSprite("injury_body");
		wolf_injury.setBrush("bust_naked_body_100_injured");
		wolf_injury.Visible = false;
		wolf_injury.setHorizontalFlipping(this.isAlliedWithPlayer());
		local wolf_armor = this.addSprite("horse_armor");
		wolf_armor.setBrush("horse_armor_plate");
		wolf_armor.setHorizontalFlipping(this.isAlliedWithPlayer());
		offset = this.createVec(8, -20);
		local wolfarmoroffset = this.createVec(8,14);
		this.setSpriteOffset("wolf", offset);
		this.setSpriteOffset("wolf_head", offset);
		this.setSpriteOffset("wolf_armor", wolfarmoroffset);
		this.setSpriteOffset("injury_body", offset);
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(15, 15));
		this.getSprite("arms_icon").Rotation = 13.0;
		local horse_kick = this.new("scripts/skills/actives/legend_horse_kick");
		this.m.Skills.add(horse_kick);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_horse_movement"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_horse_charge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_horse_pirouette"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	function onAfterInit()
	{
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
			this.human.onDeath(_killer, _skill, _tile, _fatalityType);
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

			for( local i = 0; i != 6; i = i )
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

				i = ++i;
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
		corpse.CorpseName = "A Wolf";
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
			//No setVariant for our horse do it different way
			//entity.setVariant(this.m.Variant, _info.WolfColor, _info.WolfSaturation, 0.45);
			entity.setFaction(_info.Faction);
			entity.setMoraleState(_info.Morale);
		}
	}

	function spawnGoblin( _info )
	{
		this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other1][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other1].len() - 1)], this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1], _info.Tile.Pos, 1.0);
		local entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", _info.Tile.Coords.X, _info.Tile.Coords.Y);

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

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local r = this.Math.rand(1, 6);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/hood"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
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

