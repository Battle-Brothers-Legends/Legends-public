if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

if (!("ArmorObjs" in ::Const.LegendMod))
{
	::Const.LegendMod.ArmorObjs <- [];
}

::Const.LegendMod.ArmorObjs.extend([
{
	ID = "ancient/ancient_breastplate", // 135
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_chest"], // 105
			[1, "plate/legend_armor_plate_ancient_chest_restored"], // 110
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/ancient_double_layer_mail", // 120
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_double_mail"], // 80
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
	//TODO
	ID = "ancient/ancient_lich_attire", // 60
	Script = "scripts/items/armor/ancient/ancient_lich_attire",
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
	ID = "ancient/ancient_mail", // 100
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_mail"], // 45
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/ancient_plated_mail_hauberk", // 180
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_chest"], // 105
			[1, "plate/legend_armor_plate_ancient_chest_restored"], // 110
			[1, "plate/legend_armor_plate_ancient_scale"], // 105
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/ancient_plated_scale_hauberk", // 210
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_scale_coat"], // 140

		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/ancient_plate_harness", // 200
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_double_mail"], // 80
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_harness"], // 115
			[1, "plate/legend_armor_plate_ancient_scale_harness"], // 75
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/ancient_priest_attire", // 40
	Script = "scripts/items/armor/ancient/ancient_priest_attire",
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
	ID = "ancient/ancient_ripped_cloth", // 25
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
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
	ID = "ancient/ancient_scale_coat", // 190
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_chest"], // 105
			[1, "plate/legend_armor_plate_ancient_chest_restored"], // 110
			[1, "plate/legend_armor_plate_ancient_harness"], // 115
			[1, "plate/legend_armor_plate_ancient_scale"], // 105
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/ancient_scale_harness", // 125
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth"], // 30
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "plate/legend_armor_plate_ancient_scale_harness"], // 75
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},{
	ID = "ancient/legend_mummy_dress", // 10
	Script = "scripts/items/armor/ancient/legend_mummy_dress",
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
	ID = "ancient/legend_mummy_plate", // 10
	Script = "scripts/items/armor/ancient/legend_mummy_plate",
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
	ID = "ancient/legend_mummy_bandages", // 10
	Script = "scripts/items/armor/ancient/legend_mummy_bandages",
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
	ID = "ancient/legend_mummy_plate", // 10
	Script = "scripts/items/armor/ancient/legend_mummy_plate",
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
	ID = "legend_armor_plate_ancient_scale_coat_restored", // 10
	Script = "scripts/items/armor/ancient/legend_armor_plate_ancient_scale_coat_restored",
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
	ID = "legend_armor_plate_ancient_scale_harness_restored", // 10
	Script = "scripts/items/armor/ancient/legend_armor_plate_ancient_scale_harness_restored",
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
	ID = "ancient/legend_mummy_royal_plate", // 10
	Script = "scripts/items/armor/ancient/legend_mummy_royal_plate",
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
}
])