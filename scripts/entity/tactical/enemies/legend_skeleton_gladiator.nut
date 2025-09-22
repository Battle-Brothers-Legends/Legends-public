this.legend_skeleton_gladiator <- this.inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SkeletonGladiator;
		this.m.XP = this.Const.Tactical.Actor.SkeletonGladiator.XP;
		this.m.ResurrectionValue = 3.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_skeleton_gladiator";
		this.skeleton.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_skeleton_gladiator_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonGladiator);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMasteryNets);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecThrowing);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPointBlank);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
	}

	function assignRandomEquipment()
	{

		this.getItems().equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		this.getItems().equip(this.new("scripts/items/weapons/throwing_spear"));
		this.getItems().equip(this.new("scripts/items/weapons/throwing_spear"));
		this.getItems().equip(this.new("scripts/items/weapons/throwing_spear"));
		this.getItems().equip(this.new("scripts/items/tools/throwing_net"));

		this.getItems().equip(this.new("scripts/items/shields/ancient/tower_shield"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_ripped_cloth]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[2, ::Legends.Helmet.Ancient.ancient_gladiator_helmet]
		]));
	}

});

