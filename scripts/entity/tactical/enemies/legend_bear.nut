this.legend_bear <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendBear;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendBear.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(40, -20);
		this.m.DecapitateBloodAmount = 3.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/bear_dead.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/unhold_flee_01.wav",
			"sounds/enemies/unhold_flee_02.wav",
			"sounds/enemies/unhold_flee_03.wav",
			"sounds/enemies/unhold_flee_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/bear_hit1.wav",
			"sounds/enemies/bear_hit2.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/bear_idle1.wav",
			"sounds/enemies/bear_idle2.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/unhold_confused_01.wav",
			"sounds/enemies/unhold_confused_02.wav",
			"sounds/enemies/unhold_confused_03.wav",
			"sounds/enemies/unhold_confused_04.wav"
		];
		this.m.SoundPitch = this.Math.rand(0.9, 1.1);
		this.m.SoundVolumeOverall = 1.25;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bear_agent");
		this.m.AIAgent.setActor(this);


		this.m.OnDeathLootTable.extend([
			[66, "scripts/items/supplies/strange_meat_item"]
		]);
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.extend([
				[40, "scripts/items/trade/furs_item"],
				[40, "scripts/items/trade/furs_item"],
				[40, "scripts/items/loot/legend_bear_fur_item"]
			]);
		}
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
			return;
		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local decal;
			local appearance = this.getItems().getAppearance();
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-75, 50), 90.0, sprite_head.getBrush().Name + "_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_unhold_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}

			this.spawnTerrainDropdownEffect(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);
		this.dropLoot(_tile, tileLoot, !flip);

		if (_tile == null) {
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		} else {
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse( _tile, _fatalityType, _killer )
	{
		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "A Bear";
		corpse.Tile = _tile;
		corpse.IsResurrectable = false;
		corpse.IsConsumable = true;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
		return corpse;
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendBear);
		b.IsImmuneToDisarm = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.DamageTotalMult += 0.1;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 190)
		{
			b.DamageTotalMult += 0.2;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bear_01";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bear_01");
		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bear_01_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bear_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.addSprite("helmet");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.BatteringRam);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Actives.grant(this, ::Legends.Active.LegendGrapple);
		::Legends.Actives.grant(this, ::Legends.Active.LegendBearBite);
		::Legends.Actives.grant(this, ::Legends.Active.LegendBearClaws);
		::Legends.Actives.grant(this, ::Legends.Active.UnstoppableCharge);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;		
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 120;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 120;
			this.m.Hitpoints = 2 * b.Hitpoints;
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}


	}

	function assignRandomEquipment()
	{
	}

});

