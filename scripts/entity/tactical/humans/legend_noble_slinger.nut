this.legend_noble_slinger <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendSlinger;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendSlinger.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendSlinger);
		b.TargetAttractionMult = 1.1;
		b.IsSpecializedInCrossbows = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShepherd);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMasterySlings);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 80)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		this.m.Items.equip(this.new("scripts/items/weapons/legend_northern_sling"));

		this.getItems().addToBag(::Const.World.Common.pickItem([
			[1, "weapons/dagger"],
			[1, "weapons/knife"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.gambeson]
		]));
		local helmet = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.full_aketon_cap],
			[1, ::Legends.Helmet.Standard.headscarf],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.None]
		]);

		if (helmet != null)
		{
			if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
			this.m.Items.equip(helmet);
		}
	}

});

