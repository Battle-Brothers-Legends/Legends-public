local function addEntityType(_type, _troop, _icon, _maxInComp) {
	::BDP.Arena.EntityTypes[_type] <- {
		ID = _troop.ID,
		Type = _type,
		Strength = _troop.Strength,
		MaxInComp = _maxInComp,
		Variant = 0,
		DisplayIcon = "ui/arena/" + _icon + ".png",
		Script = _troop.Script
	};
}

// a champion is worth 25 more than the regular fighter, like the ones of BD+
local function addChampionType(_type, _troop, _icon) {
	addEntityType(_type, _troop, _icon, 1);
	local champion = ::BDP.Arena.EntityTypes[_type];
	champion.Strength += 25;
	champion.Variant = 1;
	champion.NameList <- _troop.NameList;
	champion.TitleList <- _troop.TitleList;
}

local troops = ::Const.World.Spawn.Troops;

addEntityType("BarbarianThrall", troops.BarbarianThrall, "barbarian_low", 6);
addEntityType("BarbarianReaver", troops.BarbarianMarauder, "barbarian_medium", 5);
addEntityType("BarbarianChosen", troops.BarbarianChampion, "barbarian_high", 4);
addChampionType("ChampionBarbarianChosen", troops.BarbarianChampion, "barbarian_high");

addEntityType("OrcYoung", troops.OrcYoung, "orc_low", 5);
addEntityType("OrcBerserker", troops.OrcBerserker, "orc_medium", 3);
addEntityType("OrcWarrior", troops.OrcWarrior, "orc_medium", 4);
addEntityType("OrcWarlord", troops.OrcWarlord, "orc_high", 2);
addChampionType("ChampionOrcWarlord", troops.OrcWarlord, "orc_high");

addEntityType("LegendSkinGhoulLow", troops.LegendSkinGhoulLOW, "skin_ghoul_low", 4);
addEntityType("LegendSkinGhoulMedium", troops.LegendSkinGhoulMED, "skin_ghoul_medium", 3);
addEntityType("LegendSkinGhoulHigh", troops.LegendSkinGhoulHIGH, "skin_ghoul_high", 2);

addEntityType("LegendBasiliskDrone", troops.LegendBasiliskDrone, "basilisk_drone", 4);
addEntityType("LegendBasiliskDroneLow", troops.LegendBasiliskDroneLow, "basilisk_drone", 4);
addEntityType("LegendBasiliskSentry", troops.LegendBasiliskSentry, "basilisk_sentry", 4);

addEntityType("LegendWhiteDirewolf", troops.LegendWhiteDirewolf, "white_direwolf", 2);
addEntityType("LegendRedbackSpider", troops.LegendRedbackSpider, "redback_spider", 2);
addEntityType("LegendRedbackBrood", troops.Spider, "webknecht", 4);
addEntityType("LegendRockUnhold", troops.LegendRockUnhold, "rock_unhold", 2);
addEntityType("LegendStollwurm", troops.LegendStollwurm, "stollwurm", 2);

::BDP.Arena.CompositionNames.Barbarians <- [
	"Barbarians",
	"Barbarians",
	"Barbarians",
	"Northmen",
	"Reavers",
	"Raiders",
	"Savages",
	"Clansmen"
];
::BDP.Arena.CompositionNames.Orcs <- [
	"Orcs",
	"Orcs",
	"Orcs",
	"Greenskins",
	"Greenskins",
	"Brutes",
	"Marauders"
];
::BDP.Arena.CompositionNames.SkinGhouls <- [
	"Skin Ghouls",
	"Skin Ghouls",
	"Skin Ghouls",
	"Pale Devourers",
	"Skin Eaters",
	"Flayed Ones"
];
::BDP.Arena.CompositionNames.Basilisks <- [
	"Basilisks",
	"Basilisks",
	"Basilisks",
	"Great Fowl",
	"Cockatrices",
	"Big Cocks"
];
::BDP.Arena.CompositionNames.WhiteDirewolf <- [
	"White Direwolves",
	"White Direwolves",
	"Wolf Kings",
	"Pale Hunters",
	"Winter Wolves"
];
::BDP.Arena.CompositionNames.RedbackSpider <- [
	"Redback Spiders",
	"Redback Spiders",
	"Broodmothers",
	"Red Widows",
	"Crimson Weavers"
];
::BDP.Arena.CompositionNames.RockUnhold <- [
	"Rock Unholds",
	"Rock Unholds",
	"Stone Giants",
	"Mountain Trolls",
	"Living Boulders"
];
::BDP.Arena.CompositionNames.Stollwurm <- [
	"Stollwurm",
	"Stollwurm",
	"Tunnel Wurm",
	"Elder Wurm",
	"Mountain Dragon"
];

::BDP.Arena.CompositionTitles.Barbarians <- [
	"the Frozen North",
	"the Northern Wastes",
	"the White Wastes",
	"the Endless Snows",
	"the Frozen Coast",
	"the Ancestors\' Halls"
];
::BDP.Arena.CompositionTitles.Orcs <- [
	"the Green Tide",
	"the Broken Steppe",
	"the Bone Camps",
	"the Burning Plains",
	"the Trampled Lands"
];
::BDP.Arena.CompositionTitles.Basilisks <- [
	"the Roost",
	"the Bone Nest",
	"the Crowing Cliffs",
	"the Feathered Hollow"
];
