::Legends.Armor.Named <- {};

::Legends.Armor.Named.black_and_gold_armor <- {
	ID = "named/black_and_gold_armor", // 195-255 -17-26 5350-6000
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1,2,3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full_named"] // 125-150 -9-13 5000
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
			[1, "cloak/legend_armor_southern_scarf"], // 5 -0 100
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
			[1, "cloak/legend_armor_southern_scarf_wrap"] // 15 -1 150
		],
		Tabard = [
			[2, ""],
			[3, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, "tabard/legend_armor_southern_wrap_right"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap_left"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wide_belt"], // 2 -0 50
			[2, "tabard/legend_armor_southern_tabard"] // 5 -0 200
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.black_and_gold_armor);

::Legends.Armor.Named.black_leather_armor <- {
	ID = "named/black_leather_armor", // 81-151 -4-14 1800-2700
	Script = "",
	Sets = [{
		Cloth = [ //45 avg
			[1, "cloth/legend_armor_tunic_noble_named"] // 46-56 -0-2 1500
		],
		Chain = [ //45 avg, want 20
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45 -7 200
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [
		],
		Cloak = [ //grabbed 2 southern layers cuz they look cool ; have avg of 17 ish want 3
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
			[1, "cloak/legend_armor_southern_scarf_wrap"] // 15 -1 150
		],
		Tabard = [
			[1, ""],
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.black_leather_armor);

::Legends.Armor.Named.blue_studded_mail_armor <- {
	ID = "named/blue_studded_mail_armor", // 100-150 -7-14 1700-2000
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson_named"] // 75-90 -4-6 1500
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45 -7 200
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [
		],
		Cloak = [],
		Tabard = [],
		Attachments = [
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.blue_studded_mail_armor);

::Legends.Armor.Named.brown_coat_of_plates_armor <- {
	ID = "named/brown_coat_of_plates_armor", // 285-420 -34-52 10750-13050
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1,2,3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_ancient_double_mail"], // 80 -14 750
			[1, "chain/legend_armor_ancient_mail"], // 35 -6 300
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [
			// [1, "plate/legend_armor_plate_full_greaves"],
			[1, "plate/legend_armor_plate_full_greaves_named"], // 185-225 -23-25 10000
			[1, "plate/legend_armor_plate_full_greaves_painted"] // 185-225 -23-25 10000
		],
		Cloak = [
			[1, "cloak/legend_armor_shoulder_cloth"], // 5 -0 50
			[1, "cloak/legend_armor_noble_shawl"], // 10 -0 250
			[1, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.brown_coat_of_plates_armor);

::Legends.Armor.Named.golden_scale_armor <- {
	ID = "named/golden_scale_armor", // 215-400 -19-45 5530-9800
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full_named"] // 125-150 -9-13 5000
		],
		Plate = [
			[1, "plate/legend_armor_leather_brigandine"], // 65 -8 750
			[1, "plate/legend_armor_leather_brigandine_hardened"], // 110 -15 1250
			[1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140 -19 3000
			[1, "plate/legend_armor_leather_jacket"], // 25 -3 75
			[1, "plate/legend_armor_leather_jacket_simple"], // 15 -2 30
			[1, "plate/legend_armor_leather_lamellar"], // 50 -6 250
			[1, "plate/legend_armor_leather_padded"], // 40 -5 175
			[1, "plate/legend_armor_leather_riveted_light"], // 80 -11 700
			[1, "plate/legend_armor_leather_scale"] // 70 -9 600
		],
		Cloak = [
			[1, "cloak/legend_armor_shoulder_cloth"], // 5 -0 50
			[1, "cloak/legend_armor_noble_shawl"], // 10 -0 250
			[1, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.golden_scale_armor);

::Legends.Armor.Named.green_coat_of_plates_armor <- {
	ID = "named/green_coat_of_plates_armor", // 295-440 -37-55 10800-13200
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_ancient_double_mail"], // 80 -14 750
			[1, "chain/legend_armor_ancient_mail"], // 35 -6 300
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105 -17 1250
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_southern_mail"], // 100 -13 1400
		],
		Plate = [
			// [1, "plate/legend_armor_plate_full_greaves"],
			[1, "plate/legend_armor_plate_full_greaves_named"], // 185-225 -23-25 10000
			[1, "plate/legend_armor_plate_full_greaves_painted"] // 185-225 -23-25 10000
		],
		Cloak = [
			[1, "cloak/legend_armor_shoulder_cloth"], // 5 -0 50
			[1, "cloak/legend_armor_noble_shawl"], // 10 -0 250
			[1, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_armor_cloak"], // 10 -1 100
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
		],
		Tabard = [
			[1, "tabard/legend_armor_tabard"], // 5 -0 200
			[1, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.green_coat_of_plates_armor);

::Legends.Armor.Named.heraldic_mail_armor <- {
	ID = "named/heraldic_mail_armor", // 220-290 -21-31 5450-5800
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [ //45 avg, want 20
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45 -7 200
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [
			[1, "plate/legend_armor_scale_coat_named"] // 130-160 -10-14 5000
		],
		Cloak = [],
		Tabard = [],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.heraldic_mail_armor);

::Legends.Armor.Named.leopard_armor <- {
	//TODO Southern
	ID = "named/leopard_armor", // 295-415 -30-49 9610-11100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_southern_robe"], // 25 -1 35
			[1, "cloth/legend_armor_southern_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_southern_split_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_southern_tunic"] // 25 -1 50
		],
		Chain = [
			[1, "chain/legend_armor_southern_padded_chest"], // 45 -4 325
			[1, "chain/legend_armor_southern_mail"] // 100 -13 1400
		],
		Plate = [
			[1, "plate/legend_armor_southern_named_plate"] // 210-230 -23-26 9000
		],
		Cloak = [
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
		],
		Tabard = [
			[3, ""],
			[1, "tabard/legend_armor_southern_wide_belt"], // 2 -0 50
			[1, "tabard/legend_armor_southern_tabard"] // 5 -0 200
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.leopard_armor);

::Legends.Armor.Named.named_bronze_armor <- {
	ID = "named/named_bronze_armor", // 145-170 -13-16 2750-2800
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [

		],
		Plate = [
			[1, "plate/legend_armor_leather_brigandine_named"] // 80-100 -5-7 2500
		],
		Cloak = [],
		Tabard = [],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.named_bronze_armor);

::Legends.Armor.Named.named_golden_lamellar_armor <- {
	ID = "named/named_golden_lamellar_armor", // 282-325 -31-38 9400-9750
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [

		],
		Plate = [
			[1, "plate/legend_armor_southern_named_plate"] // 210-230 -23-26 9000
		],
		Cloak = [
			[1, "cloak/legend_armor_southern_scarf"], // 5 -0 100
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
			[1, "cloak/legend_armor_southern_scarf_wrap"] // 15 -1 150
		],
		Tabard = [
			[1, "tabard/legend_armor_southern_wrap_right"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap_left"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wide_belt"], // 2 -0 50
			[1, "tabard/legend_armor_southern_wrap"], // 5 -0 100
			[1, "tabard/legend_armor_southern_shoulder_cloth"], // 5 -0 100
			[1, "tabard/legend_armor_southern_overcloth"], // 10 -1 150
			[1, "tabard/legend_armor_southern_tabard"] // 5 -0 200
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.named_golden_lamellar_armor);

::Legends.Armor.Named.named_noble_mail_armor <- {
	ID = "named/named_noble_mail_armor", // 140-200 -7-16 2900-6500
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson_named"] // 75-90 -4-6 1500
		],
		Chain = [
			[1, ""], //0
			[1, "chain/legend_armor_mail_shirt_simple"] // 25 -3 250
		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket_named"], // 35-45 -1-2 750
			[1, "plate/legend_armor_leather_studded_jacket_named"] // 35-45 -1-2 750
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_heavy"], // 30 -4 500
			[4, "cloak/legend_armor_cloak_noble"], // 25 -2 3000
		],
		Tabard = [
			[7, "tabard/legend_armor_tabard_noble"], // 10 -0 1000
			[2, "tabard/legend_armor_noble_vest"], // 10 -1 150
			[1, "tabard/legend_armor_southern_tabard"] // 5 -0 200
		],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.named_noble_mail_armor);

::Legends.Armor.Named.named_plated_fur_armor <- {
	ID = "named/named_plated_fur_armor", // 115-130 -11-13 1250-1300
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [

		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket_named"] // 35-45 -1-2 750
		],
		Cloak = [
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
		],
		Tabard = [],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.named_plated_fur_armor);

::Legends.Armor.Named.named_sellswords_armor <- {
	ID = "named/named_sellswords_armor", // 210-315 -22-41 7775-9250
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_thick_tunic"], // 30 -3 40
			[1, "cloth/legend_armor_tunic"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_wrap"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_thin"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_collar_deep"], // 20 -1 25
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_tunic_noble"] // 10 -0 500
		],
		Chain = [
			[1, "chain/legend_armor_ancient_double_mail"], // 80 -14 750
			[1, "chain/legend_armor_ancient_mail"], // 35 -6 300
			[1, "chain/legend_armor_basic_mail"], // 85 -12 800
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_mail_shirt_simple"], // 25 -3 250
			[1, "chain/legend_armor_short_mail"] // 60 -8 500
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar_heavy_named"] // 175-195 -19-23 7500
		],
		Cloak = [],
		Tabard = [],
		Attachments =[
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.named_sellswords_armor);

::Legends.Armor.Named.named_skull_and_chain_armor <- {
	ID = "named/named_skull_and_chain_armor", // 195-265 -21-32 3070-3800
	Script = "",
	Sets = [{
		Cloth = [ //avg 65
			[4, "cloth/legend_armor_gambeson"], // 65 -8 250
			[4, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[2, "cloth/legend_armor_gambeson_wolf"] // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_ancient_double_mail"], // 80 -14 750
			[1, "chain/legend_armor_ancient_mail"], // 35 -6 300
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"] // 45 -7 200
		],
		Plate = [
			[1, "plate/legend_armor_leather_brigandine_named"] // 80-100 -5-7 2500
		],
		Cloak = [
			[4, "cloak/legend_armor_cloak_wooly_dark"], // 15 -2 120
			[1, "cloak/legend_armor_animal_pelt"], // 15 -2 250
		],
		Tabard = [],
		Attachments =[
			[1, "armor_upgrades/legend_armor_skull_chain_upgrade"]
		]
	}]
};
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.named_skull_and_chain_armor);

::Legends.Armor.Named.lindwurm_armor <- {
	ID = "lindwurm_armor", // 105-145 -12-17 525-1800
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]], // 65 -8 250
			[1, "cloth/legend_armor_gambeson"], // 65 -8 250
			[1, "cloth/legend_armor_quilted_aketon"], // 55 -6 150
			[1, "cloth/legend_armor_gambeson_wolf"], // 70 -9 300
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_sleeveless"], // 65 -7 1250
			[1, "chain/legend_armor_mail_shirt"], // 50 -6 375
			[1, "chain/legend_armor_short_mail"], // 60 -8 500
		],
		Plate = [
			[1, "named/legend_lindwurm_scale_armor"],
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
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.lindwurm_armor);

::Legends.Armor.Named.ghost_armor_named_01 <- {
	ID = "ghost_armor_named_01", // 240-395 -31-50 10175-11500
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
			[1, "plate/legend_armor_plate_full_greaves_named"], // 185-225 -23-25 10000
			[1, "plate/legend_armor_plate_full_greaves_painted"] // 185-225 -23-25 10000
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
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.ghost_armor_named_01);

::Legends.Armor.Named.ghost_armor_named_02 <- {
	ID = "ghost_armor_named_02", // 320-385 -35-47 9550-10250
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_armor_tunic_dark"], // 35 -4 50
			[1, "cloth/legend_armor_gambeson", [1, 2, 3]] // 65 -8 250
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full_named"] // 125-150 -9-13 5000
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
::Const.LegendMod.ArmorObjs.push(::Legends.Armor.Named.ghost_armor_named_02);
