this.legend_peasant_monk <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantMonk;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantMonk.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_standard_bearer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMonk);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecStaffSkill);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecStaffStun);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPushTheAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.RallyTheTroops);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMasteryStaves);
		this.getSprite("socket").setBrush("bust_base_militia");
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendInspire);
			::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
			::Legends.Perks.grant(this, ::Legends.Perk.FortifiedMind);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 4);

		if (r <= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		}

		local armor = [
			[1, "sackcloth"],
			[1, "thick_tunic"],
			[1, "apron"],
			[1, "tattered_sackcloth"],
			[6, "linen_tunic"]
		];

		local helmet = [
			[1, "straw_hat"],
			[2, "hood"],
			[1, "headscarf"]
		];

		local outfits = [
			[1, "brown_monk_outfit_00"]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item)
		}
	}

});

