::Legends.Backgrounds.addBackgroundDefObjects({
	BladeDancer = {
		HiringCost = 450,
		DailyCost = 33,
		Icon = "ui/backgrounds/background_bd_plus_01.png"
	},
	Crownling = {
		HiringCost = 100,
		DailyCost = 35,
		Icon = "ui/backgrounds/background_bd_plus_02.png"
	},
	Priest = {
		HiringCost = 65,
		DailyCost = 5,
		Icon = "ui/backgrounds/background_bd_plus_03.png"
	},
	Indemnifier = {
		HiringCost = 60,
		DailyCost = 10,
		Icon = "ui/backgrounds/background_bd_plus_04.png"
	},
	TreasureHunter = {
		HiringCost = 60,
		DailyCost = 7,
		Icon = "ui/backgrounds/background_bd_plus_05.png"
	}
});

::Legends.BackgroundsStats.BladeDancer <- {
	Hitpoints = [0, -3],
	Bravery = [-5, -5],
	Stamina = [-8, -3],
	MeleeSkill = [20, 15],
	RangedSkill = [3, 2],
	MeleeDefense = [8, 12],
	RangedDefense = [3, 5],
	Initiative = [12, 10]
};

::Legends.BackgroundsStats.Crownling <- {
	Hitpoints = [0, 0],
	Bravery = [8, 5],
	Stamina = [0, 0],
	MeleeSkill = [11, 11],
	RangedSkill = [12, 12],
	MeleeDefense = [4, 7],
	RangedDefense = [4, 7],
	Initiative = [0, 0]
};

::Legends.BackgroundsStats.Priest <- {
	Hitpoints = [0, 0],
	Bravery = [9, 9],
	Stamina = [-8, -1],
	MeleeSkill = [-2, -3],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 2],
	Initiative = [0, 0]
};

::Legends.BackgroundsStats.Indemnifier <- {
	Hitpoints = [10, 10],
	Bravery = [10, 5],
	Stamina = [14, 11],
	MeleeSkill = [8, 9],
	RangedSkill = [7, 9],
	MeleeDefense = [4, 4],
	RangedDefense = [2, 2],
	Initiative = [-8, -3]
};

::Legends.BackgroundsStats.TreasureHunter <- {
	Hitpoints = [0, 0],
	Bravery = [8, 5],
	Stamina = [5, 5],
	MeleeSkill = [3, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 1],
	RangedDefense = [0, 1],
	Initiative = [0, 4]
};

local backgrounds = [
	// BD+ background, Legends background it borrows from, background type
	["BladeDancer", "Swordmaster", ::Const.BackgroundType.Combat],
	["Crownling", "Sellsword", ::Const.BackgroundType.Combat],
	["Priest", "Monk", ::Const.BackgroundType.OffendedByViolence | ::Const.BackgroundType.Crusader | ::Const.BackgroundType.Educated],
	["Indemnifier", "Squire", ::Const.BackgroundType.Combat],
	["TreasureHunter", "Graverobber", ::Const.BackgroundType.Lowborn]
];

local setupBackground = function (_name, _from, _type) {
	::Legends.BackgroundPerkTrees[_name] <- clone ::Legends.BackgroundPerkTrees[_from];
	::Legends.BackgroundProfessionTrees[_name] <- clone ::Legends.BackgroundProfessionTrees[_from];
	::Legends.BackgroundModifiers[_name] <- clone ::Legends.BackgroundModifiers[_from];

	local def = ::Legends.Background[_name];
	::mods_hookExactClass(::Legends.Backgrounds.BackgroundDefObjects[def].Script.slice(8), function (o) {
		local create = o.create;
		o.create = function () {
			create();
			::Legends.Backgrounds.onCreate(this, def);
			this.m.BackgroundType = _type;
		}
	});
}

foreach (entry in backgrounds) {
	setupBackground(entry[0], entry[1], entry[2]);
}
