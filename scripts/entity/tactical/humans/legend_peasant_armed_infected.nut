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
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueForm);


		// if (this.Math.rand(1, 100) <= 80)
		// {
		// 	::Legends.Perks.grant(this, ::Legends.Perk.LegendControlInstincts);
		// }
		// if (this.Math.rand(1, 100) <= 60)
		// {
		// 	::Legends.Perks.grant(this, ::Legends.Perk.LegendSurpressUrges);
		// }
		// if (this.Math.rand(1, 100) <= 40)
		// {
		// 	::Legends.Perks.grant(this, ::Legends.Perk.LegendMasterAnger);
		// }

		if (this.Math.rand(1, 100) <= 20)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.FortifiedMind);
		}

		if (this.Math.rand(1, 100) <= 10)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.FortifiedMind);
			::Legends.Perks.grant(this, ::Legends.Perk.RallyTheTroops);
		}

		::Legends.Traits.grant(this, ::Legends.Trait.Weasel);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/knife"],
			[1, "weapons/pitchfork"],
			[1, "weapons/wooden_stick"],
			[1, "weapons/pickaxe"],
			[1, "weapons/legend_wooden_pitchfork"],
			[1, "weapons/legend_wooden_spear"],
			[1, "weapons/legend_shovel"],
			[1, "weapons/legend_hoe"],
			[1, "weapons/legend_saw"],
			[1, "weapons/legend_hammer"],
			[1, "weapons/legend_scythe"],
			[1, "weapons/legend_sickle"],
			[1, "weapons/legend_chain"],
			[1, "weapons/legend_shiv"],
			[5, "weapons/legend_dilapitated_sling"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "shields/buckler_shield"],
			[3, null],
		], "scripts/items/"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[2, ::Legends.Armor.Standard.apron],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[2, ::Legends.Armor.Standard.linen_tunic]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			local helmet = [
				[1, ::Legends.Helmet.Standard.hood],
				[1, ::Legends.Helmet.Standard.headscarf],
				[1, ::Legends.Helmet.Standard.straw_hat],
				[1, ::Legends.Helmet.Standard.feathered_hat]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet))
		}
	}

});

