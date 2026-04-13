::Legends.Armor.Standard <- {};

::Legends.Armor.Standard.apron <- {
	ID = "apron", // 35-60 -4-7 60-135
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_apron"] // 35 -4 60
		],
		Chain = [
		],
		Plate = [
			[12, ""],
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
			[1, "plate/legend_armor_leather_jacket_simple"] // 15 -2 30
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.apron);

::Legends.Armor.Standard.basic_mail_shirt <- {
	ID = "basic_mail_shirt", // 45-125 -4-15 275-665
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_wrap"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_thin"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_deep"], // 20 -1 25
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"] // 25 -3 250
		],
		Plate = [
		],
		Cloak = [
			[5, ""],
			[1, "cloak/legend_armor_tabbed_hood"], // 10 -1 40
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.basic_mail_shirt);

::Legends.Armor.Standard.blotched_gambeson <- {
	ID = "blotched_gambeson", // 65-70 -8-9 250-300
	Script = "",
	Sets = [{
		Cloth = [
			[10, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.blotched_gambeson);

::Legends.Armor.Standard.butcher_apron <- {
	ID = "butcher_apron", // 30-55 -3-6 50-125
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_apron_butcher"], // 30 -3 50
		],
		Chain = [
		],
		Plate = [
			[12, ""],
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
			[1, "plate/legend_armor_leather_jacket_simple"] // 15 -2 30
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.butcher_apron);

::Legends.Armor.Standard.coat_of_plates <- {
	ID = "coat_of_plates", // 285-355 -37-50 4650-7100
	Script = "",
	Sets = [{
		Cloth = [//60
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[5, "cloth/legend_armor_quilted_aketon"] // 55 -6 150
			// [5, "cloth/legend_armor_tunic"]
		],
		Chain = [//66.25 if [2,""] removed : 44 with : 80 with commented things
			// [2, ""],
			//[1, "chain/legend_armor_mail_shirt"], //50
			// [1, "chain/legend_armor_mail_shirt_simple"], //25
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"] // 80 -10 1000
		],
		Plate = [//157 avg
			//[1, "plate/legend_armor_plate_chest"], //125
			[1, "plate/legend_armor_plate_cuirass"], // 150 -21 3500
			[1, "plate/legend_armor_plate_full"], // 160 -22 4500
			[3, "plate/legend_armor_plate_full_greaves"], // 170 -26 5000
		],
		Cloak = [
			[20, ""],
			[1, "cloak/legend_armor_cloak"] // 10 -1 100
		],
		Tabard = [

		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.coat_of_plates);

::Legends.Armor.Standard.coat_of_scales <- {
	ID = "coat_of_scales", // 190-310 -22-39 2275-4600
	Script = "",
	Sets = [{
		Cloth = [//60
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"] // 55 -6 150
			// [1, "cloth/legend_armor_tunic"] //20
		],
		Chain = [//66.25 if [2,""] removed : 44 with : 80 with commented things
			// [2, ""], //0
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			// [1, "chain/legend_armor_mail_shirt_simple"], //25
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"] // 80 -10 1000
		]
		Plate = [//100
			[1, "plate/legend_armor_scale"], // 100 -12 2250
			[1, "plate/legend_armor_scale_coat"], // 120 -15 2500
			[1, "plate/legend_armor_scale_shirt"] // 85 -10 1750
		],
		Cloak = [//1
			[20, ""],
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_tabbed_hood"], // 10 -1 40
			[1, "cloak/legend_armor_decorative_hood"], // 15 -1 50
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.coat_of_scales);

::Legends.Armor.Standard.cultist_leather_robe <- {
	ID = "cultist_leather_robe", // 80 -9 275
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes"] // 25 -2 25
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_cult_armor"] // 55 -7 250
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.cultist_leather_robe);

::Legends.Armor.Standard.decayed_coat_of_plates <- {
	ID = "decayed_coat_of_plates", // 65-270 -9-41 605-2750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_sackcloth_patched"], // 15 -1 25
			[1, "cloth/legend_armor_sackcloth_tattered"], // 5 -0 5
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_robes"], // 25 -2 25
		],
		Chain = [
			[2, ""],
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105 -17 1250
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
		],
		Plate = [
			[1, "plate/legend_armor_rotten_scale_coat"], // 60 -9 600
			[1, "plate/legend_armor_rotten_plate_chest"], // 100 -16 1250
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.decayed_coat_of_plates);

::Legends.Armor.Standard.decayed_coat_of_scales <- {
	ID = "decayed_coat_of_scales", // 65-270 -9-41 605-2750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_sackcloth_patched"], // 15 -1 25
			[1, "cloth/legend_armor_sackcloth_tattered"], // 5 -0 5
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_robes"], // 25 -2 25
		],
		Chain = [
			[2, ""],
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105 -17 1250
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
		],
		Plate = [
			[1, "plate/legend_armor_rotten_scale_coat"], // 60 -9 600
			[1, "plate/legend_armor_rotten_plate_chest"], // 100 -16 1250
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.decayed_coat_of_scales);

::Legends.Armor.Standard.decayed_reinforced_mail_hauberk <- {
	ID = "decayed_reinforced_mail_hauberk", // 70-170 -7-25 355-2000
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_sackcloth_patched"], // 15 -1 25
			[1, "cloth/legend_armor_sackcloth_tattered"], // 5 -0 5
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_robes"], // 25 -2 25
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105 -17 1250
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_hauberk"] // 95 -11 1750
		],
		Plate = [],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.decayed_reinforced_mail_hauberk);

::Legends.Armor.Standard.ghost_armor <- {
	ID = "ghost_armor", // 215-340 -30-51 4675-6500
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]] // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105 -17 1250
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
		],
		Plate = [
			[1, "plate/legend_armor_plate_full"], // 160 -22 4500
			[10, "plate/legend_armor_plate_full_greaves"] // 170 -26 5000
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
			[1, "armor_upgrades/legend_pauldron_swan_upgrade"],
			[1, "armor_upgrades/legend_pauldron_upgrade"],
			[1, "armor_upgrades/legend_pauldron_stag_upgrade"],
			[1, "armor_upgrades/legend_pauldron_heavy_upgrade"],
			[1, "armor_upgrades/legend_pauldron_strong_upgrade"],
			[1, "armor_upgrades/legend_metal_pauldrons_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.ghost_armor);

::Legends.Armor.Standard.footman_armor <- {
	ID = "footman_armor", // 185-270 -23-35 1225-2800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
		],
		Plate = [
			[1, "plate/legend_armor_leather_riveted_light"], // 80 -11 700
		],
		Cloak = [
			[20, ""],
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_decorative_hood"], // 15 -1 50
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.footman_armor);

::Legends.Armor.Standard.gambeson <- {
	ID = "gambeson", // 65 -8 250
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.gambeson);

::Legends.Armor.Standard.heavy_lamellar_armor <- {
	ID = "heavy_lamellar_armor", // 160-340 -19-47 875-6750
	Script = "",
	Sets = [{
		Cloth = [//avg of 60
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"] // 55 -6 150
		],
		Chain = [//77avg
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [//125
			[1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130 -20 1750
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 55 -7 350
			[1, "plate/legend_armor_leather_lamellar_heavy"], // 165 -24 4750
			[1, "plate/legend_armor_leather_lamellar_reinforced"] // 150 -23 2500
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.heavy_lamellar_armor);

::Legends.Armor.Standard.heraldic_mail <- {
	ID = "heraldic_mail",
	Script = "scripts/items/legend_armor/armor/legend_armor_heraldic", //Nothing in vanilla seems to use this?
	Sets = [{
		Cloth = [
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.heraldic_mail);

::Legends.Armor.Standard.lamellar_harness <- {
	ID = "lamellar_harness", // 105-315 -12-44 400-5800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"] // 55 -6 150
		],
		Chain = [
			[1, ""],
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar"], // 50 -6 250
			[1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130 -20 1750
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 55 -7 350
			[1, "plate/legend_armor_leather_lamellar_heavy"], // 165 -24 4750
			[1, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lamellar_harness);

::Legends.Armor.Standard.leather_lamellar <- {
	ID = "leather_lamellar", // 130-265 -15-37 650-3125
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar"], // 50 -6 250
			[1, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.leather_lamellar);

::Legends.Armor.Standard.leather_scale_armor <- {
	ID = "leather_scale_armor", // 150-185 -18-23 1000-1225
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_leather_scale"], // 70 -9 600
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.leather_scale_armor);

::Legends.Armor.Standard.noble_scale_armor <- {
	ID = "noble_scale_armor", // 155-210 -16-23 2400-4625
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_noble_scale"], // 75 -7 2000
		],
		Cloak = [
			[20, ""],
			[1, "cloak/legend_armor_cloak_duke"], // 20 -2 2000
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.noble_scale_armor);

::Legends.Armor.Standard.leather_tunic <- {
	ID = "leather_tunic", // 35-65 -3-7 55-155
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
			[1, "plate/legend_armor_leather_jacket_simple"], // 15 -2 30
		],
		Cloak = [
			[20, ""],
			[1, "cloak/legend_armor_tabbed_hood"], // 10 -1 40
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.leather_tunic);

::Legends.Armor.Standard.leather_wraps <- {
	ID = "leather_wraps", // 20-45 -1-4 25-100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
		],
		Plate = [
			[15, ""],
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
			[5, "plate/legend_armor_leather_jacket_simple"], // 15 -2 30
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.leather_wraps);

::Legends.Armor.Standard.legend_blacksmith_apron <- {
	ID = "legend_blacksmith_apron", // 35-60 -4-7 60-135
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_apron"], // 35 -4 60
		],
		Chain = [
		],
		Plate = [
			[15, ""],
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
			[5, "plate/legend_armor_leather_jacket_simple"], // 15 -2 30
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_blacksmith_apron);

::Legends.Armor.Standard.legend_herbalist_robe <- {
	ID = "legend_herbalist_robe", // 25 -2 25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes"], // 25 -2 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_herbalist_robe);

::Legends.Armor.Standard.monk_robe <- {
	ID = "monk_robe", // 25 -2 25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes"], // 25 -2 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.monk_robe);

::Legends.Armor.Standard.legend_maid_apron <- {
	ID = "legend_maid_apron", // 10-35 -0-4 15-60
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_apron"], // 35 -4 60
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_maid_apron);

::Legends.Armor.Standard.legend_maid_dress <- {
	ID = "legend_maid_dress", // 10-25 -0-2 15-25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_peasant_dress"], // 25 -2 25
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_maid_dress);

::Legends.Armor.Standard.legend_nun_robe_dark <- {
	ID = "legend_nun_robe_dark", // 22 -1 25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes_nun"], // 22 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_nun_robe_dark);

::Legends.Armor.Standard.legend_nun_robe_light <- {
	ID = "legend_nun_robe_light", // 22 -1 25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes_nun"], // 22 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_nun_robe_light);

::Legends.Armor.Standard.legend_rabble_fur <- {
	ID = "legend_rabble_fur", // 5 -0 100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_fur_rabble"] // 5 -0 100
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_rabble_fur);

::Legends.Armor.Standard.legend_rabble_tunic <- {
	ID = "legend_rabble_tunic", // 5-15 -0-1 5-25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_sackcloth_patched"], // 15 -1 25
			[1, "cloth/legend_armor_sackcloth_tattered"], // 5 -0 5
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_rabble_tunic);

::Legends.Armor.Standard.legend_seer_robes <- {
	ID = "legend_seer_robes", // 5-25 -0-2 25-100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes"], // 25 -2 25
			[1, "cloth/legend_armor_robes_magic"], // 5 -0 100
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_seer_robes);

::Legends.Armor.Standard.legend_taxidermist_apron <- {
	ID = "legend_taxidermist_apron", // 35 -4 60
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_apron"], // 35 -4 60
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_taxidermist_apron);

::Legends.Armor.Standard.legend_vala_cloak <- {
	ID = "legend_vala_cloak", // 60 -0 0
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_vala_robe"], // 60 -0 0
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_vala_cloak);

::Legends.Armor.Standard.vala_dress <- {
	ID = "vala_dress", // 40 -0 0
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_vala_dress"], // 40 -0 0
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.vala_dress);

::Legends.Armor.Standard.legend_vampire_lord_armor <- {
	ID = "legend_vampire_lord_armor",
	Script = "scripts/items/armor/legend_vampire_lord_armor",
	Sets = [{
		Cloth = [
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_vampire_lord_armor);

::Legends.Armor.Standard.light_scale_armor <- {
	ID = "light_scale_armor", // 105-120 -11-13 1775-2275
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_scale"], // 100 -12 2250
			[1, "plate/legend_armor_scale_shirt"], // 85 -10 1750
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.light_scale_armor);

::Legends.Armor.Standard.linen_tunic <- {
	ID = "linen_tunic", // 20 -1 25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.linen_tunic);

::Legends.Armor.Standard.mail_hauberk <- {
	ID = "mail_hauberk", // 120-195 -13-23 1400-2800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			//[1, "cloth/legend_armor_tunic"], //20
		],
		Chain = [
			// [1, ""],
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_armor_decorative_hood"], // 15 -1 50
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mail_hauberk);

::Legends.Armor.Standard.mail_shirt <- {
	ID = "mail_shirt", // 45-70 -4-7 275-400
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mail_shirt);

::Legends.Armor.Standard.noble_gear <- {
	ID = "noble_gear", // 10-20 -0 500-750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble"] // 10 -0 500
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_armor_noble_shawl"], // 10 -0 250
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.noble_gear);

::Legends.Armor.Standard.noble_mail_armor <- {
	ID = "noble_mail_armor", // 95-120 -8-10 1225-2350
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble"] // 10 -0 500
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket_fine"], // 35 -2 350
		],
		Cloak = [
			[10, ""],
			[2, "cloak/legend_armor_noble_shawl"], // 10 -0 250
			[1, "cloak/legend_armor_sash"], // 3 -0 150
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.noble_mail_armor);

::Legends.Armor.Standard.noble_tunic <- {
	ID = "noble_tunic", // 10-20 -0 500-750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble"] // 10 -0 500
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_armor_noble_shawl"], // 10 -0 250
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.noble_tunic);

::Legends.Armor.Standard.padded_leather <- {
	ID = "padded_leather", // 70-95 -8-11 215-325
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_apron"], // 35 -4 60
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_leather_padded"], // 40 -5 175
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.padded_leather);

::Legends.Armor.Standard.padded_surcoat <- {
	ID = "padded_surcoat", // 55-70 -6-7 150-200
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_armor_decorative_hood"], // 15 -1 50
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.padded_surcoat);

::Legends.Armor.Standard.patched_mail_shirt <- {
	ID = "patched_mail_shirt", // 75-120 -9-16 275-675
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"],
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45 -7 200
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.patched_mail_shirt);

::Legends.Armor.Standard.ragged_dark_surcoat <- {
	ID = "ragged_dark_surcoat", // 30-100 -3-14 40-270
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
		],
		Chain = [
		],
		Plate = [
			[10, ""],
			[3, "plate/legend_armor_animal_hide_armor"], // 30 -4 100
			[3, "plate/legend_armor_leather_jacket"], // 25 -3 75
			//(this is an error)	[1, "plate/legend_armor_leather_jacket_named"], // 30
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_armor_tabbed_hood"], // 10 -1 40
			[1, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_armor_cloak_fur"], // 35 -6 120
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.ragged_dark_surcoat);

::Legends.Armor.Standard.ragged_surcoat <- {
	ID = "ragged_surcoat", // 45-65 -4-8 100-225
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
			[2, ""],
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.ragged_surcoat);

::Legends.Armor.Standard.reinforced_mail_hauberk <- {
	ID = "reinforced_mail_hauberk", // 215-245 -25-30 2650-3500
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[4, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[1, "plate/legend_armor_leather_brigandine"], // 65 -8 750
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.reinforced_mail_hauberk);

::Legends.Armor.Standard.adorned_warriors_armor <- {
	ID = "adorned_warriors_armor", // 255-300 -30-37 3100-4150
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[4, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[1, "plate/legend_armor_leather_riveted"], // 95 -13 900
			[1, "plate/legend_armor_leather_riveted_light"], // 80 -11 700
		],
		Cloak = [
			[1, "cloak/legend_armor_relic_hood"], // 25 -2 500
		],
		Tabard = [
		],
		Attachments = [
			[1, "armor_upgrades/legend_armor_chain_and_mail_upgrade"], //
			[1, "armor_upgrades/legend_armor_sacred_shield_upgrade"], //
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.adorned_warriors_armor);

::Legends.Armor.Standard.sackcloth <- {
	ID = "sackcloth", // 10-15 -0-1 15-25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_sackcloth_patched"], // 15 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.sackcloth);

::Legends.Armor.Standard.scale_armor <- {
	ID = "scale_armor", // 175-250 -22-34 2525-4000
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
		],
		Plate = [
			[1, "plate/legend_armor_scale"], // 100 -12 2250
			[1, "plate/legend_armor_scale_coat"], // 120 -15 2500
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.scale_armor);

::Legends.Armor.Standard.sellsword_armor <- {
	ID = "sellsword_armor", // 230-275 -29-38 2050-3650
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105 -17 1250
		],
		Plate = [
			[1, "plate/legend_armor_leather_riveted"], // 95 -13 900
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.sellsword_armor);

::Legends.Armor.Standard.tattered_sackcloth <- {
	ID = "tattered_sackcloth", // 5 -0 5
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth_tattered"], // 5 -0 5
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.tattered_sackcloth);

::Legends.Armor.Standard.thick_dark_tunic <- {
	ID = "thick_dark_tunic", // 30-35 -3-4 40-50
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.thick_dark_tunic);

::Legends.Armor.Standard.thick_tunic <- {
	ID = "thick_tunic", // 30 -3 40
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.thick_tunic);

::Legends.Armor.Standard.werewolf_hide_armor <- {
	ID = "werewolf_hide_armor", // 70-100 -9-13 300-400
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
		],
		Chain = [
		],
		Plate = [
			[10, ""],
			[5, "plate/legend_armor_animal_hide_armor"], // 30 -4 100
			[4, "plate/legend_armor_leather_jacket"], // 25 -3 75
			// [1, "plate/legend_armor_leather_jacket_named"], // 30
			[4, "plate/legend_armor_leather_jacket_simple"], // 15 -2 30
		],
		Cloak = [
			[1, "cloak/legend_direwolf_pelt_cloak"], // 10
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.werewolf_hide_armor);

::Legends.Armor.Standard.werewolf_mail_armor <- {
	ID = "werewolf_mail_armor", // 120-155 -15-21 650-1550
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"] 
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_direwolf_pelt_cloak"], // 10
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.werewolf_mail_armor);

::Legends.Armor.Standard.wizard_robe <- {
	ID = "wizard_robe", // 5 -0 100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes_magic"], // 5 -0 100
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.wizard_robe);

::Legends.Armor.Standard.beautiful_robe <- {
	ID = "beautiful_robe", // 5 -0 50
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes_wizard"], // 5 -0 50
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.beautiful_robe);

::Legends.Armor.Standard.worn_mail_shirt <- {
	ID = "worn_mail_shirt", // 100-115 -12-15 350-625
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45 -7 200
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.worn_mail_shirt);

::Legends.Armor.Standard.seedmaster_noble_armor <- {
	ID = "seedmaster_noble_armor", // 130-220 -15-28 1000-4000
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_robes"], // 25 -2 25
			[1, "cloth/legend_armor_tunic_noble"] // 10 -0 500
		],
		Chain = [
			[4, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[2, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[4, "chain/legend_armor_reinforced_mail_shirt"] // 80 -10 1000

		],
		Plate = [
			[4, "plate/legend_armor_leather_riveted_light"], // 80 -11 700
			[6, "plate/legend_armor_leather_scale"], // 70 -9 600
			[6, "plate/legend_armor_scale_shirt"] // 85 -10 1750
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
			[15, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_metal_pauldrons_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.seedmaster_noble_armor);

::Legends.Armor.Standard.citreneking_noble_armor <- {
	ID = "citreneking_noble_armor", // 90-270 -10-36 825-3150
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_robes"], // 25 -2 25
			[1, "cloth/legend_armor_tunic_noble"] // 10 -0 500
		],
		Chain = [
			[4, "chain/legend_armor_basic_mail"], // 85 -12 800
			[2, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[4, "chain/legend_armor_reinforced_mail_shirt"] // 80 -10 1000

		],
		Plate = [
			[4, ""],
			[1, "plate/legend_armor_leather_riveted"], // 95 -13 900
			[1, "plate/legend_armor_leather_riveted_light"] // 80 -11 700
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
			[5, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_joint_cover_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.citreneking_noble_armor);

::Legends.Armor.Standard.legend_noble_guard_armour <- {
	ID = "legend_noble_guard_armour", // 290-330 -37-45 7750-8750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble"], // 10 -0 500
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
		],
		Plate = [
			[1, "plate/legend_armor_plate_full_greaves"], // 170 -26 5000
			[1, "plate/legend_armor_plate_full"], // 160 -22 4500
		],
		Cloak = [
			[3, ""],
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
		],
		Tabard = [
			[2, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
		],
		Attachments = [
		]
	}]

};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.legend_noble_guard_armour);

::Legends.Armor.Standard.man_at_arms_noble_armor <- {
	ID = "man_at_arms_noble_armor", // 350-410 -41-48 9250-13000
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson_named"] // 75-90 -4-6 1500
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"] // 115 -14 2500

		],
		Plate = [
			[1, "plate/legend_armor_plate_full_greaves"], // 170 -26 5000
		],
		Cloak = [
			[2, ""],
			[2, "cloak/legend_armor_cloak_noble"], // 25 -2 3000
		],
		Tabard = [
			[2, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
		],
		Attachments = [
			[5, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_joint_cover_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.man_at_arms_noble_armor);

::Legends.Armor.Standard.brown_hedgeknight_armor <- {
	ID = "brown_hedgeknight_armor", // 277 -37 3350
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]] // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"] // 85 -12 800

		],
		Plate = [
			[1, "plate/legend_armor_plate_chest"] // 125 -17 2250
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_wrap_left", 6] // 2 -0 50
		],
		Attachments = [
			[1, "armor_upgrades/legend_double_mail_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.brown_hedgeknight_armor);

::Legends.Armor.Standard.red_bandit_leader_armor <- {
	ID = "red_bandit_leader_armor", // 242-292 -30-39 3250-4100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", 17], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon", 2] // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"] // 85 -12 800
		],
		Plate = [
			[1, "plate/legend_armor_scale"], // 100 -12 2250
			[1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140 -19 3000
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_wrap_left", 6] // 2 -0 50
		],
		Attachments = [
			[1, "armor_upgrades/legend_mail_patch_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.red_bandit_leader_armor);

::Legends.Armor.Standard.southern_knight_armor <- {
	ID = "southern_knight_armor", // 200-265 -22-32 2185-2800
	Script = "",
	Sets = [{
		Cloth = [
			[10, "cloth/legend_armor_southern_robe"], // 25 -1 35
			[10, "cloth/legend_armor_southern_split_gambeson"], // 65 -8 250
			[10, "cloth/legend_armor_southern_gambeson"], // 65 -8 250
			[5, "cloth/legend_armor_southern_tunic"], // 25 -1 50
			[5, "cloth/legend_armor_gambeson"], // 65 -8 250
			[2, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_southern_mail"] // 100 -13 1400
		],
		Plate = [
			[1, "plate/legend_armor_southern_plate"] // 75 -8 750
		],
		Cloak = [
			[1, ""],
			[1, "cloak/legend_armor_southern_scarf"], // 5 -0 100
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
			[1, "cloak/legend_armor_southern_scarf_wrap"] // 15 -1 150
		],
		Tabard = [
			[3, ""],
			[2, "tabard/legend_armor_southern_wrap_left"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap"], // 5 -0 100
			[1, "tabard/legend_armor_southern_shoulder_cloth"] // 5 -0 100
		],
		Attachments = [
			[6, ""],
			[4, "armor_upgrades/legend_mail_patch_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.southern_knight_armor);

::Legends.Armor.Standard.northern_mercenary_armor_00 <- {
	ID = "northern_mercenary_armor_00", // 160-275 -19-33 2000-4600
	Script = "", // heavier than 01 ~200
	Sets = [{
		Cloth = [
			[2, "cloth/legend_armor_gambeson"], // 65 -8 250
			[2, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[5, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"] 
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"] // 115 -14 2500
		],
		Plate = [
			[8, ""],
			[1, "plate/legend_armor_rotten_scale_coat"], // 60 -9 600
			[1, "plate/legend_armor_scale_shirt"] // 85 -10 1750
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_armor_shoulder_cloth", 2], // 5 -0 50
			[2, "cloak/legend_direwolf_pelt_cloak"], // 10
		],
		Tabard = [

		],
		Attachments = [
			[4, "armor_upgrades/legend_double_mail_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.northern_mercenary_armor_00);

::Legends.Armor.Standard.traze_northern_mercenary_armor <- {
	ID = "traze_northern_mercenary_armor", // 310-340 -40-44 5500-6350
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_armor_gambeson"], // 65 -8 250
			[2, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[5, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[1, "plate/legend_armor_plate_cuirass"], // 150 -21 3500
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_armor_shoulder_cloth"], // 5 -0 50
		],
		Tabard = [

		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.traze_northern_mercenary_armor);

::Legends.Armor.Standard.northern_mercenary_armor_01 <- {
	ID = "northern_mercenary_armor_01", // 145-185 -18-26 1250-2100
	Script = "", // lighter than 00 ~170
	Sets = [{
		Cloth = [
			[2, "cloth/legend_armor_gambeson"], // 65 -8 250
			[2, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[5, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"] 
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_reinforced_worn_mail"] // 105 -17 1250
		],
		Plate = [
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_armor_shoulder_cloth", 2] // 5 -0 50
		],
		Tabard = [

		],
		Attachments = [
			[4, "armor_upgrades/legend_metal_plating_upgrade"],
			[4, "armor_upgrades/legend_leather_shoulderguards_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.northern_mercenary_armor_01);

::Legends.Armor.Standard.northern_mercenary_armor_02 <- {
	ID = "northern_mercenary_armor_02", // 145-185 -18-26 1250-2100
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_armor_gambeson"], // 65 -8 250
			[2, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[5, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"] 
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_reinforced_worn_mail"] // 105 -17 1250
		],
		Plate = [],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_armor_shoulder_cloth", 2] // 5 -0 50
		],
		Tabard = [

		],
		Attachments = [
			[4, "armor_upgrades/legend_metal_plating_upgrade"],
			[4, "armor_upgrades/legend_leather_shoulderguards_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.northern_mercenary_armor_02);

::Legends.Armor.Standard.barbarian_chosen_armor_00 <- {
	ID = "barbarian_chosen_armor_00", // 180-185 -25-26 900-950
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[4, "cloth/legend_armor_quilted_aketon", [1,26,27,28,29,30,31]], // 55 -6 150
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"]
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35 -6 300
			[1, "chain/legend_armor_ancient_double_mail"] // 35 -6 300
		],
		Plate = [
			[1, "plate/legend_armor_hide_and_bone_armor"],
			[1, "plate/legend_armor_animal_hide_armor"],
			[1, "plate/legend_armor_animal_hide_armor_reinforced"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
			[4, "armor_upgrades/legend_additional_padding_upgrade"],
			[4, "armor_upgrades/legend_barbarian_horn_upgrade"],
			[1, "armor_upgrades/legend_bone_platings_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.barbarian_chosen_armor_00);

::Legends.Armor.Standard.barbarian_chosen_armor_01 <- {
	ID = "barbarian_chosen_armor_01", // 190-285 -27-43 850-2270
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[4, "cloth/legend_armor_quilted_aketon", [1,26,27,28,29,30,31]], // 55 -6 150
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"]
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65 -11 350
			[1, "chain/legend_armor_ancient_double_mail"], // 80 -14 750
		],
		Plate = [
			[1, "plate/legend_armor_scrap_metal_armor"], // 65 -10 250
			[1, "plate/legend_armor_rugged_scale_armor"], // 95 -15 700
			[1, "plate/legend_armor_heavy_iron_armor"], // 120 -18 1000
		],
		Cloak = [
			[1, ""],
			[5, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_direwolf_pelt_cloak"] // 10
		],
		Tabard = [
		],
		Attachments = [
			[9, ""],
			[1, "armor_upgrades/legend_bone_platings_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.barbarian_chosen_armor_01);

::Legends.Armor.Standard.barbarian_chosen_armor_02 <- {
	ID = "barbarian_chosen_armor_02", // 190-285 -27-43 850-2270
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[4, "cloth/legend_armor_quilted_aketon", [1,26,27,28,29,30,31]], // 55 -6 150
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"]
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail"],
			[1, "chain/legend_armor_reinforced_mail"]
		],
		Plate = [
			[1, "plate/legend_armor_hide_and_bone_armor"],
			[1, "plate/legend_armor_animal_hide_armor"],
			[1, "plate/legend_armor_animal_hide_armor_reinforced"],
		],
		Cloak = [],
		Tabard = [
			[1, ""]
		],
		Attachments = [
			[4, "armor_upgrades/legend_additional_padding_upgrade"],
			[4, "armor_upgrades/legend_barbarian_horn_upgrade"],
			[1, "armor_upgrades/legend_armor_skull_chain", 1]
		],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.barbarian_chosen_armor_02);

::Legends.Armor.Standard.barbarian_chosen_armor_03 <- {
	ID = "barbarian_chosen_armor_03", // 190-285 -27-43 850-2270
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[4, "cloth/legend_armor_quilted_aketon", [1,26,27,28,29,30,31]], // 55 -6 150
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"]
		],
		Chain = [
			[1, ""]
		],
		Plate = [
			[1, "plate/legend_armor_scrap_metal_armor"], // 65 -10 250
			[1, "plate/legend_armor_rugged_scale_armor"], // 95 -15 700
			[1, "plate/legend_armor_heavy_iron_armor"], 
		],
		Cloak = [
			[1, ""],
			[5, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_unhold_fur_cloak"]
		],
		Tabard = [
			[1, ""]
		],
		Attachments = [
			[9, ""],
			[1, "armor_upgrades/legend_barbarian_horn"]
		],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.barbarian_chosen_armor_03);

::Legends.Armor.Standard.brown_monk_armor_00 <- {
	ID = "brown_monk_armor_00", // 27-45 -2-4 75-155
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes", 1] // 25 -2 25
		],
		Chain = [
		],
		Plate = [
			[2, ""],
			[1, "plate/legend_armor_leather_jacket_simple"] // 15 -2 30
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_wrap_left", 6], // 2 -0 50
			[1, "tabard/legend_armor_southern_shoulder_cloth", 7], // 5 -0 100
			[1, "tabard/legend_armor_southern_shoulder_cloth", 6] // 5 -0 100
		],
		Attachments = [
			[9, ""],
			[1, "armor_upgrades/legend_leather_neckguard_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.brown_monk_armor_00);

::Legends.Armor.Standard.dark_southern_armor_00 <- {
	ID = "dark_southern_armor_00", // 105-115 -12-14 925-940
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_wrap"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_thin"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_deep"] // 20 -1 25
		],
		Chain = [
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_animal_pelt", 4] // 15 -2 250
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_overcloth"] // 10 -1 150
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.dark_southern_armor_00);

::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_00 <- {
	ID = "citrene_nomad_cutthroat_armor_00", // 155-190 -21-25 1800-4800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_southern_tunic"], // 25 -1 50
		],
		Chain = [
		],
		Plate = [
			[5, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130 -20 1750
			[3, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
			[1, "plate/legend_armor_leather_lamellar_heavy"], // 165 -24 4750
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_00);

::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_01 <- {
	ID = "citrene_nomad_cutthroat_armor_01", // 177 -23 1800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_southern_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_southern_split_gambeson"], // 65 -8 250
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_chest_restored"], // 110 -15 1500
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_wrap_right"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap_left"], // 2 -0 50
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_01);

::Legends.Armor.Standard.citrene_nomad_leader_armor_00 <- {
	ID = "citrene_nomad_leader_armor_00", // 75-80 -6-7 550-600
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_southern_gladiator_harness"], // 40 -4 150
		],
		Chain = [],
		Plate = [
			[1, "plate/legend_armor_southern_arm_guards"], // 30 -2 300
		],
		Cloak = [
		],
		Tabard = [
			[2, "tabard/legend_armor_noble_vest"], // 10 -1 150
			[1, "tabard/legend_armor_southern_wrap"], // 5 -0 100
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
			[1, "tabard/legend_armor_southern_overcloth"], // 10 -1 150
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.citrene_nomad_leader_armor_00);

::Legends.Armor.Standard.white_nomad_leader_armor_00 <- {
	ID = "white_nomad_leader_armor_00", // 175-295 -21-42 1775-3390
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_wrap"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_thin"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_deep"] // 20 -1 25
		],
		Chain = [
			[1, "chain/legend_armor_southern_mail"], // 100 -13 1400
		],
		Plate = [

			[1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130 -20 1750
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 55 -7 350
			[1, "plate/legend_armor_southern_scale"], // 155 -26 1500
		],
		Cloak = [
			[3, ""],
			[1, "cloak/legend_armor_southern_scarf"], // 5 -0 100
		],
		Tabard = [
			[2, ""],
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
			[1, "tabard/legend_armor_southern_wrap"], // 5 -0 100
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.white_nomad_leader_armor_00);

::Legends.Armor.Standard.theamson_nomad_outlaw_armor <- {
	ID = "theamson_nomad_outlaw_armor", // 180 -17 3000
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_southern_tunic"], // 25 -1 50
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[1, "plate/legend_armor_southern_arm_guards"], // 30 -2 300
		],
		Cloak = [
			[1, "cloak/legend_armor_shoulder_cloth"], // 5 -0 50
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.theamson_nomad_outlaw_armor);

::Legends.Armor.Standard.theamson_nomad_leader_armor_heavy <- {
	ID = "theamson_nomad_leader_armor_heavy", // 165 -18 1150
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_southern_tunic"], // 25 -1 50
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
		],
		Plate = [
			[1, "plate/legend_armor_southern_leather_plates"], // 50 -5 200
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.theamson_nomad_leader_armor_heavy);

::Legends.Armor.Standard.indebted_armor_rags <- {
	ID = "indebted_armor_rags", // 7-20 -0-1 55-125
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_sackcloth"], // 10 -0 15
			[1, "cloth/legend_armor_sackcloth_tattered"], // 5 -0 5
			[1, "cloth/legend_armor_sackcloth_patched"], // 15 -1 25
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, ""],

		],
		Tabard = [
			[1, "tabard/legend_armor_southern_wrap_left"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap_right"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap"], // 5 -0 100
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.indebted_armor_rags);

::Legends.Armor.Standard.heraldic_armor <- {
	ID = "special/heraldic_armor", // 185-190 -22 2950-3750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.heraldic_armor);

::Legends.Armor.Standard.wardog_armor <- {
	ID = "special/wardog_armor", // 55
	Script = "",
	Sets = [{
		Cloth = [
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.wardog_armor);

::Legends.Armor.Standard.wardog_heavy_armor <- {
	ID = "special/wardog_heavy_armor", // 85
	Script = "",
	Sets = [{
		Cloth = [
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.wardog_heavy_armor);

::Legends.Armor.Standard.adorned_heavy_mail_hauberk <- {
	ID = "adorned_heavy_mail_hauberk", // 215-320 -25-41 2500-5750
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[4, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[1, "plate/legend_armor_leather_scale"], // 70 -9 600
			[1, "plate/legend_armor_leather_riveted"], // 95 -13 900
			[1, "plate/legend_armor_leather_riveted_light"], // 80 -11 700
			[1, "plate/legend_armor_leather_brigandine"], // 65 -8 750
			[1, "plate/legend_armor_leather_brigandine_hardened"], // 110 -15 1250
			[1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140 -19 3000
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
			//	[1, "armor_upgrades/legend_armor_chain_and_mail_upgrade"], //
			//	[1, "armor_upgrades/legend_armor_sacred_shield_upgrade"], //
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.adorned_heavy_mail_hauberk);

::Legends.Armor.Standard.adorned_mail_shirt <- {
	ID = "adorned_mail_shirt", // 125-175 -10-15 875-1225
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_knightly_robe"], // 60 -2 450
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_southern_padded"], // 65 -7 400
			[1, "plate/legend_armor_leather_padded"], // 40 -5 175
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
			[1, "armor_upgrades/legend_armor_spiked_collar_upgrade"], //
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.adorned_mail_shirt);

::Legends.Armor.Standard.reinforced_leather_tunic <- {
	ID = "reinforced_leather_tunic", // 100 -9 500
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes_anatomist"], // 70 -7 350
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_anatomist_hood"], // 30 -2 150
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.reinforced_leather_tunic);

::Legends.Armor.Standard.undertaker_apron <- {
	ID = "undertaker_apron", // 100 -12 310
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_apron_undertakers"], // 35 -4 60
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.undertaker_apron);

::Legends.Armor.Standard.wanderers_coat <- {
	ID = "wanderers_coat", // 55 -4 180
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_wanderers_coat"], // 45 -4 120
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_religious_scarf"], // 10 -0 60
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.wanderers_coat);

::Legends.Armor.Standard.lonewolf_longsword_armour <- {
	ID = "lonewolf_longsword_armour", // 140-175 -16-21 800-1025
	Script = "scripts/items/armor/lonewolf_longsword_armour",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar"], // 50 -6 250
		],
		Cloak = [
		],
		Tabard = [
			[2, "tabard/legend_armor_noble_vest"], // 10 -1 150
		],
		Attachments = [
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lonewolf_longsword_armour);

::Legends.Armor.Standard.lonewolf_hammershield_armour <- {
	ID = "lonewolf_hammershield_armour", // 170-180 -21-23 2000-2100
	Script = "scripts/items/armor/lonewolf_hammershield_armour",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lonewolf_hammershield_armour);

::Legends.Armor.Standard.lonewolf_axebuckler_armour <- {
	ID = "lonewolf_axebuckler_armour", // 135-145 -16-18 750-850
	Script = "scripts/items/armor/lonewolf_axebuckler_armour",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 55 -7 350
		],
		Cloak = [
			[1, "cloak/legend_direwolf_pelt_cloak"], // 10
		],
		Tabard = [
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lonewolf_axebuckler_armour);

::Legends.Armor.Standard.lonewolf_crossbowsword_armour <- {
	ID = "lonewolf_crossbowsword_armour", // 55-90 -4-9 425-550
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_robes"], // 25 -2 25
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_shoulder_cloth"], // 5 -0 50
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
		],
		Attachments = [
		]
	}]

};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lonewolf_crossbowsword_armour);

::Legends.Armor.Standard.lonewolf_bowdagger_armour <- {
	ID = "lonewolf_bowdagger_armour", // 70 -8 1250
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble"], // 10 -0 500
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_crusader"], // 35 -5 500
		],
		Tabard = [
		],
		Attachments = [
		]
	}]

};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lonewolf_bowdagger_armour);

::Legends.Armor.Standard.lonewolf_polearm_armour <- {
	ID = "lonewolf_polearm_armour", // 215 -26 2950
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_plate_chest"], // 125 -17 2250
		],
		Cloak = [
			[1, "cloak/legend_armor_southern_scarf"], // 5 -0 100
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.lonewolf_polearm_armour);

::Legends.Armor.Standard.bandit_armor_light <- {
	ID = "bandit_armor_light", // 55-190 -6-23 150-1625
	Script = "", //~90-175
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[3, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[3, "chain/legend_armor_rusty_mail_shirt"], // 20 -4 125
			[2, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[2, "chain/legend_armor_short_mail"], // 60 -8 500
			[1, "plate/legend_armor_leather_brigandine"], // 65 -8 750
			[4, ""], //0
		],
		Plate = [
			[1, "plate/legend_armor_leather_padded"], // 40 -5 175
			[2, ""], //0
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[2, ""], //0
		],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.bandit_armor_light);

::Legends.Armor.Standard.bandit_armor_medium <- {
	ID = "bandit_armor_medium", // 100-340 -12-47 350-4800
	Script = "", //~140-165
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45 -7 200
		],
		Plate = [
			[2, "plate/legend_armor_rotten_scale_coat"], // 60 -9 600
			[2, "plate/legend_armor_leather_lamellar"], // 50 -6 250
			[2, "plate/legend_armor_leather_padded"], // 40 -5 175
			[2, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
			[1, "plate/legend_armor_scale_shirt"], // 85 -10 1750
			[2, ""], //0
			[1, "plate/legend_armor_leather_brigandine"], // 65 -8 750
			[2, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, ""], //0
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, ""], //0
		],
		Attachments = [
			[15, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.bandit_armor_medium);

::Legends.Armor.Standard.bandit_armor_heavy <- {
	ID = "bandit_armor_heavy", // 200-345 -25-47 1550-6550
	Script = "", //~230-315
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
		],
		Chain = [
			[2, "chain/legend_armor_hauberk"], // 95 -11 1750
			[2, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[2, "plate/legend_armor_plate_chest"], // 125 -17 2250
			[1, "plate/legend_armor_plate_cuirass"], // 150 -21 3500
			[2, "plate/legend_armor_scale"], // 100 -12 2250
			[2, "plate/legend_armor_rotten_scale_coat"], // 60 -9 600
			[1, "plate/legend_armor_scale_coat"], // 120 -15 2500
			[2, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130 -20 1750
			[1, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
			[1, "plate/legend_armor_leather_brigandine"], // 65 -8 750
			[1, "plate/legend_armor_leather_brigandine_hardened"], // 110 -15 1250
			[1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140 -19 3000
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, ""], //0
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, ""], //0
		],
		Attachments = [
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[15, ""],
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.bandit_armor_heavy);

::Legends.Armor.Standard.bandit_armor_ultraheavy <- {
	ID = "bandit_armor_ultraheavy", // 275-365 -35-51 3650-7900
	Script = "", //~255-375
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
			[1, "cloth/legend_armor_studded_aketon"] 
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], // 110 -15 1750
			[1, "chain/legend_armor_hauberk"], // 95 -11 1750
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80 -10 1000
			[1, "chain/legend_armor_hauberk_full"], // 115 -14 2500
		],
		Plate = [
			[1, "plate/legend_armor_plate_cuirass"], // 150 -21 3500
			[1, "plate/legend_armor_plate_full"], // 160 -22 4500
			[1, "plate/legend_armor_leather_lamellar_heavy"], // 165 -24 4750
			[3, "plate/legend_armor_plate_full_greaves"], // 170 -26 5000
			[1, "plate/legend_armor_leather_lamellar_reinforced"], // 150 -23 2500
			[1, "plate/legend_armor_leather_lamellar_heavy"], // 165 -24 4750
			[1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140 -19 3000
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, ""], //0
		],
		Tabard = [
		],
		Attachments = [
			[15, ""],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_metal_pauldrons_upgrade"],
		]
	}]

};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.bandit_armor_ultraheavy);

::Legends.Armor.Standard.mercury_noble_elite_footman_00 <- {
	ID = "mercury_noble_elite_footman_00", // 220 -25 3140
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", 2]], // 65 -8 250
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless", 1]], // 65 -7 1250
		Plate = [
			[1, "plate/legend_armor_leather_scale", 1]], // 70 -9 600
		Cloak = [
			[1, "cloak/legend_armor_tabbed_hood"]], // 10 -1 40
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[2, ""],
			[1, "armor_upgrades/legend_metal_plating_upgrade"],
			[1, "armor_upgrades/legend_pauldron_swan_upgrade"],
			[1, "armor_upgrades/legend_armor_spiked_collar_upgrade"]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_noble_elite_footman_00);

::Legends.Armor.Standard.mercury_sureshot_00 <- {
	ID = "mercury_sureshot_00", // 155 -17 2530
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", 8]], // 65 -8 250
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless", 1]], // 65 -7 1250
		Plate = [
			[1, "plate/legend_armor_leather_jacket_simple", 6]], // 15 -2 30
		Cloak = [
			[1, ""]],
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_sureshot_00);

::Legends.Armor.Standard.mercury_sureshot_01 <- {
	ID = "mercury_sureshot_01", // 120 -12 1625
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes", 11]], // 25 -2 25
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple", 1]], // 25 -3 250
		Plate = [
			[1, "plate/legend_armor_leather_lamellar", 1]], // 50 -6 250
		Cloak = [
			[1, "cloak/legend_armor_cloak", 7]], // 10 -1 100
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_sureshot_01);

::Legends.Armor.Standard.mercury_sureshot_02 <- {
	ID = "mercury_sureshot_02", // 130 -14 1875
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes", 11]], // 25 -2 25
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple", 1]], // 25 -3 250
		Plate = [
			[1, "plate/legend_armor_leather_scale", 1], [1, "plate/legend_armor_leather_riveted_light", 1]], // 70 -9 600
		Cloak = [
			[1, ""], [1, "cloak/legend_armor_shoulder_cloth", 2], [1, "cloak/legend_armor_cloak_fur", 1]], // 5 0 50
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble", 3]], // 10 -0 1000
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_sureshot_02);

::Legends.Armor.Standard.mercury_pollax_00 <- {
	ID = "mercury_pollax_00", // 225 -27 2870
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", 8]], // 65 -8 250
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless", 1]], // 65 -7 1250
		Plate = [
			[1, "plate/legend_armor_leather_lamellar", 1]], // 50 -6 250
		Cloak = [
			[1, "cloak/legend_armor_cloak_fur", 4]], // 35 -6 120
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[3, ""],
			[1, "armor_upgrades/legend_metal_plating_upgrade"],
			[1, "armor_upgrades/legend_pauldron_swan_upgrade"],
			[1, "armor_upgrades/legend_armor_spiked_collar_upgrade"]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_pollax_00);

::Legends.Armor.Standard.mercury_pollax_01 <- {
	ID = "mercury_pollax_01", // 190 -16 2700
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_knightly_robe", 7]], // 60 -2 450
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple", 1]], // 25 -3 250
		Plate = [
			[1, "plate/legend_armor_scale_shirt", 1]], // 85 -10 1750
		Cloak = [
			[1, "cloak/legend_armor_decorative_hood", 8],
			[1, "cloak/legend_armor_shoulder_cloth", 2]], // 15 -1 50
		Tabard = [
			[1, "tabard/legend_armor_tabard"]], // 5 -0 200
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_pollax_01);

::Legends.Armor.Standard.mercury_sureshot_green_00 <- {
	ID = "mercury_sureshot_green_00", // 160 -19 2425
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_robes", 6]], // 25 -2 25
		Chain = [
			[1, ""]],
		Plate = [
			[1, "plate/legend_armor_leather_riveted", 5]], // 95 -13 900
		Cloak = [
			[1, "cloak/legend_armor_cloak_heavy", 9]], // 30 -4 500
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_sureshot_green_00);

::Legends.Armor.Standard.mercury_sureshot_blue_00 <- {
	ID = "mercury_sureshot_blue_00", // 95 -10 1390
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic", 10]], // 30 -3 40
		Chain = [
			[1, ""]],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced", 1]], // 55 -7 350
		Cloak = [
			[1, ""]],
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[2, ""],
			[1, "armor_upgrades/legend_leather_shoulderguards_upgrade"]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_sureshot_blue_00);

::Legends.Armor.Standard.mercury_pollax_colorful_00 <- {
	ID = "mercury_pollax_colorful_00", // 215 -23 4800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble", 9]], // 10 -0 500
		Chain = [
			[1, "chain/legend_armor_reinforced_mail_shirt", 1]], // 80 -10 1000
		Plate = [
			[1, "plate/legend_armor_scale", 1], [1, "plate/legend_armor_leather_brigandine", 1]], // 100 -12 2250
		Cloak = [
			[1, "cloak/legend_armor_decorative_hood"]], // 15 -1 50
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_pollax_colorful_00);

::Legends.Armor.Standard.mercury_pollax_colorful_01 <- {
	ID = "mercury_pollax_colorful_01", // 170 -20 3100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_noble", 9]], // 10 -0 500
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail", 1]], // 105 -17 1250
		Plate = [
			[1, "plate/legend_armor_southern_arm_guards", 1]], // 30 -2 300
		Cloak = [
			[1, "cloak/legend_armor_decorative_hood", 8]], // 15 -1 50
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[1, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_pollax_colorful_01);

::Legends.Armor.Standard.mercury_royal_guard_00 <- {
	ID = "mercury_royal_guard_00", // 200-280 -23-35 2500-5500
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", 2]], // 65 -8 250
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless", 1], // 65 -7 1250
			[1, "chain/legend_armor_short_mail", 1]], // 60 -8 500
		Plate = [
			[1, "plate/legend_armor_leather_brigandine_hardened_full", 1], // 140 -19 3000
			[1, "plate/legend_armor_leather_riveted"], // 95 -13 900
			[1, "plate/legend_armor_scale_shirt", 1], // 85 -10 1750
			[1, "plate/legend_armor_leather_brigandine", 1]], // 65 -8 750
		Cloak = [
			[1, ""]],
		Tabard = [
			[1, "tabard/legend_armor_tabard_noble"]], // 10 -0 1000
		Attachments = [
			[3, ""], [1, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[1, "armor_upgrades/legend_double_mail_upgrade"],
			[1, "armor_upgrades/legend_leather_shoulderguards_upgrade"]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.mercury_royal_guard_00);

::Legends.Armor.Standard.fault_finder_robes <- {
	ID = "fault_finder_robes", // 90 -7 900
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_fleshcultist_tunic", 1]], // 55 -4 350
		Chain = [
			[1, ""]],
		Plate = [
			[1, "plate/legend_armor_fleshcultist_jacket", 1]], // 30 -3 350
		Cloak = [
			[1, ""]],
		Tabard = [
			[1, "tabard/legend_armor_fleshcultist_tabard"]], // 5 -0 200
		Attachments = [
			[3, ""]],
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Standard.fault_finder_robes);

