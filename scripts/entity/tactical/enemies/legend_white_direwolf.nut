this.legend_white_direwolf <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendWhiteDirewolf;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendWhiteDirewolf.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-10, -25);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/werewolf_hurt_01.wav",
			"sounds/enemies/werewolf_hurt_02.wav",
			"sounds/enemies/werewolf_hurt_03.wav",
			"sounds/enemies/werewolf_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/werewolf_death_01.wav",
			"sounds/enemies/werewolf_death_02.wav",
			"sounds/enemies/werewolf_death_03.wav",
			"sounds/enemies/werewolf_death_04.wav",
			"sounds/enemies/werewolf_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/werewolf_flee_01.wav",
			"sounds/enemies/werewolf_flee_02.wav",
			"sounds/enemies/werewolf_flee_03.wav",
			"sounds/enemies/werewolf_flee_04.wav",
			"sounds/enemies/werewolf_flee_05.wav",
			"sounds/enemies/werewolf_flee_06.wav"
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
		this.m.Sound[this.Const.Sound.ActorEvent.Attack] = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/werewolf_fatigue_01.wav",
			"sounds/enemies/werewolf_fatigue_02.wav",
			"sounds/enemies/werewolf_fatigue_03.wav",
			"sounds/enemies/werewolf_fatigue_04.wav",
			"sounds/enemies/werewolf_fatigue_05.wav",
			"sounds/enemies/werewolf_fatigue_06.wav",
			"sounds/enemies/werewolf_fatigue_07.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] = 0.8;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.7;
		this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_white_wolf_agent");
		this.m.AIAgent.setActor(this);

		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.extend([
				[100, "scripts/items/misc/legend_white_wolf_pelt_item"],
				[100, "scripts/items/loot/sabertooth_item"],
				[100, "scripts/items/loot/valuable_furs_item"],
				[100, "scripts/items/supplies/strange_meat_item"],
				[33, "scripts/items/loot/sabertooth_item"],
				[33, "scripts/items/loot/valuable_furs_item"],
				[33, "scripts/items/supplies/strange_meat_item"],
				[20, "scripts/items/misc/legend_white_wolf_pelt_item"]
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

		local flip = this.Math.rand(0, 100) < 50;

		if (_tile != null) {
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local head_frenzy = this.getSprite("head_frenzy");
			decal = _tile.spawnDetail("bust_direwolf_01_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated) {
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;

				if (head_frenzy.HasBrush) {
					decal = _tile.spawnDetail(head_frenzy.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}
			} else if (_fatalityType == this.Const.FatalityType.Decapitated) {
				local layers = [
				head.getBrush().Name + "_dead"
				];

				if (head_frenzy.HasBrush) {
					layers.push(head_frenzy.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;

				if (head_frenzy.HasBrush) {
					decap[1].Scale = 0.95;
				}
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow) {
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin) {
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		local corpse = this.generateCorpse(_tile, _fatalityType);
		this.dropLoot(_tile, tileLoot, !flip);

		if (_tile == null) {
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		} else {
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse( _tile, _fatalityType )
	{
		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "A Direwolf";
		corpse.Items = this.getItems();
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
		corpse.Tile = _tile;
		return corpse;
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendWhiteDirewolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_direwolf_white_01_body");

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_direwolf_white_01_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local head_frenzy = this.addSprite("head_frenzy");
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_white_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		::Legends.Actives.grant(this, ::Legends.Active.LegendWhiteWolfBite);
		::Legends.Actives.grant(this, ::Legends.Active.WerewolfBite);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Actives.grant(this, ::Legends.Active.LegendWhiteWolfHowl);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.InspiringPresence);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueBeliever);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendWerewolf);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSecondWind);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
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
					dateToSkip = 200;
					break;
				case this.Const.Difficulty.Hard:
					dateToSkip = 150;
					break;
				case this.Const.Difficulty.Legendary:
					dateToSkip = 100;
					break;
			}

			if (this.World.getTime().Days >= dateToSkip)
			{
				local bonus = this.Math.min(1, this.Math.floor( (this.World.getTime().Days - dateToSkip) / 20.0));
				b.MeleeSkill += bonus;
				b.RangedSkill += bonus;
				b.MeleeDefense += this.Math.floor(bonus / 2);
				b.RangedDefense += this.Math.floor(bonus / 2);
				b.Hitpoints += this.Math.floor(bonus * 2);
				b.Initiative += this.Math.floor(bonus / 2);
				b.Stamina += bonus;
			//	b.XP += this.Math.floor(bonus * 4);
				b.Bravery += bonus;
				b.FatigueRecoveryRate += this.Math.floor(bonus / 4);
			}
		}

	}

});

