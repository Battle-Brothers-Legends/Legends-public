this.legend_caravan_hand <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.CaravanHand;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.CaravanHand.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/caravan_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.CaravanHand);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}


	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
	}
	// function assignRandomEquipment()
	// {
	// 	local r = this.Math.rand(1, 9);

	// 	if (r == 1)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
	// 	}
	// 	else if (r == 2)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/knife"));
	// 	}
	// 	else if (r == 3)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
	// 	}
	// 	else if (r == 4)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
	// 	}
	// 	else if (r == 5)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
	// 	}
	// 	else if (r == 6)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
	// 	}
	// 	else if (r == 7)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
	// 	}
	// 	else if (r == 8)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
	// 	}
	// 	else if (r == 9)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
	// 	}

	// 	if (this.Math.rand(1, 100) <= 33)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
	// 	}

	// 	local item = this.Const.World.Common.pickArmor([
	//		[1, ::Legends.Armor.Standard.leather_tunic, this.Math.rand(6,7)],
	// 		[1, ::Legends.Armor.Standard.padded_leather],
	// 		[1, ::Legends.Armor.Standard.padded_surcoat],
	// 		[1, ::Legends.Armor.Standard.leather_lamellar]
	// 	]);
	// 	this.m.Items.equip(item);

	// 	if (this.Math.rand(1, 100) <= 33)
	// 	{
	// 		local item = this.Const.World.Common.pickHelmet([
	// 			[1, ::Legends.Helmet.Standard.hood],
	// 			[1, ::Legends.Helmet.Standard.aketon_cap]
	// 		])
	// 		if (item != null)
	// 		{
	// 			this.m.Items.equip(item);
	// 		}
	// 	}
	// }

});

