this.legend_caravan_guard <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.CaravanGuard;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.CaravanGuard.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/caravan_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.CaravanGuard);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldPush);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
		if (this.Math.rand(1, 100) <= 35)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
		}
	}
	// function assignRandomEquipment()
	// {
	// 	local r = this.Math.rand(1, 6);

	// 	if (r == 1)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
	// 	}
	// 	else if (r == 2)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
	// 	}
	// 	else if (r == 3)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
	// 	}
	// 	else if (r == 4)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
	// 	}
	// 	else if (r == 5)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
	// 	}
	// 	else if (r == 6)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));
	// 	}

	// 	this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));

	// 	if (this.Math.rand(1, 100) <= 35)
	// 	{
	// 		r = this.Math.rand(1, 2);

	// 		if (r == 1)
	// 		{
	// 			this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
	// 		}
	// 		else if (r == 2)
	// 		{
	// 			this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
	// 		}
	// 	}

	// 	this.m.Items.equip(this.Const.World.Common.pickArmor([
	// 		[1, "leather_tunic"],
	// 		[1, "padded_leather"],
	// 		[1, "padded_surcoat"],
	// 		[1, "leather_lamellar"]
	// 	]));

	// 	if (this.Math.rand(1, 100) <= 75)
	// 	{
	// 		local item = this.Const.World.Common.pickHelmet([
	// 			[1, "hood"],
	// 			[1, "full_aketon_cap"],
	// 			[1, "headscarf"],
	// 			[1, "nasal_helmet"],
	// 			[1, "rondel_helm"],
	// 			[1, "scale_helm"],
	// 			[1, "padded_nasal_helmet"]
	// 		])
	// 		if (item != null)
	// 		{
	// 			this.m.Items.equip(item);
	// 		}
	// 	}
	// }

});

