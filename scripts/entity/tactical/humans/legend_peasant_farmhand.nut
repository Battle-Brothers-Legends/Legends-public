this.legend_peasant_farmhand <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantFarmhand;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantFarmhand.XP;
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
		b.setValues(this.Const.Tactical.Actor.LegendPeasantFarmhand);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistFarmhand);
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecPolearm);
		this.getSprite("socket").setBrush("bust_base_militia");
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
			::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
			::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
			::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/pitchfork"],
			[5, "weapons/legend_wooden_pitchfork"],
		], "scripts/items/"));

		this.getItems().equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[8, ::Legends.Armor.Standard.linen_tunic]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.getItems().equip(this.Const.World.Common.pickHelmet([
				[3, ::Legends.Helmet.Standard.straw_hat],
				[1, ::Legends.Helmet.Standard.hood]
			]))
		}
	}

});

