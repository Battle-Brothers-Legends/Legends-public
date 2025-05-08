this.legend_mummy_medium <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendMummyMedium;
		this.m.XP = this.Const.Tactical.Actor.LegendMummyMedium.XP;
		this.m.ResurrectionValue = 4.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_medium";
		this.legend_mummy.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyMedium);
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
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}

	}

	function assignRandomEquipment()
	{
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/legend_sling"]
		], "scripts/items/"));

		if (this.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) == null) {
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "shields/ancient/legend_mummy_tower_shield"]
			], "scripts/items/"));
		}

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.legend_mummy_bandages],
			[1, ::Legends.Armor.Ancient.legend_mummy_plate]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[3, ::Legends.Helmet.Ancient.legend_mummy_bandages],
			[1, ::Legends.Helmet.None]
		]));
	}

});

