this.legend_mummy_heavy <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendMummyHeavy;
		this.m.XP = this.Const.Tactical.Actor.LegendMummyHeavy.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_heavy";
		this.legend_mummy.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyHeavy);
		b.Initiative -= 20;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			b.IsSpecializedInPolearms = true;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}

	}

	function assignRandomEquipment()
	{
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/ancient/legend_fan_axe"],
			[1, "weapons/ancient/crypt_cleaver"],
			[1, "weapons/ancient/bladed_pike"],
			[1, "weapons/ancient/legend_great_khopesh"],
			[1, "weapons/ancient/rhomphaia"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.legend_mummy_bandages],
			[4, ::Legends.Armor.Ancient.legend_mummy_royal_plate]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Ancient.ancient_wig],
			[5, ::Legends.Helmet.Ancient.legend_mummy_headband],
			[1, ::Legends.Helmet.Ancient.legend_mummy_crown_king]
		]));
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/named/legend_named_gladius"],
			[1, "weapons/named/named_crypt_cleaver"],
			[1, "weapons/named/named_khopesh"],
			[1, "weapons/named/legend_named_great_khopesh"],
			[1, "weapons/named/named_warscythe"],
			[1, "weapons/named/named_bladed_pike"]
		], "scripts/items/"));

		::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
	}

});

