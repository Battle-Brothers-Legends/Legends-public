this.legend_peasant_minstrel <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendPeasantMinstrel;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendPeasantMinstrel.XP;
		this.human.create();
		this.m.Bodies = ::Const.Bodies.AllMale;
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/legend_minstrel_agent");
		this.m.AIAgent.setActor(this);
		if (this.randomizeHumanGender() == 1) 
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMinstrel);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistMusician);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendEntice);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendDaze);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMinnesanger);

		this.getSprite("socket").setBrush("bust_base_militia");
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Taunt);
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMeistersanger);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/named/legend_named_lute"],
			[25, "weapons/legend_drum"],
			[74, "weapons/lute"],
		], "scripts/items/"));

		this.getItems().addToBag(::Const.World.Common.pickItem([
			[1, "tools/throwing_net"],
			[3, null],
		], "scripts/items/"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[9, ::Legends.Armor.Standard.linen_tunic]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, ::Legends.Helmet.Standard.feathered_hat],
				[1, ::Legends.Helmet.Standard.hood]
			]))
		}
	}

});

