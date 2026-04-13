::mods_hookExactClass("entity/tactical/humans/noble_greatsword", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecSword);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackswing);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 3;

		if (!::FU.InScenario())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 50)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		local weapons = [
			"weapons/legend_zweihander",
			"weapons/legend_zweihander",
			"weapons/legend_zweihander",
			"weapons/greatsword",
			"weapons/greatsword",
			"weapons/legend_zweihander"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));



		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Standard.mail_hauberk, 28],
			[1, ::Legends.Armor.Standard.scale_armor],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[2, ::Legends.Armor.Standard.footman_armor],
			[1, ::Legends.Armor.Standard.seedmaster_noble_armor],
			[1, ::Legends.Armor.Standard.citreneking_noble_armor]
		]));


		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			//[1, ::Legends.Helmet.Standard.greatsword_hat],  Only 70 durability
			[1, ::Legends.Helmet.Standard.rondel_helm],
			[1, ::Legends.Helmet.Standard.scale_helm],
			[1, ::Legends.Helmet.Standard.greatsword_faction_helm, banner],
			[1, ::Legends.Helmet.Standard.cervelliere],
			[5, ::Legends.Helmet.Standard.heavy_noble_house_helmet_00]
		]));
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_greatsword",
			"weapons/named/legend_named_zweihander",
			"weapons/named/legend_named_flamberge"
		];

		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, ::Legends.Armor.Named.black_and_gold_armor],
				[2, ::Legends.Armor.Named.blue_studded_mail_armor],
				[2, ::Legends.Armor.Named.golden_scale_armor],
				[1, ::Legends.Armor.Named.heraldic_mail_armor],
				[1, ::Legends.Armor.Named.brown_coat_of_plates_armor],
			]));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		return true;
	}
});
