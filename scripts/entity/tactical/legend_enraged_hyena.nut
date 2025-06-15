this.legend_enraged_hyena <- this.inherit("scripts/entity/tactical/enemies/hyena", {

	m = {},

	function getName() {
		return "Enraged Hyena";
	}

	function create() {
		this.hyena.create();
	}

	function onInit() {
		this.hyena.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FrenziedHyena);
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

		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSecondWind);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType) {

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
			corpse.CorpseName		= "An Enraged Hyena";
			corpse.IsHeadAttached	= _fatalityType != this.Const.FatalityType.Decapitated;

			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			// loot
			if((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)) {
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

		// die
		actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});
