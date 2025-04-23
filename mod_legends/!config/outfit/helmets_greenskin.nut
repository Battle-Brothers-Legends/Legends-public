::Legends.Helmet.Greenskin <- {};

::Legends.Helmet.Greenskin.goblin_heavy_helmet <- {
	ID = "greenskins/goblin_heavy_helmet", //90, -4, 0
	Script = "scripts/items/legend_helmets/helmets/legend_goblin_heavy_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.goblin_heavy_helmet);

::Legends.Helmet.Greenskin.legend_goblin_heavy_helmet <- {
	ID = "legend_goblin_heavy_helmet", //90, -4, 0
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //10
			[1, "hood/legend_helmet_goblin_scarf"], //5
			[1, "hood/legend_helmet_cloth_scarf"], //10
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_goblin_chain_helm"], //70
		],
		Vanity = [
			[1, ""],//10
			[4, "vanity/legend_helmet_ponytail"]//10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.legend_goblin_heavy_helmet);

::Legends.Helmet.Greenskin.goblin_leader_helmet <- { //gob leader helmet
	ID = "greenskins/goblin_leader_helmet", //120
	Script = "scripts/items/legend_helmets/helmets/legend_goblin_leader_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.goblin_leader_helmet);

::Legends.Helmet.Greenskin.goblin_light_helmet <- { //gob light helmet
	ID = "greenskins/goblin_light_helmet", //40
	Script = "scripts/items/legend_helmets/helmets/legend_goblin_light_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.goblin_light_helmet);

::Legends.Helmet.Greenskin.legend_goblin_light_helmet <- { //gob light helmet
	ID = "legend_goblin_light_helmet", //40
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //10
			[1, "hood/legend_helmet_goblin_scarf"], //5
			[1, "hood/legend_helmet_cloth_scarf"], //10
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_goblin_leather_mask"],
			[1, "top/legend_helmet_goblin_leather_helm"],
		],
		Vanity = [
			[1, ""],
			[1, "vanity_lower/legend_helmet_goblin_tail"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.legend_goblin_light_helmet);

::Legends.Helmet.Greenskin.goblin_shaman_helmet <- { //gob shaman
	ID = "greenskins/goblin_shaman_helmet", //35
	Script = "scripts/items/legend_helmets/helmets/legend_goblin_shaman_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.goblin_shaman_helmet);

::Legends.Helmet.Greenskin.goblin_skirmisher_helmet <- { //gob skirmisher
	ID = "greenskins/goblin_skirmisher_helmet", //25
	Script = "scripts/items/legend_helmets/helmets/legend_goblin_skirmisher_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.goblin_skirmisher_helmet);

::Legends.Helmet.Greenskin.legend_goblin_skirmisher_helmet <- { //gob skirmisher
	ID = "legend_goblin_skirmisher_helmet", //25
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //10
			[1, "hood/legend_helmet_goblin_scarf"], //5
			[1, "hood/legend_helmet_cloth_scarf"], //10
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_goblin_leaves"], //5
			[1, "top/legend_helmet_goblin_leaf_helm"], //10
			[1, "top/legend_helmet_goblin_gillie"] //25
		],
		Vanity = [
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.legend_goblin_skirmisher_helmet);

::Legends.Helmet.Greenskin.legend_orc_behemoth_helmet <- {
	ID = "greenskins/legend_orc_behemoth_helmet", //300, -18, 0
	Script = "",
	Sets = [{
		Hoods = [ //avg 45
			[1, "hood/legend_helmet_leather_cap"], //35, -1, 0
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3,
			[1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_orc_behemoth_helmet"], //230,
		],
		Tops = [
		],
		Vanity = [ //+10
			[1, "vanity/legend_helmet_orc_great_horns"], //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.legend_orc_behemoth_helmet);

::Legends.Helmet.Greenskin.orc_berserker_helmet <- {
	ID = "greenskins/orc_berserker_helmet", //120, -10, 0
	Script = "scripts/items/legend_helmets/helmets/legend_orc_berserker_helmet",
	Sets = []
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_berserker_helmet);

::Legends.Helmet.Greenskin.orc_elite_heavy_helmet <- {
	ID = "greenskins/orc_elite_heavy_helmet", //540, -35, 0
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
			[1, "hood/legend_helmet_chain_scarf"], //70, -4, 0
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_orc_elite_double_helm"] //400, -42, -2
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_elite_heavy_helmet);

::Legends.Helmet.Greenskin.orc_warlord_helmet <- {
	ID = "greenskins/orc_warlord_helmet", //500, -25, 0
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
			[1, "hood/legend_helmet_chain_scarf"], //70, -4, 0
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3, 0
			[1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
		],
		Helms = [
			[1, "helm/legend_helmet_orc_great_helm"], //420, -42, -2
		],
		Tops = [],
		Vanity = [
			[2, "vanity_lower/legend_helmet_orc_tail"], //10
			[1, "vanity_lower/legend_helmet_knotted_tail"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_warlord_helmet);

::Legends.Helmet.Greenskin.orc_warrior_heavy_helmet <- {
	ID = "greenskins/orc_warrior_heavy_helmet", //360, -23
	Script = "",
	Sets = [{
		Hoods = [ //avg like 72: Need 29
			[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
			[1, "hood/legend_helmet_chain_scarf"], //70, -4, 0
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3, 0
		],
		Helms = [ //avg 190 : need 100
			[1, "helm/legend_helmet_orc_scale_helm"], //300, -25, -2
		],
		Tops = [],
		Vanity = [
			[3, ""],
			[1, "vanity_lower/legend_helmet_knotted_tail"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_warrior_heavy_helmet);

::Legends.Helmet.Greenskin.orc_warrior_light_helmet <- {
	ID = "greenskins/orc_warrior_light_helmet", //240, -13
	Script = "",
	Sets = [{
		Hoods = [ //need 200
			[4, "hood/legend_helmet_leather_cap"], //35, -1
			[2, "hood/legend_helmet_padded_cap"], //35, -1
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_orc_strapped_helm"] //180
		],
		Tops = [],
		Vanity = [
			[2, ""],
			[1, "vanity/legend_helmet_impaled_head"] //10
		]
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_warrior_light_helmet);

::Legends.Helmet.Greenskin.orc_warrior_medium_helmet <- {
	ID = "greenskins/orc_warrior_medium_helmet", //300, -19
	Script = "",
	Sets = [{
		Hoods = [
			[4, "hood/legend_helmet_leather_cap"], //35, -1
			[2, "hood/legend_helmet_padded_cap"], //35, -1
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3, 0
		],
		Helms = [
			[1, "helm/legend_helmet_orc_double_helm"] //240, -24, -2
		],
		Tops = [],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_warrior_medium_helmet);

::Legends.Helmet.Greenskin.orc_young_heavy_helmet <- {
	ID = "greenskins/orc_young_heavy_helmet", //120, -10, 0
	Script = "",
	Sets = [{
		Hoods = [
			[4, "hood/legend_helmet_leather_cap"], //35, -1
			[2, "hood/legend_helmet_padded_cap"], //35, -1
			[1, "hood/legend_helmet_open_chain_hood"], //60, -3, 0
		],
		Helms = [
		],
		Tops = [
			[1, "top/legend_helmet_orc_metal_mask"], //60, -8, -2
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_young_heavy_helmet);

::Legends.Helmet.Greenskin.orc_young_light_helmet <- {
	ID = "greenskins/orc_young_light_helmet", //35, 0 ,0
	Script = "",
	Sets = [{
		Hoods = [
			[4, "hood/legend_helmet_cloth_cap"], //20, 0
			[2, "hood/legend_helmet_leather_cap"], //35, -1
			[1, "hood/legend_helmet_padded_cap"] //40, -1
		],
		Helms = [],
		Tops = [
			[1, "top/legend_helmet_orc_leather_mask"] //20, 0
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_young_light_helmet);

::Legends.Helmet.Greenskin.orc_young_medium_helmet <- {
	ID = "greenskins/orc_young_medium_helmet", //60, -5
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_cloth_cap"], //20, 0
			[2, "hood/legend_helmet_leather_cap"], //35, 0
			[1, "hood/legend_helmet_padded_cap"] //40, 0
		],
		Helms = [],
		Tops = [
			[1, "top/legend_helmet_orc_horn_mask"], //40, -5, -1
		],
		Vanity = []
	}]
};
::Const.LegendMod.HelmObjs.push(::Legends.Helmet.Greenskin.orc_young_medium_helmet);

