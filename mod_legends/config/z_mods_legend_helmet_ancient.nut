if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

if (!("HelmObjs" in ::Const.LegendMod))
{
	::Const.LegendMod.HelmObjs <- [];
}

::Const.LegendMod.HelmObjs.extend([
{
	ID = "ancient/ancient_gladiator_helmet", //195, -11, -2,  1300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_cap"] //35, -1, 0
		],
		Helms = [
			[1, "helm/legend_helmet_legend_ancient_gladiator"] //160, -10, -2
		],
		Tops = [
		],
		Vanity = [
		]
	}]
},{
	ID = "ancient/legend_mummy_bandages",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mummy_bandage"]
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_mummy_beard"],
			[1, ""]
		],
		Vanity = [
		]
	}]
},{
	ID = "ancient/legend_mummy_crown",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mummy_bandage"]
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_mummy_mask"],
			[1, ""]
		],
		Vanity = [
			[1, "vanity/legend_helmet_mummy_crown"]
		]
	}]
},{
	ID = "ancient/legend_mummy_crown_king",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mummy_bandage"]
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_mummy_beard"],
			[1, ""]
		],
		Vanity = [
			[1, "vanity/legend_helmet_mummy_crown_king"]
		]
	}]
},{
	ID = "ancient/legend_mummy_headband",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mummy_bandage"]
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_mummy_headband"]
		]
	}]
},{
	ID = "ancient/legend_mummy_beard",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mummy_bandage"]
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_mummy_beard"]
		],
		Vanity = [
			[1, ""],
			[1, "vanity/legend_helmet_mummy_headband"]
		]
	}]
},{
	ID = "ancient/ancient_honorguard_helmet", //180, -13, -3   1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_cap"] //35, -1, 0
		],
		Helms = [
			[1, "helm/legend_helmet_ancient_conic_helm"],
			[1, "helm/legend_helmet_ancient_kettle"],
			[1, "helm/legend_helmet_ancient_dome"],
			[1, "helm/legend_helmet_ancient_crested"]
		],
		Tops = [
			[1, "top/legend_helmet_ancient_beard_mask"], 
			[1, "top/legend_helmet_ancient_lion_mask"],
			[1, "top/legend_helmet_ancient_mask"]
		],
		Vanity = [
		]
	},{
		Hoods = [
			[1, "hood/legend_helmet_rotten_chain_scarf"], //60, -2, 0
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
			[1, "hood/legend_helmet_leather_cap"] // 35, -1, 0
		],
		Helms = [
			[1, "helm/legend_helmet_ancient_face_helm"] //125, -11, -2
		],
		Tops = [
		],
		Vanity = [
		]
	}]
},{
	ID = "ancient/ancient_household_helmet", //95, -8, -1
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_cap"] //35, -1, 0
		],
		Helms = [
			[1, "helm/legend_helmet_ancient_conic_helm"],
			[1, "helm/legend_helmet_ancient_kettle"],
			[1, "helm/legend_helmet_ancient_dome"],
			[1, "helm/legend_helmet_ancient_crested"]
		],
		Tops = [
		],
		Vanity = [
		]
	}]
},{
	ID = "ancient/ancient_laurels",
	Script = "scripts/items/legend_helmets/helmets/legend_ancient_laurels",
	Sets = []
},{
	ID = "ancient/ancient_legionary_helmet", // 130, -10, -2
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_cap"] //35, -1, 0
		],
		Helms = [
			[1, "helm/legend_helmet_ancient_dome_tailed"],
			[1, "helm/legend_helmet_ancient_face_plate"],
			[1, "helm/legend_helmet_ancient_legionaire"],
			[1, "helm/legend_helmet_ancient_side_hawk"],
			[1, "helm/legend_helmet_ancient_tailed_conic_helm"]
		],
		Tops = [
		],
		Vanity = [
		[1, "vanity/legend_helmet_wreath"]
		]
	}]
},{
	ID = "ancient/ancient_priest_diadem",
	Script = "scripts/items/legend_helmets/helmets/legend_ancient_priest_diadem",
	Sets = []
},{
	ID = "ancient/legend_ancient_legionary_helmet_restored", //140, -8, -1
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_cap"] //35, -1, 0
		],
		Helms = [
			[1, "helm/legend_helmet_legend_ancient_legionaire_restored"] // 105, -7, -1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
},{
	ID = "ancient/ancient_wig",
	Script = "scripts/items/legend_helmets/helmets/legend_ancient_wig",
	Sets = []
},{
	ID = "ancient/ancient_lich_headpiece",
	Script = "scripts/items/legend_helmets/helmets/legend_ancient_lich_headpiece",
	Sets = []
}])