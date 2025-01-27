this.legend_vala_warden_script <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Vala = null
	},
	function setVala(_v)
	{
		if (typeof _v == "instance")
		{
			this.m.Vala = _v;
		}
		else
		{
			this.m.Vala = this.WeakTableRef(_v);
		}
	}

	function getValaWarden()
	{
		if (this.m.Vala == null)
		{
			return null;
		}
		return this.m.Vala.getWarden();
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}


	function create()
	{
		this.m.Type = this.Const.EntityType.Ghost;
		this.m.BloodType = this.Const.BloodType.None;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = 0;
		this.m.IsEmittingMovementSounds = false;
		this.m.IsActingImmediately = true;
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
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_vala_warden_agent");
		this.m.AIAgent.setActor(this);
	}


	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_warden_01"
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
		}

		if (this.m.Vala != null)
		{
			this.m.Vala.m.WardenEntity = null;
			this.m.Vala = null;
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}


	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);

		if (!this.Tactical.State.isScenarioMode())
		{
			local f = this.World.FactionManager.getFaction(this.getFaction());

			if (f != null)
			{
				this.getSprite("socket").setBrush(f.getTacticalBase());
			}
		}
		else
		{
			this.getSprite("socket").setBrush(this.Const.FactionBase[this.getFaction()]);
		}
	}


	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);
		local XPkiller = this.Math.floor(_actor.getXPValue() * this.Const.XP.XPForKillerPct);

		if (this.getFaction() == this.Const.Faction.Player || this.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

			foreach( bro in brothers )
			{
				if (this.m.Vala != null && bro.getID() == this.m.Vala.getID())
				{
					bro.addXP(this.Math.floor(XPkiller * 0.50));
				}

				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}


	function setWardenStats(_vala)
	{
		local NewWardenStats = {
			XP = 0,
			Hitpoints = this.Math.ceil(50.0 + (_vala * 1.25)),
			ActionPoints = 9,
			Bravery = 200,
			Stamina = 100,
			MeleeSkill = this.Math.ceil(47.0 + (_vala * 0.25)),
			RangedSkill = this.Math.ceil(32.0 + (_vala * 0.33)),
			MeleeDefense = this.Math.ceil(0.0 + (_vala * 0.25)),
			RangedDefense = this.Math.ceil(10.0 + (_vala * 0.33)),
			Initiative = this.Math.ceil(50.0 + (_vala * 0.33)),
			FatigueEffectMult = 0.0,
			MoraleEffectMult = 0.0,
			Armor = [0,	0]
		};

		local WardenStats = this.m.BaseProperties;
		WardenStats.setValues(NewWardenStats);
		this.m.Hitpoints = WardenStats.Hitpoints;
		this.m.CurrentProperties = WardenStats;
	}


	function onInit()
	{
		local WardenProperties = {
			XP = 0,
			ActionPoints = 9,
			Hitpoints = 1,
			Bravery = 200,
			Stamina = 100,
			MeleeSkill = 0,
			RangedSkill = 0,
			MeleeDefense = 0,
			RangedDefense = 0,
			Initiative = 1,
			FatigueEffectMult = 0.0,
			MoraleEffectMult = 0.0,
			Armor = [0,	0]
		};

		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(WardenProperties);
		b.IsImmuneToBleeding = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToZoneOfControl = false;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] *= 10000.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.m.Items.getAppearance().Body = "bust_warden_01";
		this.addSprite("socket").setBrush("bust_base_player");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush("bust_warden_01");
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush("bust_warden_01");
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush("bust_warden_01");
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("bust_warden_01");
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));

		::Legends.Actives.grant(this, ::Legends.Active.LegendValaWardenPaleTouch);
		::Legends.Actives.grant(this, ::Legends.Active.LegendValaWardenWail);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Traits.grant(this, ::Legends.Trait.Loyal); //Should prevent charm
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		// additional skills based on Vala's daily swap?
	}
});
