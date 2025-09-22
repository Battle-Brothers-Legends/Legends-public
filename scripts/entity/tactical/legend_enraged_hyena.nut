this.legend_enraged_hyena <- this.inherit("scripts/entity/tactical/enemies/hyena", {

	m = {
		Size = 1.0,
		DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		IsFlipping = false,
		LastSmokeTime = 0
	},

	function getName() {
		return "Enraged Hyena";
	}

	function create() {
		this.hyena.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_enraged_hyena_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit() {
		this.hyena.onInit();
		this.setRenderCallbackEnabled(true);

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendEnragedHyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		local body = this.getSprite("body");
		body.setBrush("bust_hyena_0" + this.Math.rand(7, 8));
		local head = this.getSprite("head");
		head.setBrush("bust_hyena_0" + this.Math.rand(7, 8) + "_head");
		if (this.Math.rand(0, 100) < 90) {
			body.varySaturation(0.2);
		}
		if (this.Math.rand(0, 100) < 90) {
			body.varyColor(0.05, 0.05, 0.05);
		}

		::Legends.Actives.grant(this, ::Legends.Active.LegendEnragedHyenaBite);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);

		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSecondWind);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100) {
				::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			}
		}

		if (this.Tactical.State.isScenarioMode()) {
			return;
		}

		::Legends.S.scaleBaseProperties(b);
	}

	function onDamageReceived(_attacker, _skill, _hitInfo) {
		if (_hitInfo.DamageRegular > 0 || _hitInfo.DamageArmor > 0) {
			this.freeAllBittenVictims();
		}

		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function freeAllBittenVictims() {
		if (!this.getFlags().has("LegendEnragedHyenaBiteVictim")) {
			return;
		}

		local victimToken = this.getFlags().get("LegendEnragedHyenaBiteVictim");

		foreach (entity in this.Tactical.Entities.getAllInstancesAsArray()) {
			if (::Legends.S.skillEntityAliveCheck(entity)) {
				continue;
			}
			if (!entity.getFlags().has("LegendEnragedHyenaAttacker")) {
				continue;
			}
			local attackerToken = entity.getFlags().get("LegendEnragedHyenaAttacker");
			if (attackerToken != victimToken) {
				continue;
			}
			local biteEffect = ::Legends.Effects.get(entity, ::Legends.Effect.LegendEnragedHyenaBite);
			if (biteEffect != null) {
				biteEffect.removeSelf();
				break;
			}
		}
	}

	function onMovementFinish(_tile) {
		this.actor.onMovementFinish(_tile);

		if (!this.getFlags().has("LegendEnragedHyenaBiteVictim")) {
			return;
		}

		local victimToken = this.getFlags().get("LegendEnragedHyenaBiteVictim");

		foreach (entity in this.Tactical.Entities.getAllInstancesAsArray()) {
			if (::Legends.S.skillEntityAliveCheck(entity)) {
				continue;
			}
			if (!entity.getFlags().has("LegendEnragedHyenaAttacker")) {
				continue;
			}
			local attackerToken = entity.getFlags().get("LegendEnragedHyenaAttacker");
			if (attackerToken != victimToken) {
				continue;
			}
			local victimTile = entity.getTile();
			if (victimTile == null || victimTile.getDistanceTo(_tile) > 1) {
				local biteEffect = ::Legends.Effects.get(entity, ::Legends.Effect.LegendEnragedHyenaBite);
				if (biteEffect != null) {
					biteEffect.removeSelf();
					break;
				}
			}
		}
	}

	function onRender() {
		this.actor.onRender();

		if (this.m.DistortTargetA == null) {
			// Initialize breathing animation targets
			this.m.DistortTargetA = this.m.IsFlipping ? this.createVec(0, 1.5 * this.m.Size) : this.createVec(0, -1.5 * this.m.Size);
			this.m.DistortTargetB = this.m.IsFlipping ? this.createVec(0, 1.0 * this.m.Size) : this.createVec(0, -1.0 * this.m.Size);
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF() - this.Math.rand(10, 100) * 0.01;
			this.m.LastSmokeTime = this.Time.getVirtualTimeF();
		}

		// Apply breathing animation to body and head
		this.moveSpriteOffset("body", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.8, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("injury", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.8, this.m.DistortAnimationStartTimeA);

		// Head moves slightly less for more natural look
		local breathCycleComplete = this.moveSpriteOffset("head", this.m.DistortTargetPrevB, this.m.DistortTargetB, 1.8, this.m.DistortAnimationStartTimeA);
		if (breathCycleComplete) {
			// Reset animation cycle
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = this.m.IsFlipping ? this.createVec(0, 1.5 * this.m.Size) : this.createVec(0, -1.5 * this.m.Size);
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = this.m.IsFlipping ? this.createVec(0, 1.0 * this.m.Size) : this.createVec(0, -1.0 * this.m.Size);
			this.m.IsFlipping = !this.m.IsFlipping;
		}

		// Breath effects should be synchronized with body movement
		local currentTime = this.Time.getVirtualTimeF();
		if (breathCycleComplete && currentTime - this.m.LastSmokeTime > 2.0) {
			this.m.LastSmokeTime = currentTime;

			this.Tactical.spawnParticleEffect(
				false,
				["legend_dust_03"],
				this.getTile(),
				0,
				4,
				4,
				150,
				[
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.3,
						ScaleMax = 0.4,
						RotationMin = 0,
						RotationMax = 359,
						VelocityMin = 25,
						VelocityMax = 35,
						DirectionMin = this.createVec(-0.5, 0.1),
						DirectionMax = this.createVec(-0.3, 0.3),
						SpawnOffsetMin = this.createVec(-1, -1),
						SpawnOffsetMax = this.createVec(1, 1),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.8,
						LifeTimeMax = 1.2,
						ColorMin = this.createColor("ffffffbb"),
						ColorMax = this.createColor("ffffffbb"),
						ScaleMin = 0.4,
						ScaleMax = 0.6,
						VelocityMin = 25,
						VelocityMax = 35,
						ForceMin = this.createVec(-5, -15),
						ForceMax = this.createVec(0, -10)
					},
					{
						LifeTimeMin = 0.3,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffff99"),
						ColorMax = this.createColor("ffffff99"),
						ScaleMin = 0.6,
						ScaleMax = 0.8,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = this.createVec(0, -5),
						ForceMax = this.createVec(0, -5)
					}
				],
				this.createVec(-48, 14)
			);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType) {
		// Free all bitten victims when the hyena dies
		this.freeAllBittenVictims();

		// spawn corpse
		if (_tile != null) {
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			m.IsCorpseFlipped = flip;

			local body = getSprite("body");
			local head = getSprite("head");

			decal = _tile.spawnDetail("bust_hyena_07_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated) {
				// no fatality
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
			} else if (_fatalityType == this.Const.FatalityType.Decapitated) {
				// decapitated
				local layers = [ head.getBrush().Name + "_dead" ];
				local decap = this.Tactical.spawnHeadEffect(getTile(), layers, createVec(0, 0), 0.0, "bust_hyena_head_bloodpool");
				decap[0].Color			= head.Color;
				decap[0].Saturation		= head.Saturation;
				decap[0].Scale = 0.95;
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow) {
				decal = _tile.spawnDetail("bust_hyena_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			} else if(_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin) {
				decal = _tile.spawnDetail("bust_hyena_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			spawnTerrainDropdownEffect(_tile);
			spawnFlies(_tile);

			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An Enraged Hyena";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;

			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			// loot
			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)) {
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);
				for (local i = 0; i < n; ++i) {
					if (this.Math.rand(1, 100) <= 50) {
						local r = this.Math.rand(1, 100);
						local loot;

						if (r <= 60) {
							loot = new("scripts/items/misc/hyena_fur_item");
						} else {
							loot = new("scripts/items/misc/acidic_saliva_item");
						}

						loot.drop(_tile);
					} else if (this.Math.rand(1, 100) <= 33) {
						local loot = new("scripts/items/supplies/strange_meat_item");
						loot.drop(_tile);
					}
				}

				if (this.Math.rand(1, 100) <= 20) {
					local loot = this.new("scripts/items/loot/sabertooth_item");
					loot.drop(_tile);
				}
			}
		}

		actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});
