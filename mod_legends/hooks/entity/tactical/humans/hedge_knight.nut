::mods_hookExactClass("entity/tactical/humans/hedge_knight", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_hedge_knight_less_flanking_less_zoc");
		this.m.AIAgent.setActor(this);
		this.m.OnDeathLootTable.extend([
			[1.5, "scripts/items/misc/legend_masterwork_fabric"],
			[1.0, "scripts/items/misc/legend_masterwork_metal"],
			[0.5, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local weapons = [
				"weapons/greatsword",
				"weapons/greataxe",
				"weapons/two_handed_hammer",
				"weapons/two_handed_flanged_mace",	// Moved all weapons into one array because Legends requires all DLCs anyways
				"weapons/two_handed_flail",
				"weapons/bardiche"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[1, ::Legends.Armor.Standard.coat_of_plates],
				[1, ::Legends.Armor.Standard.coat_of_scales],
				[1, ::Legends.Armor.Standard.heavy_lamellar_armor]
			];

			local helmet = [
				[30, ::Legends.Helmet.Standard.full_helm],
				[10, ::Legends.Helmet.Standard.closed_flat_top_with_mail],
				[5, ::Legends.Helmet.Standard.legend_helm_breathed],
				[5, ::Legends.Helmet.Standard.legend_helm_full],
				[5, ::Legends.Helmet.Standard.legend_helm_bearded],
				[5, ::Legends.Helmet.Standard.legend_helm_point],
				[5, ::Legends.Helmet.Standard.legend_helm_snub],
				[5, ::Legends.Helmet.Standard.legend_helm_short],
				[5, ::Legends.Helmet.Standard.legend_helm_curved],
				//[2, ::Legends.Helmet.Standard.wallace_sallet],
				//[2, ::Legends.Helmet.Standard.deep_sallet],
				//[2, ::Legends.Helmet.Standard.italo_norman_helm],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_helm_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_armet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_armet_02],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_02],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_03],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_02],
				//[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_03]
			];

			local outfits = [
				[1, ::Legends.Outfit.brown_hedgeknight_outfit_00]
			];

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item)
			}
			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[1, ::Legends.Armor.Standard.coat_of_plates],
				[1, ::Legends.Armor.Standard.coat_of_scales],
				//[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
				[1, ::Legends.Armor.Standard.heavy_lamellar_armor],
				[1, ::Legends.Armor.Standard.brown_hedgeknight_armor]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				armor
			));
		}



		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[30, ::Legends.Helmet.Standard.full_helm],
				[10, ::Legends.Helmet.Standard.closed_flat_top_with_mail],
				[5, ::Legends.Helmet.Standard.legend_helm_breathed],
				[5, ::Legends.Helmet.Standard.legend_helm_full],
				[5, ::Legends.Helmet.Standard.legend_helm_bearded],
				[5, ::Legends.Helmet.Standard.legend_helm_point],
				[5, ::Legends.Helmet.Standard.legend_helm_snub],
				[5, ::Legends.Helmet.Standard.legend_helm_short],
				[5, ::Legends.Helmet.Standard.legend_helm_curved],
				//[2, ::Legends.Helmet.Standard.wallace_sallet],
				//[2, ::Legends.Helmet.Standard.deep_sallet],
				//[2, ::Legends.Helmet.Standard.italo_norman_helm],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_helm_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_armet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_armet_02],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_02],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_03],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_02],
				//[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_03],
				//[2, ::Legends.Helmet.Standard.brown_hedgeknight_helmet]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(
				helmet
			));
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_greataxe",
			"weapons/named/named_greatsword",
			"weapons/named/named_bardiche",
			"weapons/named/named_two_handed_hammer",
			"weapons/named/named_two_handed_mace",
			"weapons/named/named_two_handed_flail"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Named.brown_coat_of_plates_armor],
				[1, ::Legends.Armor.Named.golden_scale_armor],
				[1, ::Legends.Armor.Named.green_coat_of_plates_armor]
			]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, ::Legends.Helmet.Named.bascinet_named],
				[3, ::Legends.Helmet.Named.kettle_helm_named],
				[3, ::Legends.Helmet.Named.deep_sallet_named],
				[3, ::Legends.Helmet.Named.barbute_named],
				[3, ::Legends.Helmet.Named.italo_norman_helm_named],
				[3, ::Legends.Helmet.Named.wallace_sallet_named],
				[3, ::Legends.Helmet.Named.named_helm_with_lion_pelt]
			]));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}
});
