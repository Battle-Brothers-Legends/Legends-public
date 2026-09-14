this.legend_horse <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendHorse;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendHorse.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-10, -25);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/misc/donkey_hurt_01.wav",
			"sounds/misc/donkey_hurt_02.wav",
			"sounds/misc/donkey_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/misc/donkey_death_01.wav",
			"sounds/misc/donkey_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/misc/donkey_idle_01.wav",
			"sounds/misc/donkey_idle_02.wav",
			"sounds/misc/donkey_idle_03.wav",
			"sounds/misc/donkey_idle_04.wav"
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
		this.m.Sound[this.Const.Sound.ActorEvent.Attack] = [
			"sounds/combat/gallop.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/werewolf_fatigue_01.wav",
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] = 0.8;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.7;
		this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/direwolf_agent");
		this.m.AIAgent.setActor(this);

		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.extend([
				[100, "scripts/items/supplies/strange_meat_item"]
			]);
		}
	}

	function playAttackSound()
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.playSound(this.Const.Sound.ActorEvent.Attack, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] * (this.Math.rand(75, 100) * 0.01), this.m.SoundPitch * 1.15);
		}
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && !_skill.isRanged())
		{
			this.updateAchievement("Ulfhednar", 1, 1);
		}

		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("horse");
			local head = this.getSprite("horse_head");
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

			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];


				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;


			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
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
		corpse.CorpseName = "A Horse";
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
		corpse.Tile = _tile;
		return corpse;
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendHorse);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local variant = this.Math.rand(0, 7);
		local horse = this.addSprite("horse");
		horse.setBrush("bust_naked_body_10" + variant);
		// horse.setHorizontalFlipping(true);
		horse.varySaturation(0.15);
		horse.varyColor(0.07, 0.07, 0.07);
		local horse = this.addSprite("horse_head");
		horse.setBrush("bust_head_10" + variant);
		horse.Saturation = horse.Saturation;
		horse.Color = horse.Color;
		this.removeSprite("injury_body");
		local horse_injury = this.addSprite("injury_body");
		horse_injury.setBrush("bust_naked_body_100_injured");
		horse_injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHorseKick);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHorseMovement);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHorseCharge);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHorsePirouette);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

	}

	//used for horse riders
	function setVariant( _v )
	{
		local body = this.getSprite("horse");
		body.setBrush("bust_naked_body_10" + _v);
		local head = this.getSprite("horse_head");
		head.setBrush("bust_head_10" + _v);
	}

});

