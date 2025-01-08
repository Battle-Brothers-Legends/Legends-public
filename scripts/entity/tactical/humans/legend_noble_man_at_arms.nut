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
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Brawny);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.FastAdaption);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Footwork);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SteelBrow);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendFeint);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BagsAndBelts);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShieldSkill);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShieldPush);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSmashingShields);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBackToBasics);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldBash);
		if(::Legends.isLegendaryDifficulty())
			{

			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendFullForce);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBruiser);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendDeflect);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
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

		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/noble_sword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/three_headed_flail"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
		}

		local shield = this.new("scripts/items/shields/faction_kite_shield");


		shield.setFaction(banner);
		this.m.Items.equip(shield);

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "man_at_arms_noble_armor"]
		]));
		// this.m.Items.equip(this.Const.World.Common.pickArmor([
		// 	[1, "mail_hauberk", 28],
		// 	[1, "mail_shirt"],
		// 	[1, "basic_mail_shirt"]
		// ]));

		local helmet;

		helmet = this.Const.World.Common.pickHelmet([
			[3, "stag_helm"],
			[3, "swan_helm"],
			[1, "heavy_noble_house_helmet_00"]
		]);


		if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.m.Items.equip(helmet);
			}
	}

});
