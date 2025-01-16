this.legend_wildman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Wildman;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Wildman.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = this.Const.Faces.WildFemale;
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Wildman);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.BeardChance = 80;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_beasts");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		local body = this.getSprite("body");
		local tattoo = this.Math.rand(0, 1);
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");
		tattoo_body.setBrush((tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(tattoo ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendUberNimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecFists);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendKick);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendGrapple);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(0, 7);

		if (r == 0)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_wraps"]
		]));
	}

});

