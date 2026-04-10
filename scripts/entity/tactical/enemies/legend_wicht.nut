this.legend_wicht <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = this.createVec(0, 0),
		DistortAnimationStartTimeC = 0,
		DistortTargetD = null,
		DistortTargetPrevD = this.createVec(0, 0),
		DistortAnimationStartTimeD = 0,
		ArmorDifficultyMult = 0.5,
	},

	function create() {
		this.m.Type = this.Const.EntityType.LegendWicht;
		this.m.BloodType = this.Const.BloodType.None;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.LegendWicht.XP;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/geist_idle_13.wav",
			"sounds/enemies/geist_idle_14.wav",
			"sounds/enemies/geist_idle_15.wav",
			"sounds/enemies/geist_idle_16.wav",
			"sounds/enemies/geist_idle_17.wav"
		];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.getFlags().add("undead");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath(_killer, _skill, _tile, _fatalityType) {
		if (!this.Tactical.State.isScenarioMode()
			&& _killer != null
			&& _killer.isPlayerControlled())
		{
			this.updateAchievement("OvercomingFear", 1, 1);
		}
		local flip = !this.isAlliedWithPlayer();

		if (_tile != null) {
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_ghost_body_01",
					"bust_ghost_head_01"
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

			local appearance = this.getItems().getAppearance();

			//will need edits if wichts start using front/back upgrades similar to human.nut
			local armorLayers = [
				"CorpseArmor",
				"CorpseArmorLayerChain",
				"CorpseArmorLayerPlate",
				"CorpseArmorLayerTabbard",
				"CorpseArmorUpgradeBack",
				"CorpseArmorUpgradeFront",
				"CorpseArmorLayerCloakBack",
				"CorpseArmorLayerCloakFront",
			];

			foreach (layer in armorLayers) {
				if (appearance[layer] != "") {
					local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					if (decal != null) {
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}
				}
			}

			if (!appearance.HideCorpseHead && _fatalityType != this.Const.FatalityType.Decapitated)
			{
				local helmetLayers = [
					"HelmetLayerVanityLowerCorpse",
					"HelmetLayerVanity2LowerCorpse",
					"HelmetCorpse",
					"HelmetLayerHelmLowerCorpse",
					"HelmetLayerTopLowerCorpse",
					"HelmetLayerHelmCorpse",
					"HelmetLayerTopCorpse",
					"HelmetLayerVanityCorpse",
					"HelmetLayerVanity2Corpse"
				];
				foreach (layer in helmetLayers) {
					if (appearance[layer] != "") {
						local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						if (decal != null) {
							decal.Scale = 0.9;
							decal.setBrightness(0.9);
						}
					}
				}
			}
		}
		this.spawnTerrainDropdownEffect(_tile);
		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null)
		{
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		}
		else
		{
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse( _tile, _fatalityType, _killer )
	{
		local isResurrectable = false;
		local corpse = clone this.Const.Corpse;
		corpse.IsResurrectable = false;
		corpse.IsConsumable = false;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;

		if (_tile != null)
		{
			corpse.Tile = _tile;
		}

		return corpse;
	}

	function onFactionChanged() {
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);
		this.getSprite("blur_3").setHorizontalFlipping(flip);
		this.getSprite("blur_4").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("surcoat").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_front").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("accessory").setHorizontalFlipping(flip);
		this.getSprite("accessory_special").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak_front").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);

		this.getSprite("helmet").setHorizontalFlipping(flip);
		this.getSprite("helmet_damage").setHorizontalFlipping(flip);
		this.getSprite("helmet_helm_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_top_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_lower_2").setHorizontalFlipping(flip);
		this.getSprite("helmet_helm").setHorizontalFlipping(flip);
		this.getSprite("helmet_top").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_2").setHorizontalFlipping(flip);
	}

	function onInit() {
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendWicht);
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = false;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToFire = true;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 140) {
			b.MeleeDefense += 5;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_ghost_body_01";
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("bust_ghost_body_01");
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush("bust_ghost_head_01");
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush("bust_ghost_body_01");
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("bust_ghost_body_01");
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		local blur_3 = this.addSprite("blur_3");
		blur_3.setBrush("bust_ghost_head_01");
		blur_3.varySaturation(0.25);
		blur_3.varyColor(0.2, 0.2, 0.2);
		local blur_4 = this.addSprite("blur_4");
		blur_4.setBrush("bust_ghost_head_01");
		blur_4.varySaturation(0.25);
		blur_4.varyColor(0.2, 0.2, 0.2);
		this.addSprite("armor");
		this.addSprite("armor_upgrade_front");
		this.addSprite("surcoat");
		this.addSprite("dirt");
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("accessory");
		this.addSprite("accessory_special");
		this.addSprite("armor_upgrade_back");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_layer_cloak_front");
		this.addSprite("helmet");
		this.addSprite("helmet_damage");
		this.addSprite("helmet_helm");
		this.addSprite("helmet_helm_lower");
		this.addSprite("helmet_top_lower");
		this.addSprite("helmet_vanity_lower");
		this.addSprite("helmet_vanity_lower_2");
		this.addSprite("helmet_top");
		this.addSprite("helmet_vanity");
		this.addSprite("helmet_vanity_2");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));

		// perks need to be added
		::Legends.Traits.grant(this, ::Legends.Trait.RacialGhost);
		::Legends.Traits.get(this, ::Legends.Trait.RacialGhost).m.IsWicht = true;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught)
			this.m.ArmorDifficultyMult += 0.5;
		}
		::Legends.S.scaleBaseProperties(b); // this bit increases hitpoints
		b.Hitpoints = 1;

		local daysToScale = this.Math.floor(this.World.getTime().Days / ::Legends.S.getDaysToScaleDifficulty());
		this.m.ArmorDifficultyMult += 0.1 * this.Math.floor(daysToScale);
	}

	function onRender() {
		this.actor.onRender();

		if (this.m.DistortTargetA == null) {
			this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA)) {
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetB == null) {
			this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.9000001, this.m.DistortAnimationStartTimeB)) {
			this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetC == null) {
			this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("body", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.3, this.m.DistortAnimationStartTimeC)) {
			this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevC = this.m.DistortTargetC;
			this.m.DistortTargetC = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetD == null) {
			this.m.DistortTargetD = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevD, this.m.DistortTargetD, 5.5999999, this.m.DistortAnimationStartTimeD)) {
			this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevD = this.m.DistortTargetD;
			this.m.DistortTargetD = this.createVec(this.Math.rand(0, 8) - 4, this.Math.rand(0, 8) - 4);
		}
	}

	function onFinish() {
		this.actor.onFinish();
	}

	function assignRandomEquipment() {
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand)) {
			local weapons = [
				"weapons/legend_zweihander",
				"weapons/greataxe",
				"weapons/greatsword",
				"weapons/two_handed_hammer",
				"weapons/two_handed_flanged_mace",
				"weapons/two_handed_flail",
				"weapons/bardiche"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local b = this.m.BaseProperties;
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body)) {
			local armor = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.ghost_armor]
			]);
			b.Armor[0] = this.Math.round(armor.getArmorMax() * this.m.ArmorDifficultyMult);
			b.ArmorMax[0] = this.Math.round(armor.getArmorMax() * this.m.ArmorDifficultyMult);
			this.m.Items.equip(armor);
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head)) {
			local helmet = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.ghost_helmet]
			]);
			b.Armor[1] = this.Math.round(helmet.getArmorMax() * this.m.ArmorDifficultyMult);
			b.ArmorMax[1] = this.Math.round(helmet.getArmorMax() * this.m.ArmorDifficultyMult);
			this.m.Items.equip(helmet);
		}
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		local b = this.m.BaseProperties;
		this.m.ArmorDifficultyMult += 0.5;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_greataxe",
			"weapons/named/legend_named_zweihander",
			"weapons/named/legend_named_flamberge",
			"weapons/named/named_bardiche",
			"weapons/named/named_two_handed_hammer",
			"weapons/named/named_two_handed_mace",
			"weapons/named/named_two_handed_flail"
		];

		local upgrades = [];
		local r = this.Math.rand(1, 3);
		if (r == 1) {
			local armor = this.Const.World.Common.pickArmor([
				[2, ::Legends.Armor.Named.ghost_armor_named_01],
				[1, ::Legends.Armor.Named.ghost_armor_named_02]
			]);
			b.Armor[0]= this.Math.round(armor.getArmorMax() * this.m.ArmorDifficultyMult);
			b.ArmorMax[0]= this.Math.round(armor.getArmorMax() * this.m.ArmorDifficultyMult);
			this.m.Items.equip(armor);
		}
		else if (r == 2) {
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else {
			local helmet = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Named.ghost_helmet_named]
			]);
			b.Armor[1]= this.Math.round(helmet.getArmorMax() * this.m.ArmorDifficultyMult);
			b.ArmorMax[1]= this.Math.round(helmet.getArmorMax() * this.m.ArmorDifficultyMult);
			this.m.Items.equip(helmet);
		}
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		return true;
	}

});
