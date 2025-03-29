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
	ID = "barbarians/barbarian_ritual_helmet", //300, -28, -3,
	Script = "",
	Sets = [{
	Hoods = [
	   [1, "hood/legend_helmet_chain_scarf"], //70
	   [1, "hood/legend_helmet_aventail"], //70
	],
	Helms = [
		[1, "helm/legend_helmet_barb_ritual_helm"], //220, -24, -3
	],
	Tops = [],
	Vanity = [
		[1, "vanity/legend_helmet_bull_horns"], //10
	]
}]
},{
	ID = "barbarians/bear_headpiece", //50, -3, 0, 100
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_leather_cap"], //35, 0, 80
		[1, "hood/legend_helmet_padded_cap"], //40, 0
		[1, "hood/legend_helmet_chain_scarf"], //70
		[1, "hood/legend_helmet_aventail"], //70
	],
	Helms = [
	],
	Tops = [
	],
	Vanity = [
		[1, "vanity/legend_helmet_bear_head"], //10
	]
}]
},{
	ID = "barbarians/beastmasters_headpiece", //130, -8, -1, 350
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_barb_open_chain"], //65, -3, 0
		[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
		[1, "hood/legend_helmet_chain_scarf"], //55
		[1, "hood/legend_helmet_aventail"], //60
	],
	Helms = [
		[1, "helm/legend_helmet_barb_metal_cap"], //50, -3, 0
	],
	Tops = [
		[5, ""], //35
		[1, "top/legend_helmet_orc_leather_mask"], //35, -2, -1
		[1, "top/legend_helmet_orc_horn_mask"], //35, -2, -1
	],
	Vanity = [
		[1, "vanity/legend_helmet_goat_horns"], //10
	]
}]
},{
	ID = "barbarians/closed_scrap_metal_helmet", //190, -18, -2, 800
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
		[1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
		[1, "hood/legend_helmet_barb_open_chain"], //65, -3, 0
	],
	Helms = [
		[1, "helm/legend_helmet_crude_cylinder_helm"], //135, -15, -2
	],
	Tops = [
	],
	Vanity = [
		[1, ""],
		[1, "vanity/legend_helmet_bull_horns"], //10
		[1, "vanity/legend_helmet_ram_horns"], //10
		[2, "vanity/legend_helmet_antler"], //10

	]
}]
},{
	ID = "barbarians/crude_faceguard_helmet", //160, -15, -2, 650
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2
		[1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3
		[1, "hood/legend_helmet_barb_open_chain"], //65, -3, 0
	],
	Helms = [
		[1, "helm/legend_helmet_crude_metal_helm"], //100, -10, -1
	],
	Tops = [
	],
	Vanity = [
	]
}]
},{
	ID = "barbarians/crude_metal_helmet", //145, -11, -1
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_barb_leather_cap"], //20
		[1, "hood/legend_helmet_leather_cap"], //35, -1
	],
	Helms = [
		[1, "helm/legend_helmet_crude_metal_helm"], //100, -10, -1
	],
	Tops = [
	],
	Vanity = [
	]
}]
},{
	ID = "barbarians/heavy_horned_plate_helmet", //250, -23, -3, 1300
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
	],
	Helms = [
		[1, "helm/legend_helmet_heavy_plate_helm"], //185, -20, -3
	],
	Tops = [
		[2, ""], //10
		[1, "top/legend_helmet_leather_hood_barb"], //50, -4, -1
		[2, "top/legend_helmet_headband_side"], //20
		[2, "top/legend_helmet_headband_nose"], //25
	],
	Vanity = [
		[1, "vanity/legend_helmet_antler"], //10
		[1, "vanity/legend_helmet_bear_head"], //10
		[5, "vanity/legend_helmet_bull_horns"], //10
		[1, "vanity/legend_helmet_goat_horns"], //10
		[1, "vanity/legend_helmet_ram_horns"], //10
		[1, ""], //10
	]
}]
},{
	ID = "barbarians/leather_headband", //30, 0 ,0
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_barb_leather_cap"], //15, 0
	],
	Helms = [
	],
	Tops = [
		[1, "top/legend_helmet_headband_side"], //20
		[1, "top/legend_helmet_headband_nose"], //25
	],
	Vanity = [
	]
}]
},{
	ID = "barbarians/leather_helmet", //105, -6, -1, 320
	Script = "",
	Sets = [{
	Hoods = [
		[1, "hood/legend_helmet_leather_cap"], //35
		[1, "hood/legend_helmet_padded_cap"], //40, -1
		[1, "hood/legend_helmet_chain_scarf"], //55, -2
		[1, "hood/legend_helmet_aventail"], //70
	],
	Helms = [
		[1, "helm/legend_helmet_barb_metal_cap"], //50, -3, 0
	],
	Tops = [
		[1, "top/legend_helmet_leather_hood_barb"], //50, -4, -1, 200
	],
	Vanity = [
		[1, "vanity/legend_helmet_bull_horns"], //10
		[1, "vanity/legend_helmet_ram_horns"], //10
		[1, "vanity/legend_helmet_ponytail"], //10
		[1, "vanity/legend_helmet_bear_head"], //10
		[10, ""], //30
	]
}]
},{
	ID = "barbarians/unhold_helmet_heavy", //400
	Script = "scripts/items/legend_helmets/helmets/legend_unhold_helmet_heavy",
	Sets = []
},{
	ID = "barbarians/unhold_helmet_light", //35
	Script = "scripts/items/legend_helmets/helmets/legend_unhold_helmet_light",
	Sets = []
}])