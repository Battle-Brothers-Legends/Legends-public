this.legend_mummy_priest <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendMummyPriest;
		this.legend_mummy.create();
		this.m.XP = this.Const.Tactical.Actor.LegendMummyPriest.XP;
		this.m.ResurrectionValue = 2.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_priest";
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_mummy_queen_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		this.getSprite("body").setBrush("bust_skeleton_body_02");
		this.setDirty(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyPriest);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}

	}

	function assignRandomEquipment() {
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/ancient/legend_kopis"]
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.legend_mummy_dress]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.legend_mummy_headband],
			[1, ::Legends.Helmet.Ancient.legend_mummy_crown]
		]));
	}

});

