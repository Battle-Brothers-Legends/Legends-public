::mods_hookExactClass("entity/tactical/humans/noble_footman", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
			::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
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

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}

		shield.setFaction(banner);
		this.m.Items.equip(shield);

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.seedmaster_noble_armor],
			[1, ::Legends.Armor.Standard.citreneking_noble_armor]
		]));
		// this.m.Items.equip(this.Const.World.Common.pickArmor([
		// 	[1, ::Legends.Armor.Standard.mail_hauberk, 28],
		// 	[1, ::Legends.Armor.Standard.mail_shirt],
		// 	[1, ::Legends.Armor.Standard.basic_mail_shirt]
		// ]));

		local helmet;
		if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[5, ::Legends.Helmet.Standard.kettle_hat],
					[5, ::Legends.Helmet.Standard.rondel_helm],
					[4, ::Legends.Helmet.Standard.scale_helm],
					[4, ::Legends.Helmet.Standard.kettle_hat_with_mail],
					[3, ::Legends.Helmet.Standard.padded_kettle_hat],
					[3, ::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01],
					[2, ::Legends.Helmet.Standard.mail_coif],
					[1, ::Legends.Helmet.Standard.heavy_noble_house_helmet_00]
				])
			}
		else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[5, ::Legends.Helmet.Standard.rondel_helm],
					[4, ::Legends.Helmet.Standard.padded_flat_top_helmet],
					[3, ::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01],
					[3, ::Legends.Helmet.Standard.mail_coif],
					[2, ::Legends.Helmet.Standard.flat_top_helmet],
					[2, ::Legends.Helmet.Standard.scale_helm],
					[1, ::Legends.Helmet.Standard.flat_top_with_mail],
					[1, ::Legends.Helmet.Standard.heavy_noble_house_helmet_00]
				])
			}
		else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[5, ::Legends.Helmet.Standard.nasal_helmet],
					[5, ::Legends.Helmet.Standard.padded_nasal_helmet],
					[4, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
					[3, ::Legends.Helmet.Standard.mail_coif],
					[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01],
					[1, ::Legends.Helmet.Standard.heavy_noble_house_helmet_00]
				])
			}

		if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.m.Items.equip(helmet);
			}
	}
});
