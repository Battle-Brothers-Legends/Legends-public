this.legend_noble_man_at_arms <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendManAtArms;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendManAtArms.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendManAtArms);
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
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.BagsAndBelts);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBruiser);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendDeflect);
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

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/warhammer"],
			[1, "weapons/noble_sword"],
			[1, "weapons/three_headed_flail"],
			[1, "weapons/military_cleaver"],
			[1, "weapons/fighting_axe"],
			[1, "weapons/winged_mace"],
		], "scripts/items/"));

		local shield = this.new("scripts/items/shields/faction_kite_shield");
		shield.setFaction(banner);
		this.m.Items.equip(shield);

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.man_at_arms_noble_armor]
		]));
		// this.m.Items.equip(this.Const.World.Common.pickArmor([
		// 	[1, "mail_hauberk", 28],
		// 	[1, ::Legends.Armor.Standard.mail_shirt],
		// 	[1, ::Legends.Armor.Standard.basic_mail_shirt]
		// ]));

		local helmet = this.Const.World.Common.pickHelmet([
			[3, ::Legends.Helmet.Standard.stag_helm],
			[3, ::Legends.Helmet.Standard.swan_helm],
			[1, ::Legends.Helmet.Standard.heavy_noble_house_helmet_00]
		]);

		if (helmet != null)
		{
			if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
			this.m.Items.equip(helmet);
		}
	}

});
