this.legend_noble_fencer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendFencer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendFencer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_fencer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendFencer);
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
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 2;
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
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
			[1, "weapons/legend_estoc"],
			[1, "weapons/fencing_sword"],
		], "scripts/items/"));

		this.getItems().equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.seedmaster_noble_armor],
			[1, ::Legends.Armor.Standard.citreneking_noble_armor],
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.kettle_hat],
					[1, ::Legends.Helmet.Standard.padded_kettle_hat],
					[1, ::Legends.Helmet.Standard.kettle_hat_with_mail],
					[1, ::Legends.Helmet.Standard.mail_coif]
				])
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.flat_top_helmet],
					[1, ::Legends.Helmet.Standard.padded_flat_top_helmet],
					[1, ::Legends.Helmet.Standard.flat_top_with_mail],
					[1, ::Legends.Helmet.Standard.mail_coif]
				])
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.nasal_helmet],
					[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
					[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
					[1, ::Legends.Helmet.Standard.mail_coif]
				])
			}

			if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.getItems().equip(helmet);
			}
		}
		else
		{
			this.getItems().equip(this.Const.World.Common.pickHelmet([
				[2, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.full_aketon_cap],
				[1, ::Legends.Helmet.Standard.headscarf],
				[1, ::Legends.Helmet.None]
			]))
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_fencing_sword",
			"weapons/named/legend_named_estoc"
		];

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/named_noble_mail_armor",
			"armor/named/blue_studded_mail_armor"
		];

		if (this.Math.rand(1, 100) <= 70)
		{
			this.getItems().equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.getItems().equip(this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(
					armor
				)
			));
		}

		this.m.BaseProperties.DamageDirectMult *= 1.25;
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}

});

