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
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		}

	}

	function assignRandomEquipment()
	{

		this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_kopis"));


		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{

			this.m.Items.equip(this.new("scripts/items/shields/ancient/legend_mummy_tower_shield"));

		}

		local armor = [
			[1, "ancient/legend_mummy_bandages"],
			[1, "ancient/legend_mummy_plate"]
			//[1, "legend_armor_plate_ancient_scale_coat_restored"],
			//[1, "scripts/items/armor/ancient/legend_armor_plate_ancient_scale_harness_restored"],
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[3, "ancient/legend_mummy_bandages"],
			[1, ""]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

