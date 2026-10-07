::Legends.Backgrounds.addBackgroundDefObjects({
	Oathbreaker = {
        HiringCost = 130,
        DailyCost = 18,
        Icon = "ui/backgrounds/background_plus_01.png"
    }
});

// Duplicate Oathtaker camp skills for Oathbreaker
::Legends.BackgroundModifiers.Oathbreaker <- {
	ArmorParts = ::Const.LegendMod.ResourceModifiers.ArmorParts[1],
	Repair = ::Const.LegendMod.ResourceModifiers.Repair[2],
	Salvage = ::Const.LegendMod.ResourceModifiers.Salvage[1],
	ToolConsumption = ::Const.LegendMod.ResourceModifiers.ToolConsumption[1],
	Training = ::Const.LegendMod.ResourceModifiers.Training[2],
	Terrain = {
		Plains = 0.05,
		Farmland = 0.03,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::mods_hookNewObject("skills/backgrounds/oathbreaker_background", function(ob) {
	ob.m.AlignmentMin = ::Const.LegendMod.Alignment.NeutralMin;
	ob.m.AlignmentMax = ::Const.LegendMod.Alignment.Saintly;
});