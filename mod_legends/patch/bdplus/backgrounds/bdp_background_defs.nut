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
