::mods_hookExactClass("entity/tactical/humans/mercenary", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendRebound);
			::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendClarity);
			::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
			::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/billhook",
				"weapons/pike",
				"weapons/warbrand",
				"weapons/longsword",
				"weapons/legend_longsword",
				"weapons/hand_axe",
				"weapons/fighting_spear",
				"weapons/legend_battle_glaive",
				"weapons/morning_star",
				"weapons/falchion",
				"weapons/arming_sword",
				"weapons/flail",
				"weapons/military_pick",
				"weapons/legend_ranged_flail",
				"weapons/polehammer",
				"weapons/three_headed_flail",
				"weapons/bardiche",
				"weapons/scimitar"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(0, 2);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 60)
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
			}
		}

		local armor = [
			[1, ::Legends.Armor.Standard.sellsword_armor],
			// [1, ::Legends.Armor.Standard.padded_leather],
			// [1, ::Legends.Armor.Standard.patched_mail_shirt],
			// [1, ::Legends.Armor.Standard.basic_mail_shirt],
			// [1, ::Legends.Armor.Standard.mail_shirt],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.mail_hauberk],
			[1, ::Legends.Armor.Standard.traze_northern_mercenary_armor],
			[1, ::Legends.Armor.Standard.northern_mercenary_armor_00],
			[1, ::Legends.Armor.Standard.northern_mercenary_armor_01],
			[1, ::Legends.Armor.Standard.northern_mercenary_armor_02],
			[1, ::Legends.Armor.Standard.lamellar_harness],
			[1, ::Legends.Armor.Standard.footman_armor],
			[1, ::Legends.Armor.Standard.light_scale_armor],
			[1, ::Legends.Armor.Standard.leather_scale_armor]
		];

		local helm = [
			[1, ::Legends.Helmet.None],
			[5, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
			[5, ::Legends.Helmet.Standard.nasal_helmet],
			[5, ::Legends.Helmet.Standard.mail_coif],
			[5, ::Legends.Helmet.Standard.reinforced_mail_coif],
			[5, ::Legends.Helmet.Standard.headscarf],
			[5, ::Legends.Helmet.Standard.kettle_hat],
			[5, ::Legends.Helmet.Standard.kettle_hat_with_mail],
			[5, ::Legends.Helmet.Standard.rondel_helm],
			[5, ::Legends.Helmet.Standard.traze_northern_mercenary_cap],
			[5, ::Legends.Helmet.Standard.deep_sallet],
			[5, ::Legends.Helmet.Standard.scale_helm],
			[5, ::Legends.Helmet.Standard.flat_top_helmet],
			[5, ::Legends.Helmet.Standard.flat_top_with_mail],
			[5, ::Legends.Helmet.Standard.closed_flat_top_helmet],
			[5, ::Legends.Helmet.Standard.closed_mail_coif],
			[5, ::Legends.Helmet.Standard.bascinet_with_mail],
			[5, ::Legends.Helmet.Standard.nordic_helmet],
			[5, ::Legends.Helmet.Standard.nordic_helmet_with_closed_mail],
			[5, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_02],
			[5, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_03],
			[5, ::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01],
			[5, ::Legends.Helmet.Standard.steppe_helmet_with_mail],
			[5, ::Legends.Helmet.Standard.barbute_helmet]
		];

		helm.push([5, ::Legends.Helmet.Standard.theamson_barbute_helmet]);

		local outfits = [
			[1, ::Legends.Outfit.northern_mercenary_outfit_00],
			[1, ::Legends.Outfit.northern_mercenary_outfit_01],
			[1, ::Legends.Outfit.northern_mercenary_outfit_02],
			[1, ::Legends.Outfit.traze_northern_mercenary_outfit_00],
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helm) )
		{
			this.m.Items.equip(item)
		}
	}
});
