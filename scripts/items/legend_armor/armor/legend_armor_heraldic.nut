this.legend_armor_heraldic <- this.inherit("scripts/items/legend_armor/cloth/legend_gambeson", {
	m = {},
	function create()
	{
		this.legend_gambeson.create();
		this.m.ID = "legend.armor.body.gambeson_rare_color.cloth";
		this.m.Variants = [
			2,
			4,
			5,
			7,
			9,
			11,
			12,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			29,
			30,
			31,
			32,
			35,
			36,
			37,
			38,
			39,
			42,
			43,
			44,
			45,
			46,
			48,
			49,
			50,
			51,
			52,
			54,
			55,
			56,
			57,
			58,
			60,
			61,
			62,
			63,
			64
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 850;
		this.m.Condition = 65;
		this.m.ConditionMax = 65;
		this.m.StaminaModifier = -5;
	}

	function setupArmor( _variant ) {
		local gambesons = [1];
		switch (_variant)
		{
			case 1:
				gambesons = [3,6,15,16,17,41,53];
				break;
			case 2:
				gambesons = [15,33,53];
				break;
			case 3:
				gambesons = [1,2,8,13,34,35,36,37,38,39,59,60,61,62,62,64];
				break;
			case 4:
				gambesons = [6,16,17,41];
				break;
			case 5:
				gambesons = [5,9,23,24,25,26,27,28];
				break;
			case 6:
				gambesons = [7,8,29,30,31,32,33];
				break;
			case 7:
				gambesons = [11];
				break;
			case 8:
				gambesons = [1,34,59];
				break;
			case 9:
				gambesons = [6,10,12];
				break;
			case 10:
				gambesons = [4,5,10];
				break
		}

		this.setVariant(this.Math.rand(0, gambesons.len() - 1));
		local chains = [
			[0, ""],
			[0, "chain/legend_armor_mail_shirt"],
			[0, "chain/legend_armor_mail_shirt_simple"],
			[0, "chain/legend_armor_rusty_mail_shirt"],
			[0, "chain/legend_armor_ancient_double_mail"],
			[0, "chain/legend_armor_ancient_mail"],
			[1, "chain/legend_armor_basic_mail"],
			[1, "chain/legend_armor_hauberk"],
			[1, "chain/legend_armor_hauberk_full"],
			[0, "chain/legend_armor_hauberk_sleevless"],
			[0, "chain/legend_armor_reinforced_mail"],
			[0, "chain/legend_armor_reinforced_mail_shirt"],
			[0, "chain/legend_armor_reinforced_rotten_mail_shirt"],
			[0, "chain/legend_armor_reinforced_worn_mail"],
			[0, "chain/legend_armor_reinforced_worn_mail_shirt"],
			[0, "chain/legend_armor_short_mail"]
		];

		local chain = this.Const.World.Common.pickLegendArmor(chains);
		if (chain != null)
		{
			this.setUpgrade(chain);
		}

		local plates = [
			[0, ""],
			[1, "plate/legend_armor_leather_brigandine"],
			[1, "plate/legend_armor_leather_brigandine_hardened"],
			[0, "plate/legend_armor_leather_brigandine_hardened_full"],
			[0, "plate/legend_armor_leather_jacket"],
			[0, "plate/legend_armor_leather_jacket_simple"],
			[0, "plate/legend_armor_leather_lamellar"],
			[0, "plate/legend_armor_leather_lamellar_harness_heavy"],
			[0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
			[0, "plate/legend_armor_leather_lamellar_heavy"],
			[0, "plate/legend_armor_leather_lamellar_reinforced"],
			[0, "plate/legend_armor_leather_noble"],
			[0, "plate/legend_armor_leather_padded"],
			[0, "plate/legend_armor_leather_riveted"],
			[0, "plate/legend_armor_leather_riveted_light"],
			[0, "plate/legend_armor_leather_scale"],
			[0, "plate/legend_armor_plate_ancient_chest"],
			[0, "plate/legend_armor_plate_ancient_harness"],
			[0, "plate/legend_armor_plate_ancient_mail"],
			[0, "plate/legend_armor_plate_ancient_scale"],
			[0, "plate/legend_armor_plate_ancient_scale_coat"],
			[0, "plate/legend_armor_plate_ancient_scale_harness"],
			[0, "plate/legend_armor_plate_chest"],
			[0, "plate/legend_armor_plate_chest_rotten"],
			[0, "plate/legend_armor_plate_cuirass"],
			[0, "plate/legend_armor_plate_full"],
			[0, "plate/legend_armor_scale"],
			[0, "plate/legend_armor_scale_coat"],
			[0, "plate/legend_armor_scale_coat_rotten"],
			[0, "plate/legend_armor_scale_shirt"]
		];
		local plate = this.Const.World.Common.pickLegendArmor(plates);
		if (plate != null)
		{
			this.setUpgrade(plate);
		}
		local tabard = this.new("scripts/items/legend_armor/tabard/legend_noble_tabard");
		tabard.setVariant(_variant);
		this.setUpgrade(tabard);
	}

});

