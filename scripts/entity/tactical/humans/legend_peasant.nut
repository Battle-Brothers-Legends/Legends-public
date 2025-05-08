this.legend_peasant <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.Peasant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Peasant.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Peasant);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		// if(::Legends.isLegendaryDifficulty())
		// 	{
		// 	this.m.Hitpoints = b.Hitpoints * 1.5;
		// 	::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		// 	this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		// 	}

	}


	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
	}
	// function assignRandomEquipment()
	// {
	// 	local r;
	// 	r = this.Math.rand(1, 14);

	// 	if (r == 1)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/knife"));
	// 	}
	// 	else if (r == 2)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
	// 	}
	// 	else if (r == 3)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
	// 	}
	// 	else if (r == 4)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
	// 	}
	// 	else if (r == 5)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
	// 	}
	// 	else if (r == 6)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
	// 	}
	// 	else if (r == 7)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
	// 	}
	// 	else if (r == 8)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
	// 	}
	// 	else if (r == 9)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
	// 	}
	// 	else if (r == 10)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
	// 	}
	// 	else if (r == 11)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
	// 	}
	// 	else if (r == 12)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
	// 	}
	// 	else if (r == 13)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
	// 	}
	// 	else if (r == 14)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
	// 	}


	// 	this.m.Items.equip(this.Const.World.Common.pickArmor([
	// 		[1, ::Legends.Armor.Standard.sackcloth],
	// 		[1, ::Legends.Armor.Standard.thick_tunic],
	// 		[1, ::Legends.Armor.Standard.apron],
	// 		[1, ::Legends.Armor.Standard.tattered_sackcloth],
	// 		[4, ::Legends.Armor.Standard.linen_tunic]
	// 	]));

	// 	if (this.Math.rand(1, 100) <= 33)
	// 	{
	// 		this.m.Items.equip(this.Const.World.Common.pickHelmet([
	// 			[1, ::Legends.Helmet.Standard.straw_hat],
	// 			[1, ::Legends.Helmet.Standard.hood],
	// 			[1, ::Legends.Helmet.Standard.headscarf],
	// 			[1, ::Legends.Helmet.Standard.feathered_hat]
	// 		]))
	// 	}
	// }

});

