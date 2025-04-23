this.legend_peasant_witchhunter <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantWitchHunter;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantWitchHunter.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantWitchHunter);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
		::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecCrossbow);
		this.getSprite("socket").setBrush("bust_base_militia");

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.getItems().equip(this.new("scripts/items/weapons/light_crossbow"));
		this.getItems().equip(this.new("scripts/items/ammo/quiver_of_bolts"));

		this.getItems().addToBag(::Const.World.Common.pickItem([
			[1, "weapons/shortsword"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.thick_tunic]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.getItems().equip(::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.witchhunter_hat],
				[6, ::Legends.Helmet.Standard.hood]
			]))
		}
	}

});

