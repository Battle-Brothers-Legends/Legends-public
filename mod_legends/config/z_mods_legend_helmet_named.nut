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
	ID = "named/death_jesters_helm", //300
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_hood"] //80
	],
	Helms = [
		[1, "helm/legend_helmet_heavy_plate_helm_named"] //220
	],
	Tops = [],
	Vanity = [
		[1, "vanity/legend_helmet_jester_hat"]
	]
}]
},{
	ID = "named/gold_and_black_turban", //290
	Script = "",
	Sets = [{
	Hoods = [ //below avg
		[1, "hood/legend_helmet_southern_niqaab"], //100
	],
	Helms = [
		[1, "helm/legend_helmet_southern_named_conic"] //130
	],
	Tops = [],
	Vanity = []
}]
},
{ //todo
	ID = "named/golden_feathers_helmet", //240
	Script = "", //TODO
	SScript = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [
		[1, "helm/legend_helmet_tailed_conic"] //185
	],
	Tops = [],
	Vanity = []
}]
},
{
	ID = "named/heraldic_mail_helmet", //280
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_hood"], //80
		[1, "hood/legend_helmet_chain_hood_full"] //90
	],
	Helms = [
	],
	Tops = [
		[1, "top/legend_helmet_faceplate_raised"] //55
	],
	Vanity = [
		[1, "vanity/legend_helmet_side_feather"], //10
		[1, "vanity/legend_helmet_top_feather"], //10
		[1, "vanity_lower/legend_helmet_back_crest"], //10
		[1, "vanity_lower/legend_helmet_top_plume"] //10
	]
}]
},{
	ID = "named/jugglers_hat", //50
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_padded_cap"] //40
	]
	Helms = [],
	Tops = [],
	Vanity = [
		[1, "vanity/legend_helmet_jester_hat"] //10
	]
}]
},{
	ID = "named/jugglers_padded_hat", //75
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_padded_hood"], //50
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [],
	Tops = [],
	Vanity = [
		[1, "vanity/legend_helmet_jester_hat"] //10
	]
}]
},{
	ID = "named/legend_frogmouth_helm_crested_painted", //345
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_scarf"], //70
		[1, "hood/legend_helmet_chain_hood"] //80
	],
	Helms = [
		[1, "helm/legend_helmet_legend_frogmouth_close"] //265
	],
	Tops = [
	],
	Vanity = [
		[1, "vanity/legend_helmet_side_feather"], //10
		[1, "vanity/legend_helmet_top_feather"], //10
		[1, "vanity_lower/legend_helmet_back_crest"], //10
		[1, "vanity_lower/legend_helmet_top_plume"] //10
	]
}]
},{
	ID = "named/legend_frogmouth_helm_decorated", //330
	Script = "",
	Sets = [{
	Hoods = [
		[4, "hood/legend_helmet_leather_hood"], //45
		[5, "hood/legend_helmet_padded_hood"], //50
		[1, "hood/legend_helmet_chain_scarf"] //70
	],
	Helms = [
		[1, "helm/legend_helmet_legend_frogmouth_close"] //265
	],
	Tops = [],
	Vanity = []
}]
},{
	ID = "named/legend_mountain_helmet_named", //300.0
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_scarf"], //70
	],
	Helms = [
		[1, "helm/legend_helmet_great_helm"] //220
	],
	Tops = [
	],
	Vanity = [
		[1, "vanity/legend_helmet_mountain_helm"] //10
	]
}]
},{
	ID = "named/legend_named_warlock_hood", //180
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_hood"] //80
	],
	Helms = [
	],
	Tops = [
		[1, "top/legend_helmet_warlock_skull"] //90
	],
	Vanity = [
		[1, "vanity/legend_helmet_warlock_hood"] //10
	]
}]
},{
	ID = "named/lindwurm_helmet", //265
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_scarf"] //70
	],
	Helms = [
		[1, "helm/legend_helmet_great_helm"] //220
	],
	Tops = [
	],
	Vanity = [
		[1, "vanity/legend_helmet_lindwurm_helm"] //10
	]
}]
},{
	ID = "named/named_conic_helmet_with_faceguard", //280
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [
		[1, "helm/legend_helmet_crude_skull_helm"] //130
	],
	Tops = [
		[1, "top/legend_helmet_facemask"] //90
	],
	Vanity = [
		[1, "vanity/legend_helmet_headband"], //10
		[1, "vanity/legend_helmet_plait"] //10
	]
}]
},{
	ID = "named/named_metal_bull_helmet", //300
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_bronze_chain"] //100
	],
	Helms = [
		[1, "helm/legend_helmet_heavy_plate_helm_named"] //170
	],
	Tops = [
	],
	Vanity = [
		[1, "vanity/legend_helmet_bull_horns"] //10
	]
}]
},{
	ID = "named/named_metal_nose_horn_helmet", //230
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_hood"] //80
	],
	Helms = [
		[1, "helm/legend_helmet_heavy_spiked_helm"] //150
	],
	Tops = [],
	Vanity = []
}]
},{
	ID = "named/named_metal_skull_helmet", //210
	Script = "",
	Sets = [{
	Hoods = [
		[2, "hood/legend_helmet_barb_chain_scarf"], //55
		[2, "hood/legend_helmet_chain_scarf"], //70
		[1, "hood/legend_helmet_bronze_chain"] //100
	],
	Helms = [
		[1, "helm/legend_helmet_crude_skull_helm"], //130
	],
	Tops = [
	],
	Vanity = [
	]
}]
},{
	ID = "named/named_nordic_helmet_with_closed_mail", //265
	Script = "",
	Sets = [{
	Hoods = [
		[2, "hood/legend_helmet_chain_scarf"], //70
		[6, "hood/legend_helmet_chain_hood"], //80
		[2, "hood/legend_helmet_chain_hood_full"], //90
	],
	Helms = [
		[1, "helm/legend_helmet_nordic_helm"] //185
	],
	Tops = [],
	Vanity = []
}]
},{
	ID = "named/named_steppe_helmet_with_mail", //200
	Script = "",
	Sets = [{ //todo atm its same as below but its closest i can get
	Hoods = [
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [
		[1, "helm/legend_helmet_tailed_conic"] //185
	],
	Tops = [],
	Vanity = []
}]
},{
	ID = "named/nasal_feather_helmet", //265
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [
		[1, "helm/legend_helmet_tailed_conic"] //185
	],
	Tops = [],
	Vanity = []
}]
},{
	ID = "named/norse_helmet", //125
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [
		[1, "helm/legend_helmet_viking_helm"] //45
	]
	Tops = [],
	Vanity = [ //missing like 15 s i'm gonna just give it a nice vanity (:
		[1, "vanity/legend_helmet_antler"], //10
		[1, "vanity/legend_helmet_beret"], //10
		[1, "vanity/legend_helmet_bull_horns"], //10
		[1, "vanity/legend_helmet_feather_band"], //10
		[1, "vanity/legend_helmet_feathered_hat"], //10
		[1, "vanity/legend_helmet_headband"], //10
		[1, "vanity/legend_helmet_plait"], //10
		[1, "vanity/legend_helmet_ponytail"], //10
	]
}]
},{
	ID = "named/red_and_gold_band_helmet", //255
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_open_chain_hood"] //65
	],
	Helms = [
		[1, "helm/legend_helmet_tailed_conic"] //185
	],
	Tops = [],
	Vanity = []
}]
},{
	ID = "named/sallet_green_helmet", //265
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_hood"] //80
	],
	Helms = [
		[1, "helm/legend_helmet_sallet"] //185
	],
	Tops = [],
	Vanity = [
		[1, "vanity/legend_helmet_headband"],
		[1, "vanity/legend_helmet_plait"] //10
	]
}]
},{
	ID = "named/witchhunter_helm", //140
	Script = "", //off but it's fine i guess?
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_padded_hood"] //50
	],
	Helms = [
	],
	Tops = [

	],
	Vanity = [
		[1, "vanity/legend_helmet_witchhunter_helm"] //10
	]
}]
},{
	ID = "named/wolf_helmet", //140
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_chain_scarf"], //70
		[1, "hood/legend_helmet_chain_hood"], //80
		[1, "hood/legend_helmet_chain_hood_full"], //90
	],
	Helms = [
		[1, "helm/legend_helmet_wallace_sallet_named"] //140, -7, -2
	],
	Tops = [],
	Vanity = [
		[1, "vanity/legend_helmet_wolf_helm"] //10
	]
}]
},
	{
		ID = "named/wallace_sallet_named", //170, -10, -2, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_wallace_sallet_named"] //140, -7, -2
		],
		Tops = [
			   [1, "top/legend_helmet_wallace_sallet_visor_named"] //60, -2, -1
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity/legend_helmet_top_feather"],
		]
	}]
	},{
		ID = "named/kettle_helm_named", //170, -10, -2, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_kettle_helm_named"] //140, -7, -2
		],
		Tops = [
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity/legend_helmet_top_feather"],
		]
	}]
	},{
		ID = "named/bascinet_named", //170, -10, -2, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_aventail"] //50, -2, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_bascinet_named"] //140, -7, -2
		],
		Tops = [
			   [1, "top/legend_helmet_bascinet_visor_named"] //60, -2, -1
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity/legend_helmet_top_feather"],
		]
	}]
	},{
		ID = "named/barbute_named", //170, -10, -2, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_barbute_named"] //140, -7, -2
		],
		Tops = [
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity/legend_helmet_top_feather"],
		]
	}]
	},{
		ID = "named/italo_norman_helm_named", //170, -10, -2, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_italo_norman_helm_named"] //140, -7, -2
		],
		Tops = [
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity/legend_helmet_top_feather"],
		]
	}]
	},{
		ID = "named/deep_sallet_named", //180, -10, -1, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_deep_sallet_named"] //180, -7, -1
		],
		Tops = [
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity/legend_helmet_top_feather"],
		]
	}]
	},{
		ID = "named/named_helm_with_lion_pelt", //180, -10, -1, 1000
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			 [1, "helm/legend_helmet_deep_sallet_named"], //180, -7, -1
			[1, "helm/legend_helmet_italo_norman_helm_named"],
			 [1, "helm/legend_helmet_barbute_named"],
			 [1, "helm/legend_helmet_bascinet_named"]
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_lion_pelt"]
		]
	}]
	},{
		ID = "named/legend_helm_full_named", //350, -21, -3, 3500
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_full_gold"], //57, -1, -1
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_feather"], //10
			[1, "vanity/legend_helmet_noble_buckle"], //10
			[3, ""] //10
		]
	}]
	},{
		ID = "named/legend_helm_stag_named", //290
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"],
			[1, "hood/legend_helmet_open_chain_hood"]
		],
		Helms = [
			 [1, "helm/legend_helmet_swan_helm"] //140, -7, -2
		],
		Tops = [
			[5, ""],
			[5, "top/legend_helmet_faceplate_long"],
			[3, "top/legend_helmet_faceplate_snub_nose"],
			[3, "top/legend_helmet_faceplate_snub_slit"],
			[1, "top/legend_helmet_faceplate_full_gold"],
			[3, "top/legend_helmet_faceplate_full_breaths"],
			[2, "top/legend_helmet_faceplate_flat"],
			[2, "top/legend_helmet_faceplate_curved"],
			[2, "top/legend_helmet_faceplate_curved"],
			[1, "top/legend_helmet_faceplate_gold"],
			[3, "top/legend_helmet_southern_faceplate"],
			[1, "top/legend_helmet_facemask"],
			[1, "top/legend_helmet_nose_plate"],
			[1, "top/legend_helmet_goblin_gillie"],
		],
		Vanity = [
			[5, ""],
			[3, "vanity/legend_helmet_faction_helmet"],
			[1, "vanity/legend_helmet_goat_horns"],
			[1, "vanity/legend_helmet_bull_horns"],
			[5, "vanity/legend_helmet_plait"],
			[1, "vanity/legend_helmet_ram_horns"],
			[1, "vanity/legend_helmet_antler"],
			[1, "vanity/legend_helmet_horn_decorations"],
		]
	}]
	},{
		ID = "named/legend_helm_swan_named", //290, -21, -3, 3500
		Script = "",
		Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"],
			[1, "hood/legend_helmet_open_chain_hood"],
		],
		Helms = [
			 [1, "helm/legend_helmet_swan_helm"] //140, -7, -2
		],
		Tops = [

			[3, ""],
			[5, "top/legend_helmet_faceplate_winged"],
			[3, "top/legend_helmet_faceplate_long"],
			[3, "top/legend_helmet_faceplate_full"],
			[1, "top/legend_helmet_faceplate_gold"],
			[3, "top/legend_helmet_faceplate_full_breaths"],
			[1, "top/legend_helmet_faceplate_full_gold"],
			[2, "top/legend_helmet_faceplate_pointed"],
			[3, "top/legend_helmet_faceplate_pointed_slit"],
			[3, "top/legend_helmet_facemask"],
			[3, "top/legend_helmet_nose_plate"],
			[1, "top/legend_helmet_goblin_gillie"],
		],
		Vanity = [
			[5, ""],
			[3, "vanity/legend_helmet_faction_helmet"],
			[1, "vanity/legend_helmet_wreath"],
			[5, "vanity/legend_helmet_plait"],
			[3, "vanity/legend_helmet_feather_band"],
			[2, "vanity/legend_helmet_metal_bird"],
			[1, "vanity/legend_helmet_crown"],
		]
	}]
	}
])
