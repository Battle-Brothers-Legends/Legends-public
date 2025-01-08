::mods_hookExactClass("entity/tactical/humans/hedge_knight", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_hedge_knight_less_flanking_less_zoc");
		this.m.AIAgent.setActor(this);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
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
				[1, "coat_of_plates"],
				[1, "coat_of_scales"],
				[1, "heavy_lamellar_armor"]
			]

			local helmet = [
				[30, "full_helm"],
				[10, "closed_flat_top_with_mail"],
				[5, "legend_helm_breathed"],
				[5, "legend_helm_full"],
				[5, "legend_helm_bearded"],
				[5, "legend_helm_point"],
				[5, "legend_helm_snub"],
				[5, "legend_helm_short"],
				[5, "legend_helm_curved"],
				//[2, "wallace_sallet"],
				//[2, "deep_sallet"],
				//[2, "italo_norman_helm"],
				[2, "legend_enclave_vanilla_great_helm_01"],
				[2, "legend_enclave_vanilla_armet_01"],
				[2, "legend_enclave_vanilla_armet_02"],
				[2, "legend_enclave_vanilla_great_bascinet_01"],
				[2, "legend_enclave_vanilla_great_bascinet_02"],
				[2, "legend_enclave_vanilla_great_bascinet_03"],
				[2, "legend_enclave_vanilla_kettle_sallet_01"],
				[2, "legend_enclave_vanilla_kettle_sallet_02"],
				//[2, "legend_enclave_vanilla_kettle_sallet_03"]
			]

			local outfits = [
				[1, "brown_hedgeknight_outfit_00"]
			]

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item)
			}
			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[1, "coat_of_plates"],
				[1, "coat_of_scales"],
				//[1, "reinforced_mail_hauberk"],
				[1, "heavy_lamellar_armor"],
				[1, "brown_hedgeknight_armor"]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				armor
			));
		}



		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[30, "full_helm"],
				[10, "closed_flat_top_with_mail"],
				[5, "legend_helm_breathed"],
				[5, "legend_helm_full"],
				[5, "legend_helm_bearded"],
				[5, "legend_helm_point"],
				[5, "legend_helm_snub"],
				[5, "legend_helm_short"],
				[5, "legend_helm_curved"],
				//[2, "wallace_sallet"],
				//[2, "deep_sallet"],
				//[2, "italo_norman_helm"],
				[2, "legend_enclave_vanilla_great_helm_01"],
				[2, "legend_enclave_vanilla_armet_01"],
				[2, "legend_enclave_vanilla_armet_02"],
				[2, "legend_enclave_vanilla_great_bascinet_01"],
				[2, "legend_enclave_vanilla_great_bascinet_02"],
				[2, "legend_enclave_vanilla_great_bascinet_03"],
				[2, "legend_enclave_vanilla_kettle_sallet_01"],
				[2, "legend_enclave_vanilla_kettle_sallet_02"],
				//[2, "legend_enclave_vanilla_kettle_sallet_03"],
				//[2, "brown_hedgeknight_helmet"]
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
				[1, "named/brown_coat_of_plates_armor"],
				[1, "named/golden_scale_armor"],
				[1, "named/green_coat_of_plates_armor"]
			]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, "named/bascinet_named"],
				[3, "named/kettle_helm_named"],
				[3, "named/deep_sallet_named"],
				[3, "named/barbute_named"],
				[3, "named/italo_norman_helm_named"],
				[3, "named/wallace_sallet_named"],
				[3, "named/named_helm_with_lion_pelt"]
			]));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		return true;
	}
});
