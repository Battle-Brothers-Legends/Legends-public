this.legend_peasant_woodsman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantWoodsman;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantWoodsman.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantWoodsman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistWoodsman);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecAxe);
		this.getSprite("socket").setBrush("bust_base_militia");

		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);
			::Legends.Perks.grant(this, ::Legends.Perk.Recover);
			::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[8, ::Legends.Armor.Standard.linen_tunic]
		]));
		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, ::Legends.Helmet.Standard.straw_hat],
				[1, ::Legends.Helmet.Standard.hood]
			]))
		}
	}

});

