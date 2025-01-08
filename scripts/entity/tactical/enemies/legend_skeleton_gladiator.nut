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
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMasteryNets);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SpecThrowing);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.QuickHands);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBallistics);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendCloseCombatArcher);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		}
	}

	function assignRandomEquipment()
	{

		this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		this.m.Items.equip(this.new("scripts/items/weapons/throwing_spear"));
		this.m.Items.equip(this.new("scripts/items/weapons/throwing_spear"));
		this.m.Items.equip(this.new("scripts/items/weapons/throwing_spear"));
		this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));


		this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));


		local item = this.Const.World.Common.pickArmor([
			[1, "ancient/ancient_ripped_cloth"]
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[34, ""],
			[66, "ancient/ancient_gladiator_helmet"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

