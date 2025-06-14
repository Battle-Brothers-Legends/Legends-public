::mods_hookExactClass("entity/tactical/humans/noble_greatsword", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecSword);

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

		if (!this.Tactical.State.isScenarioMode())
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

		r = this.Math.rand(1, 1);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}



		this.m.Items.equip(this.Const.World.Common.pickArmor([
			// [2, ::Legends.Armor.Standard.mail_hauberk, 28],
			// [1, ::Legends.Armor.Standard.scale_armor],
			// [1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			// [2, ::Legends.Armor.Standard.footman_armor],
			[2, ::Legends.Armor.Standard.seedmaster_noble_armor],
			[2, ::Legends.Armor.Standard.citreneking_noble_armor]
		]));


		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			//[1, ::Legends.Helmet.Standard.greatsword_hat],  Only 70 durability
			[1, ::Legends.Helmet.Standard.rondel_helm],
			[1, ::Legends.Helmet.Standard.scale_helm],
			[1, ::Legends.Helmet.Standard.greatsword_faction_helm, banner],
			[1, ::Legends.Helmet.Standard.wallace_sallet],
			[5, ::Legends.Helmet.Standard.heavy_noble_house_helmet_00]
		]));
	}
});
