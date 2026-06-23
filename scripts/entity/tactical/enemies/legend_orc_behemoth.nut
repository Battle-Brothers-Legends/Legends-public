this.legend_orc_behemoth <- this.inherit("scripts/entity/tactical/legend_orc", {
	m = {},

	function create() {
		this.m.Type = this.Const.EntityType.LegendOrcBehemoth;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendOrcBehemoth.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.DecapitateBloodAmount = 3.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/orcgiant_death_01.wav",
			"sounds/enemies/orcgiant_death_02.wav",
			"sounds/enemies/orcgiant_death_03.wav",
			"sounds/enemies/orcgiant_death_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/orcgiant_flee_01.wav",
			"sounds/enemies/orcgiant_flee_02.wav",
			"sounds/enemies/orcgiant_flee_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/orcgiant_hurt_01.wav",
			"sounds/enemies/orcgiant_hurt_02.wav",
			"sounds/enemies/orcgiant_hurt_03.wav",
			"sounds/enemies/orcgiant_hurt_04.wav",
			"sounds/enemies/orcgiant_hurt_05.wav",
			"sounds/enemies/orcgiant_hurt_06.wav",
			"sounds/enemies/orcgiant_hurt_07.wav",
			"sounds/enemies/orcgiant_hurt_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/orcgiant_idle_01.wav",
			"sounds/enemies/orcgiant_idle_02.wav",
			"sounds/enemies/orcgiant_idle_03.wav",
			"sounds/enemies/orcgiant_idle_04.wav",
			"sounds/enemies/orcgiant_idle_05.wav",
			"sounds/enemies/orcgiant_idle_06.wav",
			"sounds/enemies/orcgiant_idle_07.wav",
			"sounds/enemies/orcgiant_idle_08.wav",
			"sounds/enemies/orcgiant_idle_09.wav",
			"sounds/enemies/orcgiant_idle_10.wav",
			"sounds/enemies/orcgiant_idle_11.wav",
			"sounds/enemies/orcgiant_idle_12.wav",
			"sounds/enemies/orcgiant_idle_13.wav",
			"sounds/enemies/orcgiant_idle_14.wav",
			"sounds/enemies/orcgiant_idle_15.wav",
			"sounds/enemies/orcgiant_idle_16.wav",
			"sounds/enemies/orcgiant_idle_17.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.SoundPitch = 0.6;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.75;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_orc_behemoth_agent");
		this.m.AIAgent.setActor(this);
	}

	function playSound(_type, _volume, _pitch = 1.0) {
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50) {
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath(_killer, _skill, _tile, _fatalityType) {
		this.legend_orc.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse(_tile, _fatalityType, _killer) {
		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "An Orc Behemoth";
		corpse.Tile = _tile;
		corpse.IsResurrectable = false;
		corpse.IsConsumable = true;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
		return corpse;
	}

	function onFactionChanged() {
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		flip = !flip;
		local v = 15;
		local v2 = -5;
		foreach (a in this.Const.CharacterSprites.Helmets) {
			if (!this.hasSprite(a)) {
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
			this.setSpriteOffset(a, this.createVec(flip ? v2 : -v2, v));
		}
	}

	function onInit() {
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendOrcBehemoth);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= ::Const.World.Scaling.Orcs.LegendsOrcHighStatIncreaseDay) {
			b.MeleeSkill += 10;
			b.DamageTotalMult += 0.2;
		}

		this.m.BaseProperties.DamageTotalMult -= 0.1;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints * 2;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "legend_orc_behemoth_body_01";

		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("legend_orc_behemoth_body_01");
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("legend_orc_behemoth_body_01_bloodied");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("legend_orc_behemoth_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("legend_orc_behemoth_head_01_bloodied");

		foreach (a in this.Const.CharacterSprites.Helmets) {
			this.addSprite(a);
		}
		local v = 15;
		local v2 = -5;

		foreach (a in this.Const.CharacterSprites.Helmets) {
			if (!this.hasSprite(a)) {
				continue;
			}
			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.8;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Actives.grant(this, ::Legends.Active.HandToHand);
		::Legends.Actives.grant(this, ::Legends.Active.LineBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.BatteringRam);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAssuredConquest);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTasteThePain);
		::Legends.Effects.grant(this, ::Legends.Effect.BerserkerRage);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSecondWind);
		}
	}

	function onFinish() {
		this.actor.onFinish();
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");

		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/named/legend_named_orc_axe_2h"],
			[1, "weapons/named/legend_named_orc_flail_2h"],
		], "scripts/items/"));

		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueBeliever);
		return true;
	}

	function assignRandomEquipment() {
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/greenskins/legend_limb_lopper"],
			[1, "weapons/greenskins/legend_bough"],
			[1, "weapons/greenskins/legend_man_mangler"],
			[1, "weapons/greenskins/legend_skullbreaker"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.legend_orc_behemoth_armor]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.legend_orc_behemoth_helmet]
		]));
	}

});
