this.legend_peasant_squire <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendPeasantSquire;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendPeasantSquire.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.randomizeEnemyGender() == 1) {
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendPeasantSquire);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		this.getSprite("socket").setBrush("bust_base_militia");

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		if (::Math.rand(1, 100) <= 66) {
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "weapons/shortsword"],
			], "scripts/items/"));
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "shields/wooden_shield"],
			], "scripts/items/"));
		}
		else
		{
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "weapons/legend_ranged_wooden_flail"],
			], "scripts/items/"));
		}

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.worn_mail_shirt]
		]));

		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.padded_nasal_helmet]
		]));
	}

});

