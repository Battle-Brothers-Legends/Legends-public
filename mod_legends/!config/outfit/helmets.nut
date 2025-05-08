::Legends.Helmet.Standard <- {};

::Legends.Helmet.Standard.aketon_cap <- {
	ID = "aketon_cap", //40, -1, 0 , 70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap"] // 40, -1, 0
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.aketon_cap);

::Legends.Helmet.Standard.barbute_helmet <- {
	ID = "barbute_helmet", //190, -9, -2, 2600
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap"], // 40, -1, 0, 70
			[1, "hood/legend_helmet_leather_hood"], //45, -2, 0,
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[3, "hood/legend_helmet_open_chain_hood"] //60, -3, 0, 200
		],
		Helms = [
			[1, "helm/legend_helmet_barbute"] //130, -7, -2
		],
		Tops = [],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_feather_band"],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.barbute_helmet);

::Legends.Helmet.Standard.theamson_barbute_helmet <- {
	ID = "theamson_barbute_helmet", //172 ish, -10, -2
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_enclave_bevor"] //95, -7, 0
		],
		Helms = [
			[1, "helm/legend_helmet_barbute"] //75, -3, -2
		],
		Tops = [],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.theamson_barbute_helmet);

::Legends.Helmet.Standard.bascinet_with_mail <- {
	ID = "bascinet_with_mail", //210, -13, -2, 1400
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4, 0
			[1, "hood/legend_helmet_chain_hood"], //80, -5, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 375
		],
		Helms = [
			[1, "helm/legend_helmet_basinet"], // 130, -8, -1
		],
		Tops = [],
		Vanity = [
			[5, ""],
			[2, "vanity/legend_helmet_plait"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.bascinet_with_mail);

::Legends.Helmet.Standard.closed_flat_top_helmet <- {
	ID = "closed_flat_top_helmet", //170, -10, -3, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[2, "hood/legend_helmet_simple_hood"], //30, -1
			[2, "hood/legend_helmet_padded_cap"], // 40, -1, 0 //40
			[1, "hood/legend_helmet_leather_hood"], // 45, -2, 0 //40
			[1, "hood/legend_helmet_padded_hood"] //50, -2
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm_low"] //90, -6, -1
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_flat"] //30, -2, -2
		],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.closed_flat_top_helmet);

::Legends.Helmet.Standard.closed_flat_top_with_neckguard <- {
	ID = "closed_flat_top_with_neckguard", //180, -11, -3,
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_simple_hood"], //30, -1
			[1, "hood/legend_helmet_padded_cap"], // 40, -1, 0 //40
			[2, "hood/legend_helmet_leather_hood"], // 45, -2, 0 //40
			[2, "hood/legend_helmet_padded_hood"] //50, -2
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm"] //100, -6, -1
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_flat"] //30, -2, -2
		],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.closed_flat_top_with_neckguard);

::Legends.Helmet.Standard.closed_flat_top_with_mail <- {
	ID = "closed_flat_top_with_mail", //280, -19, -3
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm_polished"] //150, -11, -1
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_flat"] //30, -2, -2
		],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.closed_flat_top_with_mail);

::Legends.Helmet.Standard.closed_mail_coif <- {
	ID = "closed_mail_coif", //90, -4, 250
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5
		],
		Helms = [],
		Tops = [
			[1, "top/legend_helmet_chain_attachment"] //20, 0, 0
		],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.closed_mail_coif);

::Legends.Helmet.Standard.conic_helmet_with_closed_mail <- { //started here
	ID = "conic_helmet_with_closed_mail", //265, -18, -2, 2600
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_southern_chain_hood"], //85, -5
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6
		],
		Helms = [
			[1, "helm/legend_helmet_conic_helm"], //150, -11, -1
		],
		Tops = [
			[1, "top/legend_helmet_eyemask"], //20, -1, -1
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.conic_helmet_with_closed_mail);

::Legends.Helmet.Standard.conic_helmet_with_faceguard <- {
	ID = "conic_helmet_with_faceguard", //280, -19, -3, 3000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_southern_chain_hood"], //85, -5
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6
		],
		Helms = [
			[1, "helm/legend_helmet_conic_helm"], //150, -11, -1
		],
		Tops = [
			[1, "top/legend_helmet_facemask"], //40, -2, -2
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.conic_helmet_with_faceguard);

::Legends.Helmet.Standard.cultist_hood <- {
	ID = "cultist_hood", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"], //10
			[1, "hood/legend_helmet_cloth_cap"],
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_sack"], //20
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.cultist_hood);

::Legends.Helmet.Standard.cultist_leather_hood <- {
	ID = "cultist_leather_hood", //60
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"], //10
			[1, "hood/legend_helmet_cloth_cap"]
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_cult_hood"], //50
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.cultist_leather_hood);

::Legends.Helmet.Standard.dark_cowl <- { //avg of 32 dura
	ID = "dark_cowl", //40
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"] // 10
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, ""],
			[1, "vanity/legend_helmet_wizard_cowl"],
			[1, "vanity/legend_helmet_hood_cloth_round"], //10
			[1, "vanity/legend_helmet_hood_cloth_wide"], //10
			[1, "vanity/legend_helmet_hood_cloth_square"], //10
			[1, "vanity/legend_helmet_hood_cloth_long"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.dark_cowl);

::Legends.Helmet.Standard.decayed_closed_flat_top_with_mail <- {
	ID = "decayed_closed_flat_top_with_mail", //230, -19, -3, 1250
	Script = "",
	Sets = [{
		Hoods = [ //60 need 170
			[3, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
		],
		Helms = [ //150 need 20
			[1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150, -14, -3
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_round"], //10, -1, 0
			[1, "vanity/legend_helmet_hood_cloth_wide"], //10
			[1, "vanity/legend_helmet_hood_cloth_square"], //10
			[1, "vanity/legend_helmet_hood_cloth_long"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.decayed_closed_flat_top_with_mail);

::Legends.Helmet.Standard.decayed_closed_flat_top_with_sack <- {
	ID = "decayed_closed_flat_top_with_sack", //230, -19, 3
	Script = "",
	Sets = [{
		Hoods = [ //60 need 170
			[3, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
		],
		Helms = [ //150 need 20
			[1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150, -14, -3
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_sack"], //20, 0, -1
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.decayed_closed_flat_top_with_sack);

::Legends.Helmet.Standard.decayed_full_helm <- {
	ID = "decayed_full_helm", //240, -20, -3
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
			[1, "hood/legend_helmet_rusty_chain_hood"], //60, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_rotten_great_helm"] //160, -15, -3
		],
		Tops = [],
		Vanity = [
			[4, ""],
			[1, "vanity/legend_helmet_hood_cloth_round"], //10, -1, 0
			[1, "vanity/legend_helmet_hood_cloth_wide"], //10
			[1, "vanity/legend_helmet_hood_cloth_square"], //10
			[1, "vanity/legend_helmet_hood_cloth_long"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.decayed_full_helm);

::Legends.Helmet.Standard.decayed_great_helm <- {
	ID = "decayed_great_helm", //255, -22, -3
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
			[1, "hood/legend_helmet_rusty_chain_hood"], //60, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150, -14, -3
			[1, "helm/legend_helmet_rotten_great_helm"] //160, -15, -3
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_decayed_helmet"], //10, -1, 0
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.decayed_great_helm);

::Legends.Helmet.Standard.dented_nasal_helmet <- { //adds up to 100 only; maybe todo
	ID = "dented_nasal_helmet", //110, -7, -1, 350
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_hood"], //45, -2, 0
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
		],
		Helms = [
			[1, "helm/legend_helmet_norman_helm"], //60, -4, -1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.dented_nasal_helmet);

::Legends.Helmet.Standard.faction_helm <- {
	ID = "faction_helm",
	Script = "scripts/items/legend_helmets/helmets/legend_faction_helmet",
	Sets = [{
		Hoods = [
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.faction_helm);

::Legends.Helmet.Standard.feathered_hat <- { //
	ID = "feathered_hat", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_feathered_hat"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.feathered_hat);

::Legends.Helmet.Standard.pimp_hat <- { //
	ID = "pimp_hat", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_pimp_hat"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.pimp_hat);

::Legends.Helmet.Standard.flat_top_helmet <- {
	ID = "flat_top_helmet", //125, -7, -1
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_simple_hood"], //30, -1
			[1, "hood/legend_helmet_padded_cap"], // 40, -1, 0 //40
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm_low"] //90, -6, -1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.flat_top_helmet);

::Legends.Helmet.Standard.flat_top_with_mail <- {
	ID = "flat_top_with_mail", //230, -15, -2, 1800
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm_polished"] //150, -11, -1
		],
		Tops = [
		],
		Vanity = [
			[5, ""],
			[1, "vanity/legend_helmet_headband"],
			[1, "vanity/legend_helmet_plait"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.flat_top_with_mail);

::Legends.Helmet.Standard.flat_top_with_closed_mail <- {
	ID = "flat_top_with_closed_mail", //265, -18, -2, 2600
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm_polished"] //150, -11, -1
		],
		Tops = [
			[1, "top/legend_helmet_chain_attachment"] //20, -1
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.flat_top_with_closed_mail);

::Legends.Helmet.Standard.full_aketon_cap <- {
	ID = "full_aketon_cap", //50
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"]
		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.full_aketon_cap);

::Legends.Helmet.Standard.full_helm <- {
	ID = "full_helm", //300, -20, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.full_helm);

::Legends.Helmet.Standard.legend_helm_wings <- {
	ID = "legend_helm_wings", //340, -24, -2, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_winged"], //70, -6, -1

		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_wings);

::Legends.Helmet.Standard.legend_helm_snub <- {
	ID = "legend_helm_snub", //320, -21, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[3, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_snub);

::Legends.Helmet.Standard.legend_helm_short <- {
	ID = "legend_helm_short", //320, -22, -2, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_short"] //20, -2, 0
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_short);

::Legends.Helmet.Standard.legend_helm_point <- {
	ID = "legend_helm_point", //350, -21, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"] //35, -1, -2
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_point);

::Legends.Helmet.Standard.legend_helm_full <- {
	ID = "legend_helm_full", //350, -21, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_full"], //57, -1, -1
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_feather"], //10
			[1, "vanity/legend_helmet_noble_buckle"], //10
			[1, ""] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_full);

::Legends.Helmet.Standard.legend_helm_curved <- {
	ID = "legend_helm_curved", //325, -21, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_curved"], //25, -4, -2
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_curved);

::Legends.Helmet.Standard.legend_helm_breathed <- {
	ID = "legend_helm_breathed", //320, -21, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_full_breaths"], //25, 0, -1
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_breathed);

::Legends.Helmet.Standard.legend_helm_bearded <- {
	ID = "legend_helm_bearded", //320, -21, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
		],
		Tops = [
			[1, "top/legend_helmet_southern_faceplate_bearded"], //50, -1, -2
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_helm_bearded);

::Legends.Helmet.Standard.full_leather_cap <- {
	ID = "full_leather_cap", //45
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_hood"] //45
		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.full_leather_cap);

::Legends.Helmet.Standard.greatsword_faction_helm <- {
	ID = "greatsword_faction_helm", //160, -7, -1
	Script = "scripts/items/legend_helmets/helmets/legend_greatsword_faction_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.greatsword_faction_helm);

::Legends.Helmet.Standard.greatsword_hat <- {
	ID = "greatsword_hat", //70, -3
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0,
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_fencerhat"] //20, -1, 0
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.greatsword_hat);

::Legends.Helmet.Standard.headscarf <- {
	ID = "headscarf", //20
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"] //10
		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.headscarf);

::Legends.Helmet.Standard.hood <- {
	ID = "hood", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_simple_hood"] //30
		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.hood);

::Legends.Helmet.Standard.hunters_hat <- {
	ID = "hunters_hat", //35
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //10
			[1, "hood/legend_helmet_patched_hood"], //25
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hunter_cap"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.hunters_hat);

::Legends.Helmet.Standard.jesters_hat <- {
	ID = "jesters_hat", //35
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //10
			[1, "hood/legend_helmet_cloth_scarf"], //10
			[1, "hood/legend_helmet_cloth_bandana"], //15
			[1, "hood/legend_helmet_patched_hood"], //25
			[1, "hood/legend_helmet_simple_hood"] //30
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_jester_hat"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.jesters_hat);

::Legends.Helmet.Standard.kettle_hat_with_closed_mail <- {
	ID = "kettle_hat_with_closed_mail", //250, -17, -2 , 2200
	Script = "",
	Sets = [{
		Hoods = [ //avg slightly below 70, need 200
			[1, "hood/legend_helmet_chain_hood"],//80, -5
			[1, "hood/legend_helmet_chain_hood_full"],//90, -6
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_kettle"] //150, -11, -2
		],
		Tops = [
			[1, "top/legend_helmet_chain_attachment"], //20, -1
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.kettle_hat_with_closed_mail);

::Legends.Helmet.Standard.kettle_hat_with_mail <- {
	ID = "kettle_hat_with_mail", //215, -14, -2, 1500
	Script = "",
	Sets = [{
		Hoods = [ //avg slightly below 70, need 200
			[1, "hood/legend_helmet_aventail"], // 60, -4, 0
			[1, "hood/legend_helmet_open_chain_hood"],//75, -4,
			[3, "hood/legend_helmet_chain_hood"],//80, -5,
		],
		Helms = [
			[1, "helm/legend_helmet_kettle_helm_high"],
		],
		Tops = [
			[1, ""],
			[1, "top/legend_helmet_chain_attachment"]
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.kettle_hat_with_mail);

::Legends.Helmet.Standard.kettle_hat <- {
	ID = "kettle_hat", //115, -6, -1, 450
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood"], //25
			[1, "hood/legend_helmet_simple_hood"] //30
		],
		Helms = [
			[1, "helm/legend_helmet_kettle_helm_low"] //85
		],
		Tops = [],
		Vanity = [  ]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.kettle_hat);

::Legends.Helmet.Standard.legend_frogmouth_helm_crested <- {
	ID = "legend_frogmouth_helm_crested", //340
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"], //75
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_legend_armet"], //260
			[1, "helm/legend_helmet_legend_frogmouth"] //265
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_side_feather"], //10
			[1, "vanity/legend_helmet_top_feather"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_frogmouth_helm_crested);

::Legends.Helmet.Standard.legend_frogmouth_helm <- {
	ID = "legend_frogmouth_helm", //330
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"], //75
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_legend_armet"], //260
			[1, "helm/legend_helmet_legend_frogmouth"] //265
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_frogmouth_helm);

::Legends.Helmet.Standard.legend_nun_habit <- {
	ID = "legend_nun_habit", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"],//5
			[1, "hood/legend_helmet_cloth_bandana"], //15
			[1, "hood/legend_helmet_patched_hood"] //25
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_nun_habit"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_nun_habit);

::Legends.Helmet.Standard.legend_seer_hat <- { //way under durability
	ID = "legend_seer_hat", //80
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //5
			[1, "hood/legend_helmet_cloth_scarf"], //10
			[1, "hood/legend_helmet_cloth_bandana"], //15
			[1, "hood/legend_helmet_patched_hood"], //25
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_wizard_cowl"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_seer_hat);

::Legends.Helmet.Standard.legend_vampire_lord_helmet <- {
	ID = "legend_vampire_lord_helmet", //50
	Script = "scripts/items/helmets/legend_vampire_lord_helmet",
	Sets = [{
		Hoods = [
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_vampire_lord_helmet);

::Legends.Helmet.Standard.legend_warlock_hood <- {
	ID = "legend_warlock_hood", //100
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"], //10
			[1, "hood/legend_helmet_cloth_cap"]
		],
		Helms = [],
		Tops = [
			[1, "top/legend_helmet_warlock_skull"] //90
		],
		Vanity = [
			[1, "vanity/legend_helmet_warlock_hood"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_warlock_hood);

::Legends.Helmet.Standard.magician_hat <- {
	ID = "magician_hat", //50
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap"] //40
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_wizard_cowl"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.magician_hat);

::Legends.Helmet.Standard.mail_coif <- {
	ID = "mail_coif", //80
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mail_coif);

::Legends.Helmet.Standard.mouth_piece <- {
	ID = "mouth_piece", //10
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"] //10

		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mouth_piece);

::Legends.Helmet.Standard.nasal_helmet_with_closed_mail <- {
	ID = "nasal_helmet_with_closed_mail", //240, -16, -2
	Script = "",
	Sets = [{
		Hoods = [ //way below avg
			[1, "hood/legend_helmet_chain_hood"],//80
			[1, "hood/legend_helmet_chain_hood_full"] // 90, -6,
		],
		Helms = [
			[1, "helm/legend_helmet_italo_norman_helm"], //150, -12, -1
		],
		Tops = [

		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.nasal_helmet_with_closed_mail);

::Legends.Helmet.Standard.nasal_helmet_with_mail <- {
	ID = "nasal_helmet_with_mail", //200, -12, -2
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"], //70
			[4, "hood/legend_helmet_chain_hood"],//80, -5
			[4, "hood/legend_helmet_chain_hood_full"] // 90, -6,
		],
		Helms = [
			[1, "helm/legend_helmet_norman_helm"] //70, -4, -1
		],
		Tops = [
			[1, ""],
			[1, "top/legend_helmet_chain_attachment"] // 20, -1
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.nasal_helmet_with_mail);

::Legends.Helmet.Standard.nasal_helmet_with_rusty_mail <- {
	ID = "nasal_helmet_with_rusty_mail", //140, -9, -2
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_barb_chain_scarf"], //55
			[1, "hood/legend_helmet_rotten_chain_scarf"],//60, -4
			[3, "hood/legend_helmet_rusty_chain_hood"], //70 -3
		],
		Helms = [
			[1, "helm/legend_helmet_norman_helm"] //70, -4, -1
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.nasal_helmet_with_rusty_mail);

::Legends.Helmet.Standard.nasal_helmet <- {
	ID = "nasal_helmet", //105, -5, -1, 350
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood"], //25, -1
			[1, "hood/legend_helmet_simple_hood"], //30, -1

		],
		Helms = [
			[1, "helm/legend_helmet_norman_helm"] //70,-4 -1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.nasal_helmet);

::Legends.Helmet.Standard.necromancer_hat <- {
	ID = "necromancer_hat", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], // 10
			[1, "hood/legend_helmet_cloth_bandana"] //15
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_round"], //10
			[1, "vanity/legend_helmet_hood_cloth_wide"], //10
			[1, "vanity/legend_helmet_hood_cloth_square"], //10
			[1, "vanity/legend_helmet_hood_cloth_long"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.necromancer_hat);

::Legends.Helmet.Standard.noble_arrow_helm <- {
	ID = "noble_arrow_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 2] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_arrow_helm);

::Legends.Helmet.Standard.noble_bull_helm <- {
	ID = "noble_bull_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 3] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_bull_helm);

::Legends.Helmet.Standard.noble_castle_helm <- {
	ID = "noble_castle_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 1] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_castle_helm);

::Legends.Helmet.Standard.noble_deer_helm <- {
	ID = "noble_deer_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 8] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_deer_helm);

::Legends.Helmet.Standard.noble_dragon_helm <- {
	ID = "noble_dragon_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 10] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_dragon_helm);

::Legends.Helmet.Standard.noble_feather_helm <- {
	ID = "noble_feather_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 5] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_feather_helm);

::Legends.Helmet.Standard.noble_fish_helm <- {
	ID = "noble_fish_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 7] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_fish_helm);

::Legends.Helmet.Standard.noble_headgear <- {
	ID = "noble_headgear", //10
	Script = "scripts/items/helmets/noble_headgear",
	Sets = [{
		Hoods = [
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_headgear);

::Legends.Helmet.Standard.noble_lion_helm <- {
	ID = "noble_lion_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 4] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_lion_helm);

::Legends.Helmet.Standard.noble_sun_helm <- {
	ID = "noble_sun_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 9] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_sun_helm);

::Legends.Helmet.Standard.noble_swan_helm <- {
	ID = "noble_swan_helm", //300
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"] //80
		],
		Helms = [
			[1, "helm/legend_helmet_great_helm"], //220
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet", 6] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.noble_swan_helm);

::Legends.Helmet.Standard.nordic_helmet_with_closed_mail <- {
	ID = "nordic_helmet_with_closed_mail", //265, -18, -2
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"], //60
			[1, "hood/legend_helmet_chain_hood"],//80, -5
			[1, "hood/legend_helmet_chain_hood_full"] // 90, -6,
		],
		Helms = [
			[1, "helm/legend_helmet_nordic_helm_high"] //175
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.nordic_helmet_with_closed_mail);

::Legends.Helmet.Standard.nordic_helmet <- {
	ID = "nordic_helmet", //125, -7, -1
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_simple_hood"] //30
		],
		Helms = [
			[1, "helm/legend_helmet_nordic_helm_low"] //95, -6, -1
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.nordic_helmet);

::Legends.Helmet.Standard.open_leather_cap <- {
	ID = "open_leather_cap", //40
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_cap"] //35
		],
		Helms = [],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.open_leather_cap);

::Legends.Helmet.Standard.padded_flat_top_helmet <- {
	ID = "padded_flat_top_helmet", //150, -9, -1
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap"], // 40, -1, 0
			[1, "hood/legend_helmet_padded_hood"] //50
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm"] //100, -6, -1
		],
		Tops = [
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.padded_flat_top_helmet);

::Legends.Helmet.Standard.padded_kettle_hat <- {
	ID = "padded_kettle_hat", //140, -8, -1
	Script = "",
	Sets = [{
		Hoods = [ //bit over
			[1, "hood/legend_helmet_padded_cap"], // 40, -1, 0
			[1, "hood/legend_helmet_padded_hood"] //50
		],
		Helms = [
			[1, "helm/legend_helmet_kettle_helm_med"] //95, -7
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.padded_kettle_hat);

::Legends.Helmet.Standard.padded_nasal_helmet <- {
	ID = "padded_nasal_helmet", //130, -7, -1
	Script = "",
	Sets = [{
		Hoods = [ //bit over
			[1, "hood/legend_helmet_padded_cap"], // 40, --1, 0 //40
			[1, "hood/legend_helmet_padded_hood"] //50
		],
		Helms = [
			[1, "helm/legend_helmet_norman_helm"] //70, -4, -1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.padded_nasal_helmet);

::Legends.Helmet.Standard.reinforced_mail_coif <- {
	ID = "reinforced_mail_coif", //100, -5, -1
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_chain_attachment"], //20, -1
			[1, "top/legend_helmet_nose_plate"] //20, -1, 0
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.reinforced_mail_coif);

::Legends.Helmet.Standard.rusty_mail_coif <- {
	ID = "rusty_mail_coif", //70, -4
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_rusty_chain_hood"]
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.rusty_mail_coif);

::Legends.Helmet.Standard.sallet_helmet <- {
	ID = "sallet_helmet", //120, -5
	Script = "",
	Sets = [{
		Hoods = [
			[2, "hood/legend_helmet_cloth_cap"],
			[1, "hood/legend_helmet_cloth_bandana"] //15
		],
		Helms = [
			[1, "helm/legend_helmet_sallet"] //110, -5,
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.sallet_helmet);

::Legends.Helmet.Standard.steppe_helmet_with_mail <- {
	ID = "steppe_helmet_with_mail", //200, -12, -2, 1250
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"], // 75, -4, 0
			[1, "hood/legend_helmet_chain_hood"], //80, -5, 0
		],
		Helms = [
			[1, "helm/legend_helmet_horsetail"] //120, -7, -1
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_headband"], //10
			[9, ""]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.steppe_helmet_with_mail);

::Legends.Helmet.Standard.straw_hat <- {
	ID = "straw_hat", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"],
			[1, "hood/legend_helmet_cloth_scarf"], //10
			[1, "hood/legend_helmet_cloth_bandana"], //15
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_straw_hat"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.straw_hat);

::Legends.Helmet.Standard.witchhunter_hat <- {
	ID = "witchhunter_hat", //40
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"] // 10
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_round"], //10
			[1, "vanity/legend_helmet_hood_cloth_wide"], //10
			[1, "vanity/legend_helmet_hood_cloth_square"], //10
			[1, "vanity/legend_helmet_hood_cloth_long"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.witchhunter_hat);

::Legends.Helmet.Standard.legend_noble_crown <- {
	ID = "legend_noble_crown", //70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"], //15,
			[2, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_crown"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_noble_crown);

::Legends.Helmet.Standard.legend_noble_hood <- {
	ID = "legend_noble_hood", //70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"], //15,
			[2, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_hood"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_noble_hood);

::Legends.Helmet.Standard.legend_noble_hat <- {
	ID = "legend_noble_hat", //70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"], //15,
			[2, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_hat"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_noble_hat);

::Legends.Helmet.Standard.legend_noble_floppy_hat <- {
	ID = "legend_noble_floppy_hat", //70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"], //15,
			[2, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_hat"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_noble_floppy_hat);

::Legends.Helmet.Standard.legend_noble_southern_crown <- {
	ID = "legend_noble_southern_crown", //70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"], //15,
			[2, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_southern_crown"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_noble_southern_crown);

::Legends.Helmet.Standard.legend_noble_southern_hat <- {
	ID = "legend_noble_southern_hat", //70
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"], //15,
			[2, "hood/legend_helmet_cloth_cap"] //10
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_noble_southern_hat"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_noble_southern_hat);

::Legends.Helmet.Standard.wizard_hat <- {
	ID = "wizard_hat", //30
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], // 10
			[1, "hood/legend_helmet_cloth_bandana"] //15
		],
		Helms = [],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_wizard_cowl"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.wizard_hat);

::Legends.Helmet.Standard.legend_enclave_vanilla_armet_01 <- {
	ID = "legend_enclave_vanilla_armet_01", //300,-20, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_armet"] //130, -6, -1
		],
		Tops = [
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity_lower/legend_helmet_back_feathers"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_armet_01);

::Legends.Helmet.Standard.legend_enclave_vanilla_armet_02 <- {
	ID = "legend_enclave_vanilla_armet_02", //270, -19, -2, 2900
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_armet"] //130, -6, -1
		],
		Tops = [
			[1, "top/legend_helmet_enclave_armet_visor"] //40, -3, 0
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity_lower/legend_helmet_back_feathers"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_armet_02);

::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_01 <- {
	ID = "legend_enclave_vanilla_great_bascinet_01", //330, -24, -3, 2600
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_venitian_bascinet"] //260, -13, -2
		],
		Tops = [
			[2, ""],
			[2, "top/legend_helmet_enclave_venitian_bascinet_visor"], //40, -3, 0
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
			[1, "top/legend_helmet_faceplate_flat"], //22, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"], //35, -1, -2
			[1, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity_lower/legend_helmet_back_feathers"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_01);

::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_02 <- {
	ID = "legend_enclave_vanilla_great_bascinet_02", //340, -25, -2, 2800
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_great_bascinet"] //260, -13, -2
		],
		Tops = [
			[10, ""],
			[2, "top/legend_helmet_enclave_great_bascinet_visor"], //40, -3, 0
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
			[1, "top/legend_helmet_faceplate_flat"], //22, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"], //35, -1, -2
			[1, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity_lower/legend_helmet_back_feathers"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_02);

::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_03 <- {
	ID = "legend_enclave_vanilla_great_bascinet_03", //365, -26, -3, 3200
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_great_bascinet"] //210, -15, -2
		],
		Tops = [
			[2, ""],
			[2, "top/legend_helmet_enclave_great_bascinet_visor"], //40, -3, 0
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
			[1, "top/legend_helmet_faceplate_flat"], //22, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"],//35, -1, -2
			[1, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity_lower/legend_helmet_back_feathers"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_03);

::Legends.Helmet.Standard.legend_enclave_vanilla_great_helm_01 <- {
	ID = "legend_enclave_vanilla_great_helm_01", //300, -20, -3, 3500
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_great_helm"] //220, -15, -3
		],
		Tops = [
		],
		Vanity = [
			[10, ""],
			[1, "vanity/legend_helmet_noble_feather"],
			[1, "vanity/legend_helmet_side_feather"],
			[1, "vanity/legend_helmet_plait"], //10
			[1, "vanity/legend_helmet_noble_feather"],

			[1, "vanity_lower/legend_helmet_back_feathers"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_great_helm_01);

::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_01 <- {
	ID = "legend_enclave_vanilla_kettle_sallet_01", //280, -19, -3, 3000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
			[1, "hood/legend_helmet_chain_hood"], //80, -4, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_kettle"] //140, -7, -2
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_01);

::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_02 <- {
	ID = "legend_enclave_vanilla_kettle_sallet_02", //270, -18, -2, 2700
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_enclave_bevor"] //100, -7, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_kettle"] //140, -7, -2
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_02);

::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_03 <- {
	ID = "legend_enclave_vanilla_kettle_sallet_03", //170, -10, -2, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //75, -4
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_kettle"] //140, -7, -2
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_03);

::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01 <- {
	ID = "legend_enclave_vanilla_skullcap_01", //245, -17, -1, 2600
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_skullcap"] //120, -12, -1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01);

::Legends.Helmet.Standard.legend_champion_butcher_helmet <- {
	ID = "legend_champion_butcher_helmet", //approx 130, -7,
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_scarf"], //70, -4
			[1, "hood/legend_helmet_aventail"]
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_facemask"], //60, -2, -1
			[1, "top/legend_helmet_faceplate_flat"] //57, -4, -2
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.legend_champion_butcher_helmet);

::Legends.Helmet.Standard.italo_norman_helm <- {
	ID = "italo_norman_helm", //170, -10, -2, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_southern_open_chain_hood"], //65, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_italo_norman_helm"] //150, -7, -2
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.italo_norman_helm);

::Legends.Helmet.Standard.scale_helm <- {
	ID = "scale_helm", //170, -10, -2, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_scale_helm"] //75. -5. 1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.scale_helm);

::Legends.Helmet.Standard.rondel_helm <- {
	ID = "rondel_helm", //170, -10, -2, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_rondel_helm"] //75. -5. 1
		],
		Tops = [
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.rondel_helm);

::Legends.Helmet.Standard.deep_sallet <- {
	ID = "deep_sallet", //170, -10, -2, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
			[1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_deep_sallet"] //75. -5. 1
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.deep_sallet);

::Legends.Helmet.Standard.wallace_sallet <- {
	ID = "wallace_sallet", //170, -10, -2, 1000
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"], //50, -2, 0
			[1, "hood/legend_helmet_aventail"],
			[1, "hood/legend_helmet_southern_open_chain_hood"], //65, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_wallace_sallet"] //140, -7, -2
		],
		Tops = [
			[1, "top/legend_helmet_wallace_sallet_visor"] //60, -2, -1
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.wallace_sallet);

::Legends.Helmet.Standard.red_bandit_leader_helmet <- {
	ID = "red_bandit_leader_helmet", //215
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood_full"]
		],
		Helms = [
			[1, "helm/legend_helmet_barbute"] //140, -7, -2
		],
		Tops = [
			[1, "top/legend_helmet_wallace_sallet_visor"] //60, -2, -1
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband", 1],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.red_bandit_leader_helmet);

::Legends.Helmet.Standard.brown_hedgeknight_helmet <- {
	ID = "brown_hedgeknight_helmet", //179
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood_full"]
		],
		Helms = [
			[1, "helm/legend_helmet_nordic_helm_low"] //140, -7, -2
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait", 7],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.brown_hedgeknight_helmet);

::Legends.Helmet.Standard.southern_knight_helmet <- {
	ID = "southern_knight_helmet", //200 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_southern_chain_hood"],
			[1, "hood/legend_helmet_southern_open_chain_hood"]
		],
		Helms = [
			[1, "helm/legend_helmet_conic_helm"] //140, -7, -2
		],
		Tops = [
			[1, "top/legend_helmet_facemask"]
		],
		Vanity = [
			[1, "vanity/legend_helmet_southern_patterned_headwrap"],
			[1, "vanity/legend_helmet_southern_turban_open"],
			[1, "vanity/legend_helmet_southern_turban_full"],
			[1, "vanity/legend_helmet_southern_turban_feather"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.southern_knight_helmet);

::Legends.Helmet.Standard.northern_mercenary_helmet_00 <- {
	ID = "northern_mercenary_helmet_00", //200 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood"],
			[1, "hood/legend_helmet_rusty_chain_hood"],
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"]
		],
		Helms = [
			[1, "helm/legend_helmet_nordic_helm_low"],
			[1, "helm/legend_helmet_nordic_helm"],
			[1, "helm/legend_helmet_nordic_helm_high"]
		],
		Tops = [
			[0, "top/legend_helmet_facemask"]
		],
		Vanity = [
			[0, "vanity/legend_helmet_southern_patterned_headwrap"],
			[0, "vanity/legend_helmet_southern_turban_open"],
			[0, "vanity/legend_helmet_southern_turban_full"],
			[0, "vanity/legend_helmet_southern_turban_feather"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.northern_mercenary_helmet_00);

::Legends.Helmet.Standard.traze_northern_mercenary_cap <- {
	ID = "traze_northern_mercenary_cap", //120
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"],
			[1, "hood/legend_helmet_padded_cap"],
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_fencerhat"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.traze_northern_mercenary_cap);

::Legends.Helmet.Standard.northern_mercenary_helmet_01 <- {
	ID = "northern_mercenary_helmet_01", //160 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"]
		],
		Helms = [
			[1, "helm/legend_helmet_viking_helm"]
		],
		Tops = [
			[1, ""],
			[1, "top/legend_helmet_chain_attachment"], //40
		],
		Vanity = [
			[2, ""],
			[1, "vanity/legend_helmet_antler"],
			[1, "vanity/legend_helmet_bull_horns"],
			[1, "vanity/legend_helmet_goat_horns"],
			[1, "vanity/legend_helmet_horn_decorations"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.northern_mercenary_helmet_01);

::Legends.Helmet.Standard.northern_mercenary_helmet_02 <- {
	ID = "northern_mercenary_helmet_02", //160 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"]
		],
		Helms = [
			[1, "helm/legend_helmet_nordic_helm"], //185
		],
		Tops = [
			[1, ""],
			[1, "top/legend_helmet_eyemask"]
		],
		Vanity = [
			[1, "vanity/legend_helmet_orc_bones"],
			[1, "vanity/legend_helmet_orc_great_horns"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.northern_mercenary_helmet_02);

::Legends.Helmet.Standard.barbarian_chosen_helmet_00 <- {
	ID = "barbarian_chosen_helmet_00", //150 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_barb_chain_scarf"],
			[1, "hood/legend_helmet_barb_open_chain"],
			[1, "hood/legend_helmet_rotten_chain_scarf"]
		],
		Helms = [
			[1, "helm/legend_helmet_barb_metal_cap"],
		],
		Tops = [
			[1, "top/legend_helmet_leather_hood_barb"]
		],
		Vanity = [
			[1, "vanity/legend_helmet_orc_bones"],
			[1, "vanity/legend_helmet_ponytail"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.barbarian_chosen_helmet_00);

::Legends.Helmet.Standard.barbarian_chosen_helmet_01 <- {
	ID = "barbarian_chosen_helmet_01", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_chain_hood_full"],
			[1, "hood/legend_helmet_bronze_chain"]
		],
		Helms = [
			[1, "helm/legend_helmet_barb_metal_cap"],
		],
		Tops = [
			[1, "top/legend_helmet_orc_horn_mask"],
			[1, "top/legend_helmet_leather_hood_barb"],
			[1, "top/legend_helmet_orc_metal_mask"],
			[1, "top/legend_helmet_headband_nose"],
		],
		Vanity = [
			[1, "vanity/legend_helmet_wolf_helm"],
			[1, "vanity/legend_helmet_lion_pelt"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.barbarian_chosen_helmet_01);

::Legends.Helmet.Standard.barbarian_chosen_helmet_02 <- {
	ID = "barbarian_chosen_helmet_02", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf", 1]
		],
		Helms = [
			[1, "helm/legend_helmet_heavy_plate_helm"], //170
		],
		Tops = [
			[1, "top/legend_helmet_headband_side"], //20
		],
		Vanity = [
			[1, "vanity/legend_helmet_ponytail", 1], //10
			[1, "vanity/legend_helmet_ponytail", 4], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.barbarian_chosen_helmet_02);

::Legends.Helmet.Standard.heavy_noble_house_helmet_00 <- {
	ID = "heavy_noble_house_helmet_00", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_aventail"],
			[1, "hood/legend_helmet_enclave_bevor"],
			[1, "hood/legend_helmet_chain_hood_full"],
		],
		Helms = [
			[1, "helm/legend_helmet_rondel_helm"], //170
			[1, "helm/legend_helmet_norman_helm"], //170
			[1, "helm/legend_helmet_barbute"], //170
			[1, "helm/legend_helmet_sallet"], //170
			[1, "helm/legend_helmet_deep_sallet"] //170
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_winged"], //20
			[1, "top/legend_helmet_faceplate_snub_nose"], //20
			[1, "top/legend_helmet_faceplate_snub_slit"], //20
			[1, "top/legend_helmet_faceplate_short"], //20
			[1, "top/legend_helmet_faceplate_full"], //20
			[1, "top/legend_helmet_faceplate_curved"], //20
			[1, "top/legend_helmet_faceplate_full_breaths"], //20
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.heavy_noble_house_helmet_00);

::Legends.Helmet.Standard.brown_monk_helmet_00 <- {
	ID = "brown_monk_helmet_00", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"],
		],
		Helms = [
		],
		Tops = [],
		Vanity = [
			[3, ""],
			[1, "vanity/legend_helmet_hood_cloth_long", 3] //20
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.brown_monk_helmet_00);

::Legends.Helmet.Standard.dark_southern_helmet_00 <- {
	ID = "dark_southern_helmet_00", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_southern_niqaab"] //100
		],
		Helms = [
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_long", 4] //20
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.dark_southern_helmet_00);

::Legends.Helmet.Standard.white_nomad_leader_helmet_00 <- {
	ID = "white_nomad_leader_helmet_00", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_southern_open_chain_hood"], //6
			[1, "hood/legend_helmet_chain_hood"], //80, -5
			[1, "hood/legend_helmet_chain_hood"] //80, -5
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_skullcap"], //120, -12, -1
			[1, "helm/legend_helmet_southern_conic_helm"] //120, -12, -1
		],
		Tops = [
			[1, ""], //20, -1
			[1, "top/legend_helmet_nose_plate"] //20, -1, 0
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.white_nomad_leader_helmet_00);

::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_00 <- {
	ID = "citrene_nomad_cutthroat_helmet_00", //50
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"],
			[1, "hood/legend_helmet_southern_cap"],
			[1, "hood/legend_helmet_southern_cap_dark"]
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband"],
			[4, "vanity/legend_helmet_southern_headband"],
			[10, "vanity/legend_helmet_southern_patterned_headband"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_00);

::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_01 <- {
	ID = "citrene_nomad_cutthroat_helmet_01", //115
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_southern_open_chain_hood"],
			[1, "hood/legend_helmet_southern_cap"],
			[1, "hood/legend_helmet_southern_cap_dark"]
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband"],
			[4, "vanity/legend_helmet_southern_headband"],
			[10, "vanity/legend_helmet_southern_patterned_headband"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_01);

::Legends.Helmet.Standard.citrene_nomad_ranged_helmet_00 <- {
	ID = "citrene_nomad_ranged_helmet_00", //50 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_southern_open_chain_hood"],
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_southern_helm_tailed"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.citrene_nomad_ranged_helmet_00);

::Legends.Helmet.Standard.theamson_nomad_leader_helmet_heavy <- {
	ID = "theamson_nomad_leader_helmet_heavy", //146-161-196
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_barb_chain_scarf"],
			[1, "hood/legend_helmet_barb_open_chain"],
			[1, "hood/legend_helmet_rotten_chain_scarf"]
		],
		Helms = [
			[1, "helm/legend_helmet_horsetail"],
			[1, "helm/legend_helmet_southern_conic_helm"],
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_southern_headband"], //15
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.theamson_nomad_leader_helmet_heavy);

::Legends.Helmet.Standard.theamson_nomad_leader_helmet_facemask <- {
	ID = "theamson_nomad_leader_helmet_facemask", //43-123
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf"],
			[1, "helm/legend_helmet_southern_cap"],
		],
		Helms = [
			[1, "helm/legend_helmet_southern_leather_helm"],
			[1, "helm/legend_helmet_horsetail"],
		],
		Tops = [
		],
		Vanity = [
			[15, "vanity/legend_helmet_southern_headband"], //15
			[4, "vanity/legend_helmet_southern_patterned_headband"], //15
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.theamson_nomad_leader_helmet_facemask);

::Legends.Helmet.Standard.theamson_nomad_outlaw_helmet <- {
	ID = "theamson_nomad_outlaw_helmet", //66-141 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_southern_open_chain_hood"],
			[2, "hood/legend_helmet_chain_hood"],
			[1, "hood/legend_helmet_southern_niqaab"],
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_skullcap"], //120, -12, -1
			[4, "helm/legend_helmet_southern_conic_helm"] //120, -12, -1
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband"], //10
			[4, "vanity/legend_helmet_southern_patterned_headband"], //15
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.theamson_nomad_outlaw_helmet);

::Legends.Helmet.Standard.great_jaw_helmet_00 <- {
	ID = "great_jaw_helmet_00", //190 ish
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood"]
		],
		Helms = [
			[1, "helm/legend_helmet_nordic_helm_high"] //120, -12, -1
		],
		Tops = [
			[1, "top/legend_helmet_enclave_great_jaw"] //20, -1, 0
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.great_jaw_helmet_00);

::Legends.Helmet.Standard.adorned_closed_flat_top_with_mail <- {
	ID = "adorned_closed_flat_top_with_mail",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood"],
			[1, "hood/legend_helmet_leather_hood"],
			[1, "hood/legend_helmet_simple_hood"],
			[1, "hood/legend_helmet_padded_cap"],
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm_low"],
			[3, "helm/legend_helmet_flat_top_helm"],
			[1, "helm/legend_helmet_flat_top_helm_polished"],
		],
		Tops = [
			[5, ""],
			[5, "top/legend_helmet_faceplate_flat"],
			[3, "top/legend_helmet_faceplate_snub_nose"],
			[2, "top/legend_helmet_faceplate_snub_slit"],
			[1, "top/legend_helmet_faceplate_pointed"],
		],
		Vanity = [
			[1, "vanity/legend_helmet_chaperon"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.adorned_closed_flat_top_with_mail);

::Legends.Helmet.Standard.adorned_full_helm <- {
	ID = "adorned_full_helm",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood"],
			[1, "hood/legend_helmet_leather_hood"],
			[1, "hood/legend_helmet_simple_hood"],
			[1, "hood/legend_helmet_padded_cap"],
		],
		Helms = [
			[1, "helm/legend_helmet_full_helm"],
		],
		Tops = [
			[1, "top/legend_helmet_helm_adornment"],
		],
		Vanity = [
			[1, "vanity/legend_helmet_thick_braid"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.adorned_full_helm);

::Legends.Helmet.Standard.adorned_full_helm_rotten <- {
	ID = "adorned_full_helm_rotten",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood"],
			[1, "hood/legend_helmet_leather_hood"],
		],
		Helms = [
			[1, "helm/legend_helmet_full_helm"],
		],
		Tops = [
			[1, "top/legend_helmet_helm_adornment_rotten"],
		],
		Vanity = [
			[1, "vanity/legend_helmet_thick_braid_rotten"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.adorned_full_helm_rotten);

::Legends.Helmet.Standard.heavy_mail_coif <- {
	ID = "heavy_mail_coif",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mail_coif"],
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.heavy_mail_coif);

::Legends.Helmet.Standard.masked_kettle_helmet <- {
	ID = "masked_kettle_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_full_mask"],
		],
		Helms = [
			[20, "helm/legend_helmet_kettle_hat"],
			[3, "helm/legend_helmet_kettle_helm_low"],
			[2, "helm/legend_helmet_kettle_helm_med"],
			[1, "helm/legend_helmet_kettle_helm_high"],
		],
		Tops = [

		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.masked_kettle_helmet);

::Legends.Helmet.Standard.physician_mask <- {
	ID = "physician_mask",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_full_mask"],
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_mask_beak"],
		],
		Vanity = [
			[1, "vanity/legend_helmet_physicians_hood"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.physician_mask);

::Legends.Helmet.Standard.undertaker_hat <- {
	ID = "undertaker_hat",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_bandana"],
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_undertakers_scarf"],
		],
		Vanity = [
			[1, "vanity/legend_helmet_undertakers_hat"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.undertaker_hat);

::Legends.Helmet.Standard.swan_helm <- {
	ID = "swan_helm"
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
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.swan_helm);

::Legends.Helmet.Standard.stag_helm <- {
	ID = "stag_helm"
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
			[1, "vanity/legend_helmet_ram_antler"],
			[1, "vanity/legend_helmet_horn_decorations"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.stag_helm);

::Legends.Helmet.Standard.lonewolf_longsword_helmet <- {
	ID = "lonewolf_longsword_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap"], //40
		],
		Helms = [
			[1, "helm/legend_helmet_enclave_kettle"] //150,
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.lonewolf_longsword_helmet);

::Legends.Helmet.Standard.lonewolf_hammershield_helmet <- {
	ID = "lonewolf_hammershield_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap"], //40
		],
		Helms = [
			[1, "helm/legend_helmet_barbute"], //130
		],
		Tops = [
			[1, "top/legend_helmet_eyemask"], //20
			[1, "top/legend_helmet_faceplate_snub_nose"], //20
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.lonewolf_hammershield_helmet);

::Legends.Helmet.Standard.lonewolf_axebuckler_helmet <- {
	ID = "lonewolf_axebuckler_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_hood"], //45
		],
		Helms = [
			[1, "helm/legend_helmet_barbute"], //130
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_flat"], //30
			[1, "top/legend_helmet_faceplate_snub_nose"], //20
			[1, "top/legend_helmet_faceplate_snub_slit"], //40
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.lonewolf_axebuckler_helmet);

::Legends.Helmet.Standard.lonewolf_crossbowsword_helmet <- {
	ID = "lonewolf_crossbowsword_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_enclave_bevor"], //95
		],
		Helms = [
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_round"],
			[1, "vanity/legend_helmet_hood_cloth_wide"],
			[1, "vanity/legend_helmet_hood_cloth_square"],
			[1, "vanity/legend_helmet_hood_cloth_long"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.lonewolf_crossbowsword_helmet);

::Legends.Helmet.Standard.lonewolf_bowdagger_helmet <- {
	ID = "lonewolf_bowdagger_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_leather_hood"], //45
			[1, "hood/legend_helmet_padded_hood"], //50
		],
		Helms = [
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_round"],
			[1, "vanity/legend_helmet_hood_cloth_wide"],
			[1, "vanity/legend_helmet_hood_cloth_square"],
			[1, "vanity/legend_helmet_hood_cloth_long"],
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.lonewolf_bowdagger_helmet);

::Legends.Helmet.Standard.lonewolf_polearm_helmet <- {
	ID = "lonewolf_polearm_helmet",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood_full"] //90
		],
		Helms = [
			[1, "helm/legend_helmet_basinet"], //130
		],
		Tops = [
			[1, "top/legend_helmet_facemask"], //40
			[1, "top/legend_helmet_faceplate_snub_slit"], //40
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.lonewolf_polearm_helmet);

::Legends.Helmet.Standard.mercury_noble_elite_footman_00 <- {
	ID = "mercury_noble_elite_footman_00",
	Script = "",
	Sets = [{
		Hoods = [[1, "hood/legend_helmet_leather_cap", 1]],
		Helms = [
			[1, "helm/legend_helmet_barbute", 1],
			[1, "helm/legend_helmet_nordic_helm_high", 1]
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_full", 1],
			[1, "top/legend_helmet_faceplate_snub_slit", 1],
			[1, "top/legend_helmet_enclave_great_bascinet_visor", 1],
			[1, "top/legend_helmet_faceplate_pointed_slit", 1],
			[1, "top/legend_helmet_faceplate_pointed", 1],
			[1, "top/legend_helmet_faceplate_flat", 1]
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait", 7]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_noble_elite_footman_00);

::Legends.Helmet.Standard.mercury_noble_elite_footman_01 <- {
	ID = "mercury_noble_elite_footman_01",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood", 1]
		],
		Helms = [
			[1, "helm/legend_helmet_viking_helm"]
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_flat", 1]
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait"]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_noble_elite_footman_01);

::Legends.Helmet.Standard.mercury_sureshot_00 <- {
	ID = "mercury_sureshot_00",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf", 5]
		],
		Helms = [
			[1, "helm/legend_helmet_sallet", 2]
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_hood_cloth_round", 1]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_sureshot_00);

::Legends.Helmet.Standard.mercury_sureshot_01 <- {
	ID = "mercury_sureshot_01",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood", 1]
		],
		Helms = [
			[1, "helm/legend_helmet_barbute", 6]
		],
		Tops = [
			[1, ""]
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband", 15]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_sureshot_01);

::Legends.Helmet.Standard.mercury_rusty_sureshot_00 <- {
	ID = "mercury_rusty_sureshot_00",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_patched_hood", 1]
		],
		Helms = [
			[1, "helm/legend_helmet_barb_metal_cap", 1]
		],
		Tops = [
			[1, ""]
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband", 15]
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_rusty_sureshot_00);

::Legends.Helmet.Standard.mercury_pollax_00 <- {
	ID = "mercury_pollax_00",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood", 2]
		],
		Helms = [
			[1, "helm/legend_helmet_viking_helm", 1]
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_winged", 2]
		],
		Vanity = [
			[1, ""]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_pollax_00);

::Legends.Helmet.Standard.mercury_pollax_01 <- {
	ID = "mercury_pollax_01",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood", 3]
		],
		Helms = [
			[1, "helm/legend_helmet_horsetail", 1]
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_pointed_slit", 1],
			[1, "top/legend_helmet_faceplate_pointed", 1]
		],
		Vanity = [
			[1, "vanity/legend_helmet_headband", 16]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_pollax_01);

::Legends.Helmet.Standard.mercury_pollax_02 <- {
	ID = "mercury_pollax_02",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_open_chain_hood", 3]
		],
		Helms = [
			[1, "helm/legend_helmet_horsetail", 1],
			[1, "helm/legend_helmet_norman_helm", 1]
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_full", 1]
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait", 7],
			[1, "vanity/legend_helmet_plait", 10]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_pollax_02);

::Legends.Helmet.Standard.mercury_sureshot_green_00 <- {
	ID = "mercury_sureshot_green_00",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf", 3]
		],
		Helms = [
			[1, "helm/legend_helmet_barb_metal_cap", 1]
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_plait", 4],
			[1, "vanity/legend_helmet_hood_cloth_wide", 1]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_sureshot_green_00);

::Legends.Helmet.Standard.mercury_sureshot_green_01 <- {
	ID = "mercury_sureshot_green_01",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_enclave_bevor", 1]
		],
		Helms = [
			[1, ""]
		],
		Tops = [
			[1, ""]
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait"]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_sureshot_green_01);

::Legends.Helmet.Standard.mercury_sureshot_blue_00 <- {
	ID = "mercury_sureshot_blue_00",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_scarf", 4]
		],
		Helms = [
			[1, ""]
		],
		Tops = [],
		Vanity = [
			[1, "vanity/legend_helmet_headband", 8],
			[1, "vanity/legend_helmet_hood_cloth_long", 2],
			[1, ""]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_sureshot_blue_00);

::Legends.Helmet.Standard.mercury_pollax_colorful <- {
	ID = "mercury_pollax_colorful",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_hood"]
		],
		Helms = [
			[1, "helm/legend_helmet_norman_helm", 1]
		],
		Tops = [
			[1, "top/legend_helmet_enclave_great_bascinet_visor", 1],
			[1, "top/legend_helmet_faceplate_full_breaths", 1]
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait"] //12 to match the 8 if wanted
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_pollax_colorful);

::Legends.Helmet.Standard.mercury_royal_guard_00 <- {
	ID = "mercury_royal_guard_00",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_chain_hood", 2]
		],
		Helms = [
			[1, ""]
		],
		Tops = [
			[1, "top/legend_helmet_faceplate_flat"]
		],
		Vanity = [
			[1, "vanity/legend_helmet_plait"]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_royal_guard_00);

::Legends.Helmet.Standard.mercury_royal_guard_01 <- {
	ID = "mercury_royal_guard_01",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_padded_cap", 1]
		],
		Helms = [
			[1, "helm/legend_helmet_flat_top_helm", 1]
		],
		Tops = [
			[1, ""]
		],
		Vanity = [
			[1, "vanity/legend_helmet_faction_helmet"]
		],
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Standard.mercury_royal_guard_01);

