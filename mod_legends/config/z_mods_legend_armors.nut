if (!("ArmorObjs" in ::Const.LegendMod))
{
	::Const.LegendMod.ArmorObjs <- [];
}

::Const.LegendMod.ArmorObjs.extend([{
	ID = "apron",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_apron"]
		],
		Chain = [
		],
		Plate = [
			[12, ""],
			[1, "plate/legend_armor_leather_jacket"],
			[1, "plate/legend_armor_leather_jacket_simple"]
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "basic_mail_shirt",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_tunic_wrap"],
			[1, "cloth/legend_tunic_collar_thin"],
			[1, "cloth/legend_tunic_collar_deep"],
			[1, "cloth/legend_padded_surcoat"],
			[1, "cloth/legend_gambeson_plain"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"]
		],
		Plate = [
		],
		Cloak = [
			[5, ""],
			[1, "cloak/tabbed_hood"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "blotched_gambeson",
	Script = "",
	Sets = [{
		Cloth = [
			[10, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_gambeson_wolf"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "butcher_apron",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_apron_butcher"],
		],
		Chain = [
		],
		Plate = [
			[12, ""],
			[1, "plate/legend_armor_leather_jacket"],
			[1, "plate/legend_armor_leather_jacket_simple"]
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "coat_of_plates", //320 : 297 average, 65 + 110 + 170 + 10 = 355 absolute max, 240 absolute min
	Script = "",
	Sets = [{
		Cloth = [ //60
			[1, "cloth/legend_gambeson"], //65
			[5, "cloth/legend_padded_surcoat"] //55
			// [5, "cloth/legend_tunic"]
		],
		Chain = [ //66.25 if [2,""] removed : 44 with : 80 with commented things
			// [2, ""],
			//[1, "chain/legend_armor_mail_shirt"], //50
			// [1, "chain/legend_armor_mail_shirt_simple"], //25
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"] //80
		],
		Plate = [ //157 avg
			//[1, "plate/legend_armor_plate_chest"], //125
			[0, "plate/legend_armor_plate_chest_rotten"],
			[1, "plate/legend_armor_plate_cuirass"], //150
			[1, "plate/legend_armor_plate_full"], //160
			[1, "plate/legend_armor_plate_milanese"], //170
			[1, "plate/legend_armor_plate_krastenbrust"], //170
			[1, "plate/legend_armor_plate_triangle"] //170
		],
		Cloak = [
			[20, ""],
			[1, "cloak/legend_armor_cloak_common"]
		],
		Tabard = [

		],
		Attachments =[
		]
	}]
},{
	ID = "coat_of_scales", //300 : new max of 290ish, new avg of 240 ish,
	Script = "",
	Sets = [{
		Cloth = [ //60
			[1, "cloth/legend_gambeson"], //65
			[1, "cloth/legend_padded_surcoat"] //55
			// [1, "cloth/legend_tunic"] //20
		],
		Chain = [ //66.25 if [2,""] removed : 44 with : 80 with commented things
			// [2, ""], //0
			[1, "chain/legend_armor_mail_shirt"], //50
			// [1, "chain/legend_armor_mail_shirt_simple"], //25
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"] //80
		]
		Plate = [ //100
			[1, "plate/legend_armor_scale"],  //100
			[1, "plate/legend_armor_scale_coat"], //120
			[0, "plate/legend_armor_scale_coat_rotten"],
			[1, "plate/legend_armor_scale_shirt"] //85
		],
		Cloak = [ //1
			[20, ""],
			[1, "cloak/legend_armor_cloak_common"],
			[1, "cloak/tabbed_hood"],
			[1, "cloak/decorative_hood"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "cultist_leather_robe",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes"]
		],
		Chain = [
		],
		Plate = [
		   [1, "plate/legend_armor_cult_armor"]
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "decayed_coat_of_plates",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_robes"],
		],
		Chain = [
			[2, ""],
			[1, "chain/legend_armor_reinforced_worn_mail"],
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"],
			[1, "chain/legend_armor_rusty_mail_shirt"],
		],
		Plate = [
			[1, "plate/legend_armor_scale_coat_rotten"],
			[1, "plate/legend_armor_plate_chest_rotten"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "decayed_coat_of_scales",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_robes"],
		],
		Chain = [
			[2, ""],
			[1, "chain/legend_armor_reinforced_worn_mail"],
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"],
			[1, "chain/legend_armor_rusty_mail_shirt"],
		],
		Plate = [
			[1, "plate/legend_armor_scale_coat_rotten"],
			[1, "plate/legend_armor_plate_chest_rotten"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "decayed_reinforced_mail_hauberk",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_robes"],
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"],
			[1, "chain/legend_armor_reinforced_worn_mail"],
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"],
		],
		Plate = [
			[1, ""],
			[1, "chain/legend_armor_hauberk_sleevless"],
			[1, "chain/legend_armor_hauberk"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "footman_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson"],
			[1, "cloth/legend_padded_surcoat"],
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"], //85
			[1, "chain/legend_armor_mail_shirt"], //130
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"], //80
			[1, "chain/legend_armor_hauberk"], //95
			[1, "chain/legend_armor_short_mail"], //60
		],
		Plate = [
			[1, "plate/legend_armor_leather_riveted_light"],
		],
		Cloak = [
			[20, ""],
			[1, "cloak/legend_armor_cloak_common"],
			[1, "cloak/decorative_hood"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "gambeson",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "heavy_lamellar_armor", //285 ; 262 avg
	Script = "",
	Sets = [{
		Cloth = [ //avg of 60
			[1, "cloth/legend_gambeson"], // 65
			[1, "cloth/legend_padded_surcoat"] //55
		],
		Chain = [ //77avg
			[1, "chain/legend_armor_basic_mail"], //85
			[1, "chain/legend_armor_mail_shirt"], //50
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"], //80
			[1, "chain/legend_armor_short_mail"] //60
		],
		Plate = [//125
			[1, "plate/legend_armor_leather_lamellar_harness_heavy"], //130
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], //150
			[1, "plate/legend_armor_leather_lamellar_heavy"], //165
			[1, "plate/legend_armor_leather_lamellar_reinforced"] //55
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
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
		Attachments =[
		]
	}]
},{
	ID = "lamellar_harness",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_padded_surcoat"]
		],
		Chain = [
			[1, ""],
			[1, "chain/legend_armor_basic_mail"],
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"],
			[1, "chain/legend_armor_short_mail"],
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar"],
			[1, "plate/legend_armor_leather_lamellar_harness_heavy"],
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"],
			[1, "plate/legend_armor_leather_lamellar_heavy"],
			[1, "plate/legend_armor_leather_lamellar_reinforced"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "leather_lamellar",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_padded_surcoat"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"],
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar"], //50
			[1, "plate/legend_armor_leather_lamellar_reinforced"], //55
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "leather_scale_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[1, "cloth/legend_padded_surcoat"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"],
		],
		Plate = [
			[1, "plate/legend_armor_leather_scale"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "noble_scale_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[1, "cloth/legend_padded_surcoat"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"],
		],
		Plate = [
			[1, "plate/legend_noble_scale"],
		],
		Cloak = [
			[20, ""],
			[1, "cloak/dukes_cloak"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "leather_tunic",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket"],
			[1, "plate/legend_armor_leather_jacket_simple"],
		],
		Cloak = [
			[20, ""],
			[1, "cloak/tabbed_hood"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "leather_wraps",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic"],
		],
		Chain = [
		],
		Plate = [
			[15, ""],
			[1, "plate/legend_armor_leather_jacket"],
			[5, "plate/legend_armor_leather_jacket_simple"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_blacksmith_apron",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_apron"],
		],
		Chain = [
		],
		Plate = [
			[15, ""],
			[1, "plate/legend_armor_leather_jacket"],
			[5, "plate/legend_armor_leather_jacket_simple"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_crusader_armor",
	Script = "scripts/items/legend_armor/armor/legend_armor_crusader",
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
		Attachments =[
		]
	}]
},{
	ID = "legend_herbalist_robe",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "monk_robe",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_maid_apron",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_apron"],
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_tunic"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_maid_dress",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_peasant_dress"],
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_tunic"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_nun_robe_dark",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes_nun"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_nun_robe_light",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes_nun"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_rabble_fur",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "armor/legend_armor_rabble_fur"]
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_rabble_tunic",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_ranger_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "armor/legend_armor_ranger"]
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_seer_robes",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes"],
			[1, "cloth/legend_robes_magic"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_taxidermist_apron",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_apron"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_vala_cloak",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "armor/legend_armor_vala_cloak"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "legend_vala_dress",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "armor/legend_armor_vala_dress"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
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
		Attachments =[
		]
	}]
},{
	ID = "legend_warlock_cloak",
	Script = "scripts/items/armor/legend_warlock_cloak",
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
		Attachments =[
		]
	}]
},{
	ID = "light_scale_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic"],
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_scale"],
			[1, "plate/legend_armor_scale_shirt"],
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "linen_tunic",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "mail_hauberk", // 120-180
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson"], //65
			[1, "cloth/legend_padded_surcoat"], //55
			//[1, "cloth/legend_tunic"], //20
		],
		Chain = [
			[1, ""],
			[1, "chain/legend_armor_hauberk"], //95
			[1, "chain/legend_armor_hauberk_full"], //115
			[1, "chain/legend_armor_hauberk_sleevless"], //65
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/decorative_hood"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "mail_shirt",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"],
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "necromancer_robes",
	Script = "scripts/items/armor/legend_necromancer_robes",
	Sets = [{
		Cloth = [
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/cursed_cloak"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "noble_gear",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic_noble"]
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_noble_shawl"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "noble_mail_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic_noble"]
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_sleevless"],
			[1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_short_mail"],
		],
		Plate = [
			[1, "plate/legend_armor_leather_noble"],
		],
		Cloak = [
			[10, ""],
			[2, "cloak/legend_noble_shawl"],
			[1, "cloak/legend_sash"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "noble_tunic",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic_noble"]
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/legend_noble_shawl"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "padded_leather", // 80
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_apron"], // 30
			[1, "cloth/legend_dark_tunic"], // 35
			[1, "cloth/legend_padded_surcoat"], // 55
			[1, "cloth/legend_thick_tunic"], // 30
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_leather_padded"], // 40
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "padded_surcoat", // 50
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[10, ""],
			[1, "cloak/decorative_hood"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "patched_mail_shirt", // 90
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_gambeson_wolf"], // 70
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50
			[1, "chain/legend_armor_mail_shirt_simple"], // 25
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ragged_dark_surcoat", // 60
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_dark_tunic"], // 35
			[1, "cloth/legend_thick_tunic"], // 30
		],
		Chain = [
		],
		Plate = [
			[10, ""],
			[3, "plate/legend_animal_hide_armor"], // 30
			[3, "plate/legend_armor_leather_jacket"], // 25
		//(this is an error)	[1, "plate/legend_armor_leather_jacket_named"], // 30
		],
		Cloak = [
			[10, ""],
			[1, "cloak/tabbed_hood"],
			[1, "cloak/legend_dark_wooly_cloak"],
			[1, "cloak/fur_cloak"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ragged_surcoat", // 55
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic"], // 20
		],
		Chain = [
			[2, ""],
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20
		],
		Plate = [
			[1, "plate/legend_armor_leather_jacket"], // 25
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "reinforced_mail_hauberk", // 210
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[4, "chain/legend_armor_hauberk"], // 95
			[1, "chain/legend_armor_hauberk_full"], // 115
		],
		Plate = [
			[1, "plate/legend_armor_leather_brigandine"], // 65
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "adorned_warriors_armor", // 210
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[4, "chain/legend_armor_hauberk"], // 95
			[1, "chain/legend_armor_hauberk_full"], // 115
		],
		Plate = [
			[1, "plate/legend_armor_leather_riveted"], //
			[1, "plate/legend_armor_leather_riveted_light"], //
		],
		Cloak = [
			[1, "cloak/relic_hood"], //
		],
		Tabard = [
		],
		Attachments =[
			[1, "armor_upgrades/legend_armor_chain_and_mail_upgrade"], //
			[1, "armor_upgrades/legend_armor_sacred_shield_upgrade"], //
		]
	}]
},{
	ID = "sackcloth", // 10
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth"], // 10
			[1, "cloth/legend_sackcloth_patched"], // 15
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "scale_armor", // 240
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_sleevless"], // 65
			[1, "chain/legend_armor_mail_shirt"], // 50
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
			[1, "chain/legend_armor_rusty_mail_shirt"], // 20
			[1, "chain/legend_armor_short_mail"], // 60
		],
		Plate = [
			[1, "plate/legend_armor_scale"], // 100
			[1, "plate/legend_armor_scale_coat"], // 120
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "sellsword_armor", // 260
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"], // 95
			[1, "chain/legend_armor_hauberk_full"], // 115
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80
			[1, "chain/legend_armor_reinforced_worn_mail"], // 105
		],
		Plate = [
			 [1, "plate/legend_armor_leather_riveted"], // 95
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "tattered_sackcloth", // 5
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth_tattered"], // 5
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "thick_dark_tunic", // 35
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_dark_tunic"], // 35
			[1, "cloth/legend_thick_tunic"], // 30
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "thick_tunic", // 35
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_thick_tunic"], // 30
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "werewolf_hide_armor", // 100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_wolf"], // 70
		],
		Chain = [
		],
		Plate = [
			[10, ""],
			[5, "plate/legend_animal_hide_armor"], // 30
			[4, "plate/legend_armor_leather_jacket"], // 25
			// [1, "plate/legend_armor_leather_jacket_named"], // 30
			[4, "plate/legend_armor_leather_jacket_simple"], // 15
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
			[1, "armor_upgrades/legend_direwolf_pelt_upgrade"], // 10
		]
	}]
},{
	ID = "werewolf_mail_armor", // 140
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_wolf"], // 70
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"], // 85
			[1, "chain/legend_armor_hauberk_sleevless"], // 65
			[1, "chain/legend_armor_mail_shirt"], // 50
			[1, "chain/legend_armor_reinforced_mail_shirt"], // 80
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
			[1, "chain/legend_armor_short_mail"], // 60
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
			[1, "armor_upgrades/legend_direwolf_pelt_upgrade"], // 10
		]
	}]
},{
	ID = "wizard_robe", // 20
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes_magic"], // 40
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "beautiful_robe", // 20
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes_wizard"], // 40
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "worn_mail_shirt", // 110
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "seedmaster_noble_armor", // 110
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_robes"],
			[1, "cloth/legend_tunic_noble"]
		],
		Chain = [
			[4, "chain/legend_armor_mail_shirt"], // 50
			[2, "chain/legend_armor_reinforced_mail"], // 50
			[4, "chain/legend_armor_reinforced_mail_shirt"]

		],
		Plate = [
			[4, "plate/legend_armor_leather_riveted_light"],
			[6, "plate/legend_armor_leather_scale"],
			[6, "plate/legend_armor_scale_shirt"]
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
			[15, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_metal_pauldrons_upgrade"]
		]
	}]
},{
	ID = "citreneking_noble_armor", // 110
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"],
			[1, "cloth/legend_robes"],
			[1, "cloth/legend_tunic_noble"]
		],
		Chain = [
			[4, "chain/legend_armor_basic_mail"], // 50
			[2, "chain/legend_armor_reinforced_mail"], // 50
			[4, "chain/legend_armor_reinforced_mail_shirt"]

		],
		Plate = [
			[4, ""],
			[1, "plate/legend_armor_leather_riveted"],
			[1, "plate/legend_armor_leather_riveted_light"]
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
			[5, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_joint_cover_upgrade"]
		]
	}]
},{
	ID = "legend_noble_guard_armour",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic_noble"],
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"],
		],
		Plate = [
			[1, "plate/legend_armor_plate_krastenbrust"],
			[1, "plate/legend_armor_plate_full"],
		],
		Cloak = [
			[3, ""],
			[1, "cloak/legend_armor_cloak_heavy"],
		],
		Tabard = [
		[2, "tabard/legend_noble_tabard"],
		],
		Attachments =[
		]
	}]

},{
	ID = "man_at_arms_noble_armor",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_named"]
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"],
			[1, "chain/legend_armor_hauberk_full"]

		],
		Plate = [
			[1, "plate/legend_armor_plate_milanese"],
			[1, "plate/legend_armor_plate_triangle"],
			[1, "plate/legend_armor_plate_full_greaves"],
		],
		Cloak = [
		[2, ""],
		[2, "cloak/legend_armor_cloak_noble"],
		],
		Tabard = [
		[2, "tabard/legend_noble_tabard"],
		],
		Attachments =[
			[5, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_joint_cover_upgrade"]
		]
	}]
},{
	ID = "brown_hedgeknight_armor", // 292
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"]
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"]

		],
		Plate = [
			[1, "plate/legend_armor_plate_chest"]
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_southern_wrap_left", 6]
		],
		Attachments =[
			[1, "armor_upgrades/legend_double_mail_upgrade"]
		]
	}]
},{
	ID = "red_bandit_leader_armor", // 215
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat_plain", 41],
			[1, "cloth/legend_padded_surcoat_plain", 17]
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"]
		],
		Plate = [
			[1, "plate/legend_armor_scale"]
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_southern_wrap_left", 6]
		],
		Attachments =[
			[1, "armor_upgrades/legend_mail_patch_upgrade"]
		]
	}]
},{
	ID = "southern_knight_armor", // 215
	Script = "",
	Sets = [{
		Cloth = [
			[10, "cloth/legend_southern_robe"],
			[10, "cloth/legend_southern_split_gambeson"],
			[10, "cloth/legend_southern_gambeson"],
			[5, "cloth/legend_southern_tunic"],
			[5, "cloth/legend_gambeson"],
			[2, "cloth/legend_gambeson_plain"],
			[2, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_southern_mail"]
		],
		Plate = [
			[1, "plate/legend_southern_plate_full"]
		],
		Cloak = [
			[1, ""],
			[1, "cloak/legend_southern_scarf"],
			[1, "cloak/legend_animal_pelt"],
			[1, "cloak/legend_southern_scarf_wrap"]
		],
		Tabard = [
			[3, ""],
			[2, "tabard/legend_southern_wrap_left"],
			[1, "tabard/legend_southern_wrap"],
			[1, "tabard/legend_southern_shoulder_cloth"]
		],
		Attachments =[
			[6, ""],
			[4, "armor_upgrades/legend_mail_patch_upgrade"]
		]
	}]
},{
	ID = "northern_mercenary_armor_00", // heavier than 01 ~200
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[2, "cloth/legend_gambeson_plain"],
			[5, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"],
			[1, "chain/legend_armor_hauberk_full"]
		],
		Plate = [
			[8, ""],
			[1, "plate/legend_armor_scale_coat_rotten"],
			[1, "plate/legend_armor_scale_shirt"]
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_shoulder_cloth", 2]
		],
		Tabard = [

		],
		Attachments =[
			[0, ""],
			[4, "armor_upgrades/legend_double_mail_upgrade"],
			[4, "armor_upgrades/legend_direwolf_pelt_upgrade"]
		]
	}]
},{
	ID = "traze_northern_mercenary_armor", // around 240
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[2, "cloth/legend_gambeson_plain"],
			[5, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_armor_hauberk"],
			[1, "chain/legend_armor_hauberk_full"],
		],
		Plate = [
			[1, "plate/legend_armor_plate_cuirass"],
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_shoulder_cloth"],
		],
		Tabard = [

		],
		Attachments =[
		]
	}]
},{
	ID = "northern_mercenary_armor_01", // lighter than 00 ~170
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[2, "cloth/legend_gambeson_plain"],
			[5, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"],
			[1, "chain/legend_armor_reinforced_mail_shirt"],
			[1, "chain/legend_armor_reinforced_worn_mail"]
		],
		Plate = [
			[0, "plate/legend_southern_plate_full"]
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_shoulder_cloth", 2]
		],
		Tabard = [

		],
		Attachments =[
			[0, ""],
			[4, "armor_upgrades/legend_metal_plating_upgrade"],
			[4, "armor_upgrades/legend_leather_shoulderguards_upgrade"]
		]
	}]
},{
	ID = "northern_mercenary_armor_02", // ~~250
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[2, "cloth/legend_gambeson_plain"],
			[5, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"],
			[1, "chain/legend_armor_reinforced_mail_shirt"],
			[1, "chain/legend_armor_reinforced_worn_mail"]
		],
		Plate = [
			[0, "plate/legend_southern_plate_full"]
		],
		Cloak = [
			[1, ""],
			[2, "cloak/legend_shoulder_cloth", 2]
		],
		Tabard = [

		],
		Attachments =[
			[0, ""],
			[4, "armor_upgrades/legend_metal_plating_upgrade"],
			[4, "armor_upgrades/legend_leather_shoulderguards_upgrade"]
		]
	}]
},{
	ID = "barbarian_chosen_armor_00", // ~~186
	Script = "",
	Sets = [{
		Cloth = [
			[2, "cloth/legend_gambeson"],
			[5, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"]
		],
		Plate = [
			[1, "plate/legend_hide_and_bone_armor"]
		],
		Cloak = [
		],
		Tabard = [

		],
		Attachments =[
			[0, ""],
			[4, "armor_upgrades/legend_bone_platings_upgrade"]
		]
	}]
},
{
	ID = "barbarian_chosen_armor_01", // ~~186
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson"],
			[4, "cloth/legend_padded_surcoat"],
			[4, "cloth/legend_padded_surcoat_plain"],
			[1, "cloth/legend_gambeson_wolf"]
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"],
			[1, "chain/legend_armor_ancient_double_mail", 1],
		],
		Plate = [
			[1, "plate/legend_scrap_metal_armor"],
			[1, "plate/legend_rugged_scale_armor"],
			[1, "plate/legend_heavy_iron_armor"],
		],
		Cloak = [
			[1, ""],
			[1, "cloak/legend_dark_wooly_cloak", 13],
			[1, "cloak/legend_southern_scarf", 7],
			[1, "cloak/legend_southern_scarf", 6],
			[1, "cloak/legend_southern_scarf", 13],
		],
		Tabard = [
			[1, "tabard/legend_southern_shoulder_cloth", 7],
			[1, "tabard/legend_southern_wrap"],
		],
		Attachments =[
			[4, ""],
			[1, "armor_upgrades/legend_bone_platings_upgrade"],
			[1, "armor_upgrades/legend_direwolf_pelt_upgrade"],
		]
	}]
},
{
	ID = "brown_monk_armor_00", // ~~186
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_robes", 1]
		],
		Chain = [
		],
		Plate = [
			[2, ""],
			[1, "plate/legend_armor_leather_jacket_simple"]
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_southern_wrap_left", 6],
			[1, "tabard/legend_southern_shoulder_cloth", 7],
			[1, "tabard/legend_southern_shoulder_cloth", 6]
		],
		Attachments =[
			[9, ""],
			[1, "armor_upgrades/legend_leather_neckguard_upgrade"]
		]
	}]
},
{
	ID = "dark_southern_armor_00", // ~~186
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_tunic_wrap"],
			[1, "cloth/legend_tunic_collar_thin"],
			[1, "cloth/legend_tunic_collar_deep"]
		],
		Chain = [
			[1, "chain/legend_armor_short_mail"]
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_animal_pelt", 4]
		],
		Tabard = [
			[1, "tabard/legend_southern_overcloth"]
		],
		Attachments =[
		]
	}]
},
{
	ID = "citrene_nomad_cutthroat_armor_00", // ~~160-195
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_southern_tunic"],// 25
		],
		Chain = [
		],
		Plate = [
			[5, "plate/legend_armor_leather_lamellar_harness_heavy"],// 130
			[3, "plate/legend_armor_leather_lamellar_reinforced"],// 150
			[1, "plate/legend_armor_leather_lamellar_heavy"],// 165
		],
		Cloak = [
			[0, "cloak/legend_southern_scarf_wrap"],// 15
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "citrene_nomad_cutthroat_armor_01", // ~~177
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_southern_gambeson"],// 65
			[1, "cloth/legend_southern_split_gambeson"],// 65
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_chest_restored"],// 110
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_southern_wrap_right"],// 2
			[1, "tabard/legend_southern_wrap_left"],// 2
		],
		Attachments =[
		]
	}]
},
{
	ID = "citrene_nomad_leader_armor_00", // ~~165 ish
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gladiator_harness"],// 40
		],
		Chain = [
			[0, "chain/legend_southern_mail"],// 100
		],
		Plate = [
			[1, "plate/legend_southern_arm_guards"],
		],
		Cloak = [
		],
		Tabard = [
			[2, "tabard/legend_noble_vest"],// 10
			[1, "tabard/legend_southern_wrap"],// 5
			[1, "tabard/legend_southern_shoulder_cloth"],// 5
			[1, "tabard/legend_southern_overcloth"],// 10
		],
		Attachments =[
		]
	}]
},
{
	ID = "white_nomad_leader_armor_00", // ~~186
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_thick_tunic"],
			[1, "cloth/legend_tunic"],
			[1, "cloth/legend_tunic_wrap"],
			[1, "cloth/legend_tunic_collar_thin"],
			[1, "cloth/legend_tunic_collar_deep"]
		],
		Chain = [
			[1, "chain/legend_southern_mail"],
		],
		Plate = [

			[1, "plate/legend_armor_leather_lamellar_harness_heavy"], //130
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], //150
			[1, "plate/legend_southern_scale"],// 155
		],
		Cloak = [
			[3, ""],
			[1, "cloak/legend_southern_scarf"],// 5
		],
		Tabard = [
			[2, ""],
			[1, "tabard/legend_southern_shoulder_cloth"],// 5
			[1, "tabard/legend_southern_wrap"],// 5
			[1, "tabard/legend_southern_shoulder_cloth"],// 5
		],
		Attachments =[
		]
	}]
},
{
	ID = "theamson_nomad_outlaw_armor", // ~~145-175
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_southern_tunic"],
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full"],
		],
		Plate = [
			[1, "plate/legend_southern_arm_guards"],
		],
		Cloak = [
			[1, "cloak/legend_shoulder_cloth"],// 5
		],
		Tabard = [
			[1, "tabard/legend_southern_shoulder_cloth"],// 5
		],
		Attachments =[
		]
	}]
},
{
	ID = "theamson_nomad_leader_armor_heavy", // ~~210-240-280
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_southern_tunic"],
		],
		Chain = [
			[1, "chain/legend_armor_basic_mail"],
		],
		Plate = [
			[1, "plate/legend_southern_leather_plates"],
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_southern_shoulder_cloth"],// 5
		],
		Attachments =[
		]
	}]
},
{
	ID = "indebted_armor_rags", // ~~BOSS OF THIS GYM
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_sackcloth_patched"],
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, ""],

		],
		Tabard = [
			[1, "tabard/legend_southern_wrap_left"],
			[1, "tabard/legend_southern_wrap_right"],
			[1, "tabard/legend_southern_wrap"],// 5
			[1, "tabard/legend_southern_shoulder_cloth"],// 5
		],
		Attachments =[
		]
	}]
},
{
	ID = "special/heraldic_armor", // 250
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
		],
		Chain = [
			[1, "chain/legend_armor_hauberk_full"], // 115
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_tabard"], // 10
		],
		Attachments =[
		]
	}]
},{
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
		Attachments =[
		]
	}]
},{
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
		Attachments =[
		]
	}]
},{
	ID = "adorned_heavy_mail_hauberk", //
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], // 65
			[1, "cloth/legend_padded_surcoat"], // 55
		],
		Chain = [
			[4, "chain/legend_armor_hauberk"], // 95
			[1, "chain/legend_armor_hauberk_full"], // 115
		],
		Plate = [
			[1, "plate/legend_heavy_mail"], //
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		//	[1, "armor_upgrades/legend_armor_chain_and_mail_upgrade"], //
		//	[1, "armor_upgrades/legend_armor_sacred_shield_upgrade"], //
		]
	}]
},{
	ID = "adorned_mail_shirt",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_knightly_robe"], //
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], //50
			[1, "chain/legend_armor_mail_shirt_simple"], //25
		],
		Plate = [
			[1, "plate/legend_southern_padded"], //
			[1, "plate/legend_armor_leather_padded"], //
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
			[1, "armor_upgrades/legend_armor_spiked_collar_upgrade"], //
		]
	}]
},{
	ID = "reinforced_leather_tunic",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/anatomist_robe"], //
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/anatomist_hood"], //
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "undertaker_apron",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_gambeson_plain"], //65
		],
		Chain = [
		],
		Plate = [
			[1, "plate/undertakers_apron"], //65
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "wanderers_coat",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/wanderers_coat"], //
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_religious_scarf"], //
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "lonewolf_longsword_armour",
	Script = "scripts/items/armor/lonewolf_longsword_armour",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], //55
			[1, "cloth/legend_gambeson_plain"], //65
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], //50
			[1, "chain/legend_armor_mail_shirt_simple"], //25
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar"], //50
		],
		Cloak = [
		],
		Tabard = [
			[2, "tabard/legend_noble_vest"],
		],
		Attachments =[
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
		]
	}]
},{
	ID = "lonewolf_hammershield_armour",
	Script = "scripts/items/armor/lonewolf_hammershield_armour",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"],
			[1, "cloth/legend_gambeson_plain"],
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], //50
		],
		Plate = [
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_southern_shoulder_cloth"],
		],
		Attachments =[
		]
	}]
},{
	ID = "lonewolf_axebuckler_armour",
	Script = "scripts/items/armor/lonewolf_axebuckler_armour",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"],
			[1, "cloth/legend_gambeson_plain"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], //25
		],
		Plate = [
			[1, "plate/legend_armor_leather_lamellar_harness_reinforced"], //55
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
			[1, "armor_upgrades/legend_direwolf_pelt_upgrade"],
		]
	}]
},{
	ID = "lonewolf_crossbowsword_armour",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"],
			[1, "cloth/legend_robes"],
			[1, "cloth/legend_tunic"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], //25
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_shoulder_cloth"],
		],
		Tabard = [
			[1, "tabard/legend_southern_shoulder_cloth"],
		],
		Attachments =[
		]
	}]

},{
	ID = "lonewolf_bowdagger_armour",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_tunic_noble"],
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"],
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_crusader"],
		],
		Tabard = [
		],
		Attachments =[
		]
	}]

},{
	ID = "lonewolf_polearm_armour",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], //55
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt_simple"], //25
		],
		Plate = [
			[1, "plate/legend_armor_plate_chest"], //125
		],
		Cloak = [
			[1, "cloak/legend_southern_scarf"],
		],
		Tabard = [
			[1, "tabard/legend_common_tabard"],
		],
		Attachments =[
		]
	}]
},{
	ID = "bandit_armor_light",
	Script = "", //~90-175
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], //55
			[1, "cloth/legend_gambeson_plain"], //65
		],
		Chain = [
			[3, "chain/legend_armor_mail_shirt_simple"], //25
			[3, "chain/legend_armor_rusty_mail_shirt"], // 20
			[2, "chain/legend_armor_mail_shirt"], //50
			[1, "chain/legend_armor_reinforced_mail_shirt"], //80
			[2, "chain/legend_armor_short_mail"], //60
			[4, ""], //0
		],
		Plate = [
			[1, "plate/legend_armor_leather_padded"], // 40
			[2, ""], //0
		],
		Cloak = [
		],
		Tabard = [
			[1, "tabard/legend_common_tabard"], //5
			[2, ""], //0
		],
		Attachments =[
		]
	}]
},{
	ID = "bandit_armor_medium",
	Script = "", //~140-165
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], //55
			[1, "cloth/legend_gambeson_plain"], // 65
		],
		Chain = [
			[1, "chain/legend_armor_mail_shirt"], // 50
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"], //80
			[1, "chain/legend_armor_short_mail"], //60
			[1, "chain/legend_armor_basic_mail"], //85
			[1, "chain/legend_armor_hauberk"], //95
			[1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
		],
		Plate = [
			[2, "plate/legend_armor_scale_coat_rotten"], //60
			[2, "plate/legend_armor_leather_lamellar"], //50
			[2, "plate/legend_armor_leather_padded"], // 40
			[2, "plate/legend_armor_leather_lamellar_reinforced"], //55
			[1, "plate/legend_armor_scale_shirt"], //85
			[2, ""], //0
			[2, "plate/legend_armor_leather_lamellar_reinforced"], //55
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_common"], //10
			[1, ""], //0
		],
		Tabard = [
			[1, "tabard/legend_common_tabard"], //5
			[1, ""], //0
		],
		Attachments =[
			[15, ""],
			[5, "armor_upgrades/legend_leather_neckguard_upgrade"],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
		]
	}]
},{
	ID = "bandit_armor_heavy",
	Script = "", //~230-315
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], //55
			[1, "cloth/legend_gambeson_plain"], // 65
		],
		Chain = [
			[2, "chain/legend_armor_hauberk"], //95
			[2, "chain/legend_armor_basic_mail"], //85
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_hauberk_full"], //115
		],
		Plate = [
			[2, "plate/legend_armor_plate_chest"], //125
			[1, "plate/legend_armor_plate_cuirass"], //150
			[2, "plate/legend_armor_scale"], //100
			[2, "plate/legend_armor_scale_coat_rotten"], //60
			[1, "plate/legend_armor_scale_coat"], //120
			[2, "plate/legend_armor_leather_lamellar_harness_heavy"], //130
			[1, "plate/legend_armor_leather_lamellar_reinforced"], //150
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_common"], //10
			[1, ""], //0
		],
		Tabard = [
			[1, "tabard/legend_common_tabard"], //5
			[1, ""], //0
		],
		Attachments =[
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[15, ""],
		]
	}]
},{
	ID = "bandit_armor_ultraheavy",
	Script = "", //~255-375
	Sets = [{
		Cloth = [
			[1, "cloth/legend_padded_surcoat"], //55
			[1, "cloth/legend_gambeson_wolf"], // 70
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_hauberk"], //95
			[1, "chain/legend_armor_reinforced_mail_shirt"], //80
			[1, "chain/legend_armor_hauberk_full"], //115
		],
		Plate = [
			[1, "plate/legend_armor_plate_cuirass"], //150
			[1, "plate/legend_armor_plate_full"], //160
			[1, "plate/legend_armor_leather_lamellar_heavy"], //165
			[1, "plate/legend_armor_plate_milanese"], //170
			[1, "plate/legend_armor_plate_krastenbrust"], //170
			[1, "plate/legend_armor_plate_triangle"], //170
			[1, "plate/legend_armor_leather_lamellar_reinforced"], //150
			[1, "plate/legend_armor_leather_lamellar_heavy"], //165
		],
		Cloak = [
			[1, "cloak/legend_armor_cloak_common"], //10
			[1, ""], //0
		],
		Tabard = [
		],
		Attachments =[
			[15, ""],
			[5, "armor_upgrades/legend_mail_patch_upgrade"],
			[2, "armor_upgrades/legend_metal_pauldrons_upgrade"],
		]
	}]

},
{
	ID = "mercury_noble_elite_footman_00",
	Script = "",
	Sets = [{
		Cloth = [[1, "cloth/legend_gambeson", 1]],
		Chain = [[1, "chain/legend_armor_hauberk_sleevless", 1]],
		Plate = [[1, "plate/legend_armor_leather_scale", 1]],
		Cloak = [[1, "cloak/tabbed_hood"]],
		Tabard = [[1, "tabard/legend_noble_tabard"]],
		Attachments = [[2, ""], [1, "armor_upgrades/legend_metal_plating_upgrade", 0], [1, "armor_upgrades/legend_pauldron_swan_upgrade"], [1, "armor_upgrades/legend_armor_spiked_collar_upgrade", 0]],
	}]
},
{
ID = "mercury_sureshot_00",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_gambeson", 2]],
Chain = [[1, "chain/legend_armor_hauberk_sleevless", 1]],
Plate = [[1, "plate/legend_armor_leather_jacket_simple", 6]],
Cloak = [[1, ""]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_sureshot_01",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_robes", 11]],
Chain = [[1, "chain/legend_armor_mail_shirt_simple", 1]],
Plate = [[1, "plate/legend_armor_leather_lamellar", 1]],
Cloak = [[1, "cloak/legend_armor_cloak_common", 21]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_sureshot_02",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_robes", 11]],
Chain = [[1, "chain/legend_armor_mail_shirt_simple", 1]],
Plate = [[1, "plate/legend_armor_leather_scale", 1], [1, "plate/legend_armor_leather_riveted_light", 1]],
Cloak = [[1, ""], [1, "cloak/legend_shoulder_cloth", 2], [1, "cloak/fur_cloak", 1]],
Tabard = [[1, "tabard/legend_noble_tabard", 3]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_pollax_00",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_gambeson", 2]],
Chain = [[1, "chain/legend_armor_hauberk_sleevless", 1]],
Plate = [[1, "plate/legend_armor_leather_lamellar", 1]],
Cloak = [[1, "cloak/fur_cloak", 4]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[3, ""], [1, "armor_upgrades/legend_metal_plating_upgrade", 0], [1, "armor_upgrades/legend_pauldron_swan_upgrade"], [1, "armor_upgrades/legend_armor_spiked_collar_upgrade", 0]],
}]
},
{
ID = "mercury_pollax_01",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_knightly_robe", 7]],
Chain = [[1, "chain/legend_armor_mail_shirt_simple", 1]],
Plate = [[1, "plate/legend_armor_scale_shirt", 1]],
Cloak = [[1, "cloak/decorative_hood", 8], [1, "cloak/legend_shoulder_cloth", 2]],
Tabard = [[1, "tabard/legend_common_tabard"]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_sureshot_green_00",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_robes", 14]],
Chain = [[1, ""]],
Plate = [[1, "plate/legend_armor_leather_riveted", 5]],
Cloak = [[1, "cloak/legend_armor_cloak_heavy", 24]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_sureshot_blue_00",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_thick_tunic", 10]],
Chain = [[1, ""]],
Plate = [[1, "plate/legend_armor_leather_lamellar_harness_reinforced", 1]],
Cloak = [[1, ""]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[2, ""], [1, "armor_upgrades/legend_leather_shoulderguards_upgrade"]],
}]
},
{
ID = "mercury_pollax_colorful_00",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_tunic_noble", 9]],
Chain = [[1, "chain/legend_armor_reinforced_mail_shirt", 1]],
Plate = [[1, "plate/legend_armor_scale", 1], [1, "plate/legend_armor_leather_brigandine", 1]],
Cloak = [[1, "cloak/decorative_hood"]], //8 for only black
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_pollax_colorful_01",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_tunic_noble", 9]],
Chain = [[1, "chain/legend_armor_reinforced_worn_mail", 1]],
Plate = [[1, "plate/legend_southern_arm_guards", 1]],
Cloak = [[1, "cloak/decorative_hood", 8]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[1, ""]],
}]
},
{
ID = "mercury_royal_guard_00",
Script = "",
Sets = [{
Cloth = [[1, "cloth/legend_gambeson_plain", 1]],
Chain = [[1, "chain/legend_armor_hauberk_sleevless", 1], [1, "chain/legend_armor_short_mail", 1]],
Plate = [[1, "plate/legend_armor_leather_brigandine_hardened_full", 1], [1, "plate/legend_armor_leather_riveted"], [1, "plate/legend_armor_scale_shirt", 1], [1, "plate/legend_armor_leather_brigandine", 1]],
Cloak = [[1, ""]],
Tabard = [[1, "tabard/legend_noble_tabard"]],
Attachments = [[3, ""], [1, "armor_upgrades/legend_leather_neckguard_upgrade", 0], [1, "armor_upgrades/legend_double_mail_upgrade", 0], [1, "armor_upgrades/legend_leather_shoulderguards_upgrade", 0]],
}]
},
{
	ID = "grand_diviner_robes",
	Script = "scripts/items/legend_armor/armor/golems/legend_grand_diviner_robes",
	Sets = []
},
{
	ID = "fault_finder_robes",
	Script = "scripts/items/legend_armor/armor/golems/legend_fault_finder_robes",
	Sets = []
}
]);

::Const.LegendMod.Armors <- {};

foreach( i, v in ::Const.LegendMod.ArmorObjs )
{
	::Const.LegendMod.Armors[v.ID] <- v;
}

