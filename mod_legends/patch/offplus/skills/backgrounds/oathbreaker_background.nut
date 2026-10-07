// Duplicate Oathtaker camp skills for Oathbreaker
::mods_hookNewObject("skills/backgrounds/oathbreaker_background", function(ob) {
	ob.m.AlignmentMin = ::Const.LegendMod.Alignment.NeutralMin;
	ob.m.AlignmentMax = ::Const.LegendMod.Alignment.Saintly;

	local modifiers = ob.m.Modifiers;

	modifiers.ArmorParts = ::Const.LegendMod.ResourceModifiers.ArmorParts[1];
	modifiers.Repair = ::Const.LegendMod.ResourceModifiers.Repair[2];
	modifiers.Salvage = ::Const.LegendMod.ResourceModifiers.Salvage[1];
	modifiers.ToolConsumption = ::Const.LegendMod.ResourceModifiers.ToolConsumption[1];
	modifiers.Training = ::Const.LegendMod.ResourceModifiers.Training[2];
	modifiers.Terrain = [
		0.0, // ?
		0.0, //ocean
		0.05, //plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.03, //farmland
		0.0, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];

	ob.m.Modifiers = modifiers;
});