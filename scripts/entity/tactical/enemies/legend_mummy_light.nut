this.legend_mummy_light <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {
		IsRanged = false
	},
	function create()
	{
		this.m.IsRanged = this.Math.rand(1, 5) == 1 ? true : false;
		this.m.Type = this.Const.EntityType.LegendMummyLight;
		this.m.XP = this.Const.Tactical.Actor.LegendMummyLight.XP;
		this.m.ResurrectionValue = 2.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_light";
		this.legend_mummy.create();

		if (!this.m.IsRanged)
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		else
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
			this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
			this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		}
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyLight);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
	}

	function assignRandomEquipment()
	{
		if (!this.m.IsRanged)
		{
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "weapons/ancient/broken_ancient_sword"],
				[1, "weapons/ancient/ancient_spear"],
				[1, "weapons/ancient/ancient_sword"],
				[1, "weapons/ancient/khopesh"]
			], "scripts/items/"));

			this.getItems().equip(::Const.World.Common.pickItem([
				[66, "shields/ancient/legend_mummy_shield"],
				[33, null]
			], "scripts/items/"));
		}
		else
		{
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "weapons/legend_dilapitated_sling"]
			], "scripts/items/"));

			this.getItems().addToBag(::Const.World.Common.pickItem([
				[1, "weapons/ancient/khopesh"]
			], "scripts/items/"));
		}

		this.getItems().equip(::Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.legend_mummy_bandages],
			[3, ::Legends.Armor.None]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.legend_mummy_bandages],
			[4, ::Legends.Helmet.None]
		]));
	}

});

