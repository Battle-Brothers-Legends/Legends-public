this.legend_peasant_armed_infected <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Peasant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Peasant.XP;
		this.human.create();
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
		this.human.onInit();
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

		this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendTrueForm);


		// if (this.Math.rand(1, 100) <= 80)
		// {
		// 	::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendControlInstincts);
		// }
		// if (this.Math.rand(1, 100) <= 60)
		// {
		// 	::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSurpressUrges);
		// }
		// if (this.Math.rand(1, 100) <= 40)
		// {
		// 	::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMasterAnger);
		// }

		if (this.Math.rand(1, 100) <= 20)
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.FortifiedMind);
		}

		if (this.Math.rand(1, 100) <= 10)
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.FortifiedMind);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.RallyTheTroops);
		}

		this.m.Skills.add(this.new("scripts/skills/traits/weasel_trait"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBackToBasics);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Nimble);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);

			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 14);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
		}

		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
		this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		local r;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
		this.m.Items.equip(this.new("scripts/items/weapons/legend_sling"));
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, "sackcloth"],
			[1, "thick_tunic"],
			[2, "apron"],
			[1, "tattered_sackcloth"],
			[2, "linen_tunic"]
		]));


		if (this.Math.rand(1, 100) <= 50)
		{
			local helmet = [
				[1, "hood"],
				[1, "headscarf"],
				[1, "straw_hat"],
				[1, "feathered_hat"]
			]
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet))
		}
	}

});

