::Legends.Backgrounds.addBackgroundDefObjects({
	Oathbreaker = {
        HiringCost = 130,
        DailyCost = 18,
        Icon = "ui/backgrounds/background_plus_01.png"
    }
});

::Legends.BackgroundsStats.Oathbreaker <- {
    Hitpoints		= [ 10	,	8	]	// 60-68
	Bravery			= [ 3	,	-2	]	// 33-38
	Stamina			= [ 3	,	0	]	// 93-100
	MeleeSkill		= [ 10	,	8	]	// 57-65
	RangedSkill		= [ 0	,	0	]	// 32-42
	MeleeDefense	= [ 4	,	4	]	// 4-8
	RangedDefense	= [ -5	,	-2	]	// -5-3
	Initiative		= [ 10	,	9	]	// 110-119
}

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

	ob.onChangeAttributes() = function () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.Oathbreaker);
	};
});