if (!("Backgrounds" in ::Legends)) {
    ::Legends.Backgrounds <- {};
}

if (!("Background" in ::Legends)) {
    ::Legends.Background <- {};
}

::Legends.Backgrounds.BackgroundDefObjects <- [];

::Legends.Backgrounds.addBackgroundDefObjects <- function (_backgroundDefObjects) {
    local size = ::Legends.Backgrounds.BackgroundDefObjects.len();
    ::Legends.Backgrounds.BackgroundDefObjects.extend(_backgroundDefObjects);
    foreach (i, backgroundDefObject in _backgroundDefObjects) {
        if (backgroundDefObject.Const in ::Legends.Background) {
            ::Legends.Background[backgroundDefObject.Const] = size + i;
        } else {
            ::Legends.Background[backgroundDefObject.Const] <- size + i;
        }
    }
}

// need the ID getter earlier in this case, for config functions
::Legends.Backgrounds.getID <- function (_def) {
	return ::Legends.Backgrounds.BackgroundDefObjects[_def].ID;
}

local backgroundDefs = [];

::Legends.Background.AdventurousNoble <- null;
backgroundDefs.push({
	ID = "background.adventurous_noble",
	Script = "scripts/skills/backgrounds/adventurous_noble_background",
	Const = "AdventurousNoble",
	Name = "Adventurous Noble",
    HiringCost = 300,
    DailyCost = 35,
});

::Legends.Background.Anatomist <- null;
backgroundDefs.push({
    ID = "background.anatomist",
    Script = "scripts/skills/backgrounds/anatomist_background",
    Const = "Anatomist",
    Name = "Anatomist",
    HiringCost = 130,
    DailyCost = 12,
});

::Legends.Background.Apprentice <- null;
backgroundDefs.push({
    ID = "background.apprentice",
    Script = "scripts/skills/backgrounds/apprentice_background",
    Const = "Apprentice",
    Name = "Apprentice",
    HiringCost = 80,
    DailyCost = 6,
});

::Legends.Background.Assassin <- null;
backgroundDefs.push({
    ID = "background.assassin",
    Script = "scripts/skills/backgrounds/assassin_background",
    Const = "Assassin",
    Name = "Assassin",
    HiringCost = 2000,
    DailyCost = 25,
});

::Legends.Background.AssassinSouthern <- null;
backgroundDefs.push({
    ID = "background.assassin_southern",
    Script = "scripts/skills/backgrounds/assassin_southern_background",
    Const = "AssassinSouthern",
    Name = "Southern Assassin",
    HiringCost = 800,
    DailyCost = 25,
});

::Legends.Background.Barbarian <- null;
backgroundDefs.push({
    ID = "background.barbarian",
    Script = "scripts/skills/backgrounds/barbarian_background",
    Const = "Barbarian",
    Name = "Barbarian",
    HiringCost = 300,
    DailyCost = 30,
});

::Legends.Background.Bastard <- null;
backgroundDefs.push({
    ID = "background.bastard",
    Script = "scripts/skills/backgrounds/bastard_background",
    Const = "Bastard",
    Name = "Bastard",
    HiringCost = 170,
    DailyCost = 21,
});

::Legends.Background.BeastSlayer <- null;
backgroundDefs.push({
    ID = "background.beast_slayer",
    Script = "scripts/skills/backgrounds/beast_hunter_background",
    Const = "BeastSlayer",
    Name = "Beast Slayer",
    HiringCost = 150,
    DailyCost = 15,
});

::Legends.Background.Beggar <- null;
backgroundDefs.push({
    ID = "background.beggar",
    Script = "scripts/skills/backgrounds/beggar_background",
    Const = "Beggar",
    Name = "Beggar",
    HiringCost = 30,
    DailyCost = 3,
});

::Legends.Background.BeggarSouthern <- null;
backgroundDefs.push({
    ID = "background.beggar",
    Script = "scripts/skills/backgrounds/beggar_southern_background",
    Const = "BeggarSouthern",
    Name = "Beggar",
    HiringCost = 30,
    DailyCost = 3,
});

::Legends.Background.BellyDancer <- null;
backgroundDefs.push({
    ID = "background.belly_dancer",
    Script = "scripts/skills/backgrounds/belly_dancer_background",
    Const = "BellyDancer",
    Name = "Belly Dancer",
    HiringCost = 500,
    DailyCost = 20,
});

::Legends.Background.Bowyer <- null;
backgroundDefs.push({
    ID = "background.bowyer",
    Script = "scripts/skills/backgrounds/bowyer_background",
    Const = "Bowyer",
    Name = "Bowyer",
    HiringCost = 80,
    DailyCost = 8,
});

::Legends.Background.Brawler <- null;
backgroundDefs.push({
    ID = "background.brawler",
    Script = "scripts/skills/backgrounds/brawler_background",
    Const = "Brawler",
    Name = "Brawler",
    HiringCost = 84,
    DailyCost = 13,
});

::Legends.Background.Butcher <- null;
backgroundDefs.push({
    ID = "background.butcher",
    Script = "scripts/skills/backgrounds/butcher_background",
    Const = "Butcher",
    Name = "Butcher",
    HiringCost = 80,
    DailyCost = 9,
});

::Legends.Background.ButcherSouthern <- null;
backgroundDefs.push({
    ID = "background.butcher",
    Script = "scripts/skills/backgrounds/butcher_southern_background",
    Const = "ButcherSouthern",
    Name = "Butcher",
    HiringCost = 80,
    DailyCost = 9,
});

::Legends.Background.CaravanHand <- null;
backgroundDefs.push({
    ID = "background.caravan_hand",
    Script = "scripts/skills/backgrounds/caravan_hand_background",
    Const = "CaravanHand",
    Name = "Caravan Hand",
    HiringCost = 75,
    DailyCost = 8,
});

::Legends.Background.CaravanHandSouthern <- null;
backgroundDefs.push({
    ID = "background.caravan_hand",
    Script = "scripts/skills/backgrounds/caravan_hand_southern_background",
    Const = "CaravanHandSouthern",
    Name = "Caravan Hand",
    HiringCost = 75,
    DailyCost = 8,
});

::Legends.Background.Companion <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_1h_background",
    Const = "Companion",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 10,
});

::Legends.Background.Companion2h <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_2h_background",
    Const = "Companion2h",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 12,
});

::Legends.Background.CompanionRanged <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_ranged_background",
    Const = "CompanionRanged",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 11,
});

::Legends.Background.CompanionSouthern <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_1h_southern_background",
    Const = "CompanionSouthern",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 10,
});

::Legends.Background.CompanionSouthern2h <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_2h_southern_background",
    Const = "CompanionSouthern2h",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 12,
});

::Legends.Background.CompanionSouthernRanged <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_ranged_southern_background",
    Const = "CompanionSouthernRanged",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 11,
});

::Legends.Background.ConvertedCultist <- null;
backgroundDefs.push({
    ID = "background.converted_cultist",
    Script = "scripts/skills/backgrounds/converted_cultist_background",
    Const = "ConvertedCultist",
    Name = "Converted Cultist",
    HiringCost = 45,
    DailyCost = 4,
});

::Legends.Background.Cripple <- null;
backgroundDefs.push({
    ID = "background.cripple",
    Script = "scripts/skills/backgrounds/cripple_background",
    Const = "Cripple",
    Name = "Cripple",
    HiringCost = 30,
    DailyCost = 2,
});

::Legends.Background.CrippleSouthern <- null;
backgroundDefs.push({
    ID = "background.cripple",
    Script = "scripts/skills/backgrounds/cripple_southern_background",
    Const = "CrippleSouthern",
    Name = "Cripple",
    HiringCost = 30,
    DailyCost = 2,
});

::Legends.Background.Crucified <- null;
backgroundDefs.push({
    ID = "background.crucified",
    Script = "scripts/skills/backgrounds/crucified_background",
    Const = "Crucified",
    Name = "Crucified",
    DailyCost = 30,
    HiringCost = 0,
});

::Legends.Background.Crusader <- null;
backgroundDefs.push({
    ID = "background.crusader",
    Script = "scripts/skills/backgrounds/crusader_background",
    Const = "Crusader",
    Name = "Crusader",
    HiringCost = 200,
    DailyCost = 23,
});

::Legends.Background.Cultist <- null;
backgroundDefs.push({
    ID = "background.cultist",
    Script = "scripts/skills/backgrounds/cultist_background",
    Const = "Cultist",
    Name = "Cultist",
    HiringCost = 50,
    DailyCost = 7,
});

::Legends.Background.Daytaler <- null;
backgroundDefs.push({
    ID = "background.daytaler",
    Script = "scripts/skills/backgrounds/daytaler_background",
    Const = "Daytaler",
    Name = "Daytaler",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.DaytalerSouthern <- null;
backgroundDefs.push({
    ID = "background.daytaler",
    Script = "scripts/skills/backgrounds/daytaler_southern_background",
    Const = "DaytalerSouthern",
    Name = "Daytaler",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.Deserter <- null;
backgroundDefs.push({
    ID = "background.deserter",
    Script = "scripts/skills/backgrounds/deserter_background",
    Const = "Deserter",
    Name = "Deserter",
    HiringCost = 85,
    DailyCost = 11,
});

::Legends.Background.DisownedNoble <- null;
backgroundDefs.push({
    ID = "background.disowned_noble",
    Script = "scripts/skills/backgrounds/disowned_noble_background",
    Const = "DisownedNoble",
    Name = "Disowned Noble",
    HiringCost = 135,
    DailyCost = 17,
});

::Legends.Background.Eunuch <- null;
backgroundDefs.push({
    ID = "background.eunuch",
    Script = "scripts/skills/backgrounds/eunuch_background",
    Const = "Eunuch",
    Name = "Eunuch",
    HiringCost = 60,
    DailyCost = 8,
});

::Legends.Background.EunuchSouthern <- null;
backgroundDefs.push({
    ID = "background.eunuch",
    Script = "scripts/skills/backgrounds/eunuch_southern_background",
    Const = "EunuchSouthern",
    Name = "Eunuch",
    HiringCost = 60,
    DailyCost = 8,
});

::Legends.Background.Executioner <- null;
backgroundDefs.push({
    ID = "background.executioner",
    Script = "scripts/skills/backgrounds/executioner_background",
    Const = "Executioner",
    Name = "Executioner",
    HiringCost = 100,
    DailyCost = 12,
});

::Legends.Background.ExecutionerSouthern <- null;
backgroundDefs.push({
    ID = "background.executioner",
    Script = "scripts/skills/backgrounds/executioner_southern_background",
    Const = "ExecutionerSouthern",
    Name = "Executioner",
    HiringCost = 100,
    DailyCost = 12,
});

::Legends.Background.Farmhand <- null;
backgroundDefs.push({
    ID = "background.farmhand",
    Script = "scripts/skills/backgrounds/farmhand_background",
    Const = "Farmhand",
    Name = "Farmhand",
    HiringCost = 90,
    DailyCost = 10,
});

::Legends.Background.Fisherman <- null;
backgroundDefs.push({
    ID = "background.fisherman",
    Script = "scripts/skills/backgrounds/fisherman_background",
    Const = "Fisherman",
    Name = "Fisherman",
    HiringCost = 78,
    DailyCost = 9,
});

::Legends.Background.FishermanSouthern <- null;
backgroundDefs.push({
    ID = "background.fisherman",
    Script = "scripts/skills/backgrounds/fisherman_southern_background",
    Const = "FishermanSouthern",
    Name = "Fisherman",
    HiringCost = 78,
    DailyCost = 9,
});

::Legends.Background.Flagellant <- null;
backgroundDefs.push({
    ID = "background.flagellant",
    Script = "scripts/skills/backgrounds/flagellant_background",
    Const = "Flagellant",
    Name = "Flagellant",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.Gambler <- null;
backgroundDefs.push({
    ID = "background.gambler",
    Script = "scripts/skills/backgrounds/gambler_background",
    Const = "Gambler",
    Name = "Gambler",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.GamblerSouthern <- null;
backgroundDefs.push({
    ID = "background.gambler",
    Script = "scripts/skills/backgrounds/gambler_southern_background",
    Const = "GamblerSouthern",
    Name = "Gambler",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.Gladiator <- null;
backgroundDefs.push({
    ID = "background.gladiator",
    Script = "scripts/skills/backgrounds/gladiator_background",
    Const = "Gladiator",
    Name = "Gladiator",
    HiringCost = 200,
    DailyCost = 38,
});

::Legends.Background.GladiatorOrigin <- null;
backgroundDefs.push({
    ID = "background.gladiator",
    Script = "scripts/skills/backgrounds/gladiator_origin_background",
    Const = "GladiatorOrigin",
    Name = "Gladiator",
    HiringCost = 200,
    DailyCost = 50,

});

::Legends.Background.Gravedigger <- null;
backgroundDefs.push({
    ID = "background.gravedigger",
    Script = "scripts/skills/backgrounds/gravedigger_background",
    Const = "Gravedigger",
    Name = "Gravedigger",
    HiringCost = 50,
    DailyCost = 5,
});

::Legends.Background.Graverobber <- null;
backgroundDefs.push({
    ID = "background.graverobber",
    Script = "scripts/skills/backgrounds/graverobber_background",
    Const = "Graverobber",
    Name = "Graverobber",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.HedgeKnight <- null;
backgroundDefs.push({
    ID = "background.hedge_knight",
    Script = "scripts/skills/backgrounds/hedge_knight_background",
    Const = "HedgeKnight",
    Name = "Hedge Knight",
    HiringCost = 500,
    DailyCost = 50,
});

::Legends.Background.Historian <- null;
backgroundDefs.push({
    ID = "background.historian",
    Script = "scripts/skills/backgrounds/historian_background",
    Const = "Historian",
    Name = "Historian",
    HiringCost = 100,
    DailyCost = 7,
});

::Legends.Background.Houndmaster <- null;
backgroundDefs.push({
    ID = "background.houndmaster",
    Script = "scripts/skills/backgrounds/houndmaster_background",
    Const = "Houndmaster",
    Name = "Houndmaster",
    HiringCost = 85,
    DailyCost = 11,
});

::Legends.Background.Hunter <- null;
backgroundDefs.push({
    ID = "background.hunter",
    Script = "scripts/skills/backgrounds/hunter_background",
    Const = "Hunter",
    Name = "Hunter",
    HiringCost = 120,
    DailyCost = 20,
});

::Legends.Background.Juggler <- null;
backgroundDefs.push({
    ID = "background.juggler",
    Script = "scripts/skills/backgrounds/juggler_background",
    Const = "Juggler",
    Name = "Juggler",
    HiringCost = 100,
    DailyCost = 8,
});

::Legends.Background.JugglerSouthern <- null;
backgroundDefs.push({
    ID = "background.juggler",
    Script = "scripts/skills/backgrounds/juggler_southern_background",
    Const = "JugglerSouthern",
    Name = "Juggler",
    HiringCost = 100,
    DailyCost = 8,
});

::Legends.Background.KillerOnTheRun <- null;
backgroundDefs.push({
    ID = "background.killer_on_the_run",
    Script = "scripts/skills/backgrounds/killer_on_the_run_background",
    Const = "KillerOnTheRun",
    Name = "Killer On The Run",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.KingsGuard <- null;
backgroundDefs.push({
    ID = "background.kings_guard",
    Script = "scripts/skills/backgrounds/kings_guard_background",
    Const = "KingsGuard",
    Name = "Kings Guard",
    HiringCost = 0,
    DailyCost = 30,
});

::Legends.Background.LindwurmSlayer <- null;
backgroundDefs.push({
    ID = "background.lindwurm_slayer",
    Script = "scripts/skills/backgrounds/lindwurm_slayer_background",
    Const = "LindwurmSlayer",
    Name = "Lindwurm Slayer",
    DailyCost = 31,
    HiringCost = 0,
});

::Legends.Background.Lumberjack <- null;
backgroundDefs.push({
    ID = "background.lumberjack",
    Script = "scripts/skills/backgrounds/lumberjack_background",
    Const = "Lumberjack",
    Name = "Lumberjack",
    HiringCost = 115,
    DailyCost = 13,
});

::Legends.Background.Manhunter <- null;
backgroundDefs.push({
    ID = "background.manhunter",
    Script = "scripts/skills/backgrounds/manhunter_background",
    Const = "Manhunter",
    Name = "Manhunter",
    HiringCost = 120,
    DailyCost = 18,
});

::Legends.Background.Mason <- null;
backgroundDefs.push({
    ID = "background.mason",
    Script = "scripts/skills/backgrounds/mason_background",
    Const = "Mason",
    Name = "Mason",
    HiringCost = 90,
    DailyCost = 8,
});

::Legends.Background.Messenger <- null;
backgroundDefs.push({
    ID = "background.messenger",
    Script = "scripts/skills/backgrounds/messenger_background",
    Const = "Messenger",
    Name = "Messenger",
    HiringCost = 80,
    DailyCost = 9,
});

::Legends.Background.Militia <- null;
backgroundDefs.push({
    ID = "background.militia",
    Script = "scripts/skills/backgrounds/militia_background",
    Const = "Militia",
    Name = "Militia",
    HiringCost = 85,
    DailyCost = 14,
});

::Legends.Background.Miller <- null;
backgroundDefs.push({
    ID = "background.miller",
    Script = "scripts/skills/backgrounds/miller_background",
    Const = "Miller",
    Name = "Miller",
    HiringCost = 65,
    DailyCost = 7,
});

::Legends.Background.Miner <- null;
backgroundDefs.push({
    ID = "background.miner",
    Script = "scripts/skills/backgrounds/miner_background",
    Const = "Miner",
    Name = "Miner",
    HiringCost = 75,
    DailyCost = 10,
            
});

::Legends.Background.Minstrel <- null;
backgroundDefs.push({
    ID = "background.minstrel",
    Script = "scripts/skills/backgrounds/minstrel_background",
    Const = "Minstrel",
    Name = "Minstrel",
    HiringCost = 665,
    DailyCost = 19,
});

::Legends.Background.Monk <- null;
backgroundDefs.push({
    ID = "background.monk",
    Script = "scripts/skills/backgrounds/monk_background",
    Const = "Monk",
    Name = "Monk",
    HiringCost = 60,
    DailyCost = 5,
});

::Legends.Background.MonkTurnedFlagellant <- null;
backgroundDefs.push({
    ID = "background.monk_turned_flagellant",
    Script = "scripts/skills/backgrounds/monk_turned_flagellant_background",
    Const = "MonkTurnedFlagellant",
    Name = "Monk Turned Flagellant",
    HiringCost = 60,
    DailyCost = 5,
});

::Legends.Background.Nomad <- null;
backgroundDefs.push({
    ID = "background.nomad",
    Script = "scripts/skills/backgrounds/nomad_background",
    Const = "Nomad",
    Name = "Nomad",
    HiringCost = 200,
    DailyCost = 28,
});

::Legends.Background.NomadRanged <- null;
backgroundDefs.push({
    ID = "background.nomad",
    Script = "scripts/skills/backgrounds/nomad_ranged_background",
    Const = "NomadRanged",
    Name = "Nomad",
    HiringCost = 300,
    DailyCost = 28,
});

::Legends.Background.OrcSlayer <- null;
backgroundDefs.push({
    ID = "background.orc_slayer",
    Script = "scripts/skills/backgrounds/orc_slayer_background",
    Const = "OrcSlayer",
    Name = "Orc Slayer",
    HiringCost = 200,
    DailyCost = 25,
});

::Legends.Background.PacifiedFlagellant <- null;
backgroundDefs.push({
    ID = "background.pacified_flagellant",
    Script = "scripts/skills/backgrounds/pacified_flagellant_background",
    Const = "PacifiedFlagellant",
    Name = "Pacified Flagellant",
    HiringCost = 60,
    DailyCost = 5,
});

::Legends.Background.Paladin <- null;
backgroundDefs.push({
    ID = "background.paladin",
    Script = "scripts/skills/backgrounds/paladin_background",
    Const = "Paladin",
    Name = "Paladin",
    HiringCost = 150,
    DailyCost = 22,
});

::Legends.Background.PaladinOld <- null;
backgroundDefs.push({
    ID = "background.paladin",
    Script = "scripts/skills/backgrounds/old_paladin_background",
    Const = "PaladinOld",
    Name = "Paladin",
    HiringCost = 150,
    DailyCost = 22,
});

::Legends.Background.Peddler <- null;
backgroundDefs.push({
    ID = "background.peddler",
    Script = "scripts/skills/backgrounds/peddler_background",
    Const = "Peddler",
    Name = "Peddler",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.PeddlerSouthern <- null;
backgroundDefs.push({
    ID = "background.peddler",
    Script = "scripts/skills/backgrounds/peddler_southern_background",
    Const = "PeddlerSouthern",
    Name = "Peddler",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.Pimp <- null;
backgroundDefs.push({
    ID = "background.pimp",
    Script = "scripts/skills/backgrounds/pimp_background",
    Const = "Pimp",
    Name = "Pimp",
    HiringCost = 60,
    DailyCost = 6,
});

::Legends.Background.Poacher <- null;
backgroundDefs.push({
    ID = "background.poacher",
    Script = "scripts/skills/backgrounds/poacher_background",
    Const = "Poacher",
    Name = "Poacher",
    HiringCost = 100,
    DailyCost = 10,
});

::Legends.Background.Raider <- null;
backgroundDefs.push({
    ID = "background.raider",
    Script = "scripts/skills/backgrounds/raider_background",
    Const = "Raider",
    Name = "Raider",
    HiringCost = 160,
    DailyCost = 28,
});

::Legends.Background.Ratcatcher <- null;
backgroundDefs.push({
    ID = "background.ratcatcher",
    Script = "scripts/skills/backgrounds/ratcatcher_background",
    Const = "Ratcatcher",
    Name = "Ratcatcher",
    HiringCost = 40,
    DailyCost = 4,
});

::Legends.Background.Refugee <- null;
backgroundDefs.push({
    ID = "background.refugee",
    Script = "scripts/skills/backgrounds/refugee_background",
    Const = "Refugee",
    Name = "Refugee",
    HiringCost = 40,
    DailyCost = 4,
});

::Legends.Background.RegentInAbsentia <- null;
backgroundDefs.push({
    ID = "background.regent_in_absentia",
    Script = "scripts/skills/backgrounds/regent_in_absentia_background",
    Const = "RegentInAbsentia",
    Name = "Regent In Absentia",
    HiringCost = 135,
    DailyCost = 30,
});

::Legends.Background.RetiredSoldier <- null;
backgroundDefs.push({
    ID = "background.retired_soldier",
    Script = "scripts/skills/backgrounds/retired_soldier_background",
    Const = "RetiredSoldier",
    Name = "Retired Soldier",
    HiringCost = 140,
    DailyCost = 15,
});

::Legends.Background.Sellsword <- null;
backgroundDefs.push({
    ID = "background.sellsword",
    Script = "scripts/skills/backgrounds/sellsword_background",
    Const = "Sellsword",
    Name = "Sellsword",
    HiringCost = 100,
    DailyCost = 35,
});

::Legends.Background.Servant <- null;
backgroundDefs.push({
    ID = "background.servant",
    Script = "scripts/skills/backgrounds/servant_background",
    Const = "Servant",
    Name = "Servant",
    HiringCost = 45,
    DailyCost = 4,
});

::Legends.Background.Shepherd <- null;
backgroundDefs.push({
    ID = "background.shepherd",
    Script = "scripts/skills/backgrounds/shepherd_background",
    Const = "Shepherd",
    Name = "Shepherd",
    HiringCost = 80,
    DailyCost = 8,
});

::Legends.Background.ShepherdSouthern <- null;
backgroundDefs.push({
    ID = "background.shepherd",
    Script = "scripts/skills/backgrounds/shepherd_southern_background",
    Const = "ShepherdSouthern",
    Name = "Shepherd",
    HiringCost = 80,
    DailyCost = 8,
});

::Legends.Background.Slave <- null;
backgroundDefs.push({
    ID = "background.slave",
    Script = "scripts/skills/backgrounds/slave_background",
    Const = "Slave",
    Name = "Slave",
    HiringCost =    th.rand(19, 22) * 10,
    DailyCost = 0,
});

::Legends.Background.SlaveBarbarian <- null;
backgroundDefs.push({
    ID = "background.slave",
    Script = "scripts/skills/backgrounds/slave_barbarian_background",
    Const = "SlaveBarbarian",
    Name = "Slave",
    HiringCost =    th.rand(19, 22) * 10,
    DailyCost = 0,
});

::Legends.Background.SlaveSouthern <- null;
backgroundDefs.push({
    ID = "background.slave",
    Script = "scripts/skills/backgrounds/slave_southern_background",
    Const = "SlaveSouthern",
    Name = "Slave",
    HiringCost =    th.rand(19, 22) * 10,
    DailyCost = 0,
});

::Legends.Background.Squire <- null;
backgroundDefs.push({
    ID = "background.squire",
    Script = "scripts/skills/backgrounds/squire_background",
    Const = "Squire",
    Name = "Squire",
    HiringCost = 320,
    DailyCost = 26,
});

::Legends.Background.Swordmaster <- null;
backgroundDefs.push({
    ID = "background.swordmaster",
    Script = "scripts/skills/backgrounds/swordmaster_background",
    Const = "Swordmaster",
    Name = "Swordmaster",
    HiringCost = 400,
    DailyCost = 35,
});

::Legends.Background.Tailor <- null;
backgroundDefs.push({
    ID = "background.tailor",
    Script = "scripts/skills/backgrounds/tailor_background",
    Const = "Tailor",
    Name = "Tailor",
    HiringCost = 50,
    DailyCost = 5,
});

::Legends.Background.TailorSouthern <- null;
backgroundDefs.push({
    ID = "background.tailor",
    Script = "scripts/skills/backgrounds/tailor_southern_background",
    Const = "TailorSouthern",
    Name = "Tailor",
    HiringCost = 50,
    DailyCost = 5,
});

::Legends.Background.Thief <- null;
backgroundDefs.push({
    ID = "background.thief",
    Script = "scripts/skills/backgrounds/thief_background",
    Const = "Thief",
    Name = "Thief",
    HiringCost = 95,
    DailyCost = 10,
});

::Legends.Background.ThiefSouthern <- null;
backgroundDefs.push({
    ID = "background.thief",
    Script = "scripts/skills/backgrounds/thief_southern_background",
    Const = "ThiefSouthern",
    Name = "Thief",
    HiringCost = 95,
    DailyCost = 10,
});

::Legends.Background.Vagabond <- null;
backgroundDefs.push({
    ID = "background.vagabond",
    Script = "scripts/skills/backgrounds/vagabond_background",
    Const = "Vagabond",
    Name = "Vagabond",
    HiringCost = 70,
    DailyCost = 9,
});

::Legends.Background.Wildman <- null;
backgroundDefs.push({
    ID = "background.wildman",
    Script = "scripts/skills/backgrounds/wildman_background",
    Const = "Wildman",
    Name = "Wildman",
    HiringCost = 200,
    DailyCost = 18,
});

::Legends.Background.Witchhunter <- null;
backgroundDefs.push({
    ID = "background.witchhunter",
    Script = "scripts/skills/backgrounds/witchhunter_background",
    Const = "Witchhunter",
    Name = "Witchhunter",
    HiringCost = 325,
    DailyCost = 21,
});

::Legends.Background.LegendAdventurousLady <- null;
backgroundDefs.push({
    ID = "background.legend_adventurous_lady",
    Script = "scripts/skills/backgrounds/legend_adventurous_lady_background",
    Const = "LegendAdventurousLady",
    Name = "Adventurous Lady",
    HiringCost = 300,
    DailyCost = 35,
});

::Legends.Background.LegendAlchemist <- null;
backgroundDefs.push({
    ID = "background.legend_alchemist",
    Script = "scripts/skills/backgrounds/legend_alchemist_background",
    Const = "LegendAlchemist",
    Name = "Alchemist",
    HiringCost = 1250,
    DailyCost = 20,
});

::Legends.Background.LegendBattleSister <- null;
backgroundDefs.push({
    ID = "background.legend_battle_sister",
    Script = "scripts/skills/backgrounds/legend_battle_sister_background",
    Const = "LegendBattleSister",
    Name = "Battle Sister",
    HiringCost = 160, //currently cannot recruit battle sisters - will update in inq. origin update - Luft
    DailyCost = 18,
});

::Legends.Background.LegendBellyDancer <- null;
backgroundDefs.push({
    ID = "background.legend_belly_dancer",
    Script = "scripts/skills/backgrounds/legend_belly_dancer_background",
    Const = "LegendBellyDancer",
    Name = "Belly Dancer",
    HiringCost = 500,
    DailyCost = 10,
});

::Legends.Background.LegendBerserker <- null;
backgroundDefs.push({
    ID = "background.legend_berserker",
    Script = "scripts/skills/backgrounds/legend_berserker_background",
    Const = "LegendBerserker",
    Name = "Berserker",
    HiringCost = 3500,
    DailyCost = 35,
});

::Legends.Background.LegendBlacksmith <- null;
backgroundDefs.push({
    ID = "background.legend_blacksmith",
    Script = "scripts/skills/backgrounds/legend_blacksmith_background",
    Const = "LegendBlacksmith",
    Name = "Blacksmith",
    HiringCost = 500,
    DailyCost = 23,
});

::Legends.Background.LegendBladedancer <- null;
backgroundDefs.push({
    ID = "background.legend_bladedancer",
    Script = "scripts/skills/backgrounds/legend_bladedancer_background",
    Const = "LegendBladedancer",
    Name = "Bladedancer",
    HiringCost = 850,
    DailyCost = 45,
});

::Legends.Background.LegendBountyHunter <- null;
backgroundDefs.push({
    ID = "background.legend_bounty_hunter",
    Script = "scripts/skills/backgrounds/legend_bounty_hunter_background",
    Const = "LegendBountyHunter",
    Name = "Bounty Hunter",
    HiringCost = 500,
    DailyCost = 55,
});

::Legends.Background.LegendCommanderAssassin <- null;
backgroundDefs.push({
    ID = "background.legend_commander_assassin",
    Script = "scripts/skills/backgrounds/legend_assassin_commander_background",
    Const = "LegendCommanderAssassin",
    Name = "Assassin Commander",
    HiringCost = 10000,
    DailyCost = 0,
});

::Legends.Background.LegendCommanderBeggar <- null;
backgroundDefs.push({
    ID = "background.legend_commander_beggar",
    Script = "scripts/skills/backgrounds/legend_beggar_commander_background",
    Const = "LegendCommanderBeggar",
    Name = "Beggar Commander",
    HiringCost = 30,
    DailyCost = 0,
});

::Legends.Background.LegendCommanderBeggarScaling <- null;
backgroundDefs.push({
    ID = "background.legend_beggar_commander_op",
    Script = "scripts/skills/backgrounds/legend_beggar_commander_op_background",
    Const = "LegendCommanderBeggarScaling",
    Name = "Beggar Commander",
    HiringCost = 30,
    DailyCost = 0,
});

::Legends.Background.LegendCommanderBerserker <- null;
backgroundDefs.push({
    ID = "background.legend_commander_berserker",
    Script = "scripts/skills/backgrounds/legend_berserker_commander_background",
    Const = "LegendCommanderBerserker",
    Name = "Berserker Commander",
    HiringCost = 10000,
    DailyCost = 0,

});

::Legends.Background.LegendCommanderNecro <- null;
backgroundDefs.push({
    ID = "background.legend_commander_necro",
    Script = "scripts/skills/backgrounds/legend_necro_commander_background",
    Const = "LegendCommanderNecro",
    Name = "Master Necromancer",
    HiringCost = 1200000000000,
    DailyCost = 0,
});

::Legends.Background.LegendCommanderNoble <- null;
backgroundDefs.push({
    ID = "background.legend_commander_noble",
    Script = "scripts/skills/backgrounds/legend_noble_commander_background",
    Const = "LegendCommanderNoble",
    Name = "Noble Commander",
    HiringCost = 25000,
    DailyCost = 25,
});

::Legends.Background.LegendCommanderPeddler <- null;
backgroundDefs.push({
    ID = "background.legend_commander_peddler",
    Script = "scripts/skills/backgrounds/legend_peddler_commander_background",
    Const = "LegendCommanderPeddler",
    Name = "Peddler Commander",
    HiringCost = 10000,
    DailyCost = 0,
});

::Legends.Background.LegendCommanderRanger <- null;
backgroundDefs.push({
    ID = "background.legend_commander_ranger",
    Script = "scripts/skills/backgrounds/legend_ranger_commander_background",
    Const = "LegendCommanderRanger",
    Name = "Ranger Commander",
    HiringCost = 12000,
    DailyCost = 0,
});

::Legends.Background.LegendSeer <- null;
backgroundDefs.push({
    ID = "background.legend_seer",
    Script = "scripts/skills/backgrounds/legend_seer_background",
    Const = "LegendSeer",
    Name = "Seer",
    HiringCost = 250,
    DailyCost = 0,
});

::Legends.Background.LegendCompanionMelee <- null;
backgroundDefs.push({
    ID = "background.legend_companion_melee",
    Script = "scripts/skills/backgrounds/legend_companion_melee_background",
    Const = "LegendCompanionMelee",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendCompanionRanged <- null;
backgroundDefs.push({
    ID = "background.legend_companion_ranged",
    Script = "scripts/skills/backgrounds/legend_companion_ranged_background",
    Const = "LegendCompanionRanged",
    Name = "Companion",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendConscript <- null;
backgroundDefs.push({
    ID = "background.legend_conscript",
    Script = "scripts/skills/backgrounds/legend_conscript_background",
    Const = "LegendConscript",
    Name = "Conscript",
    HiringCost = 300,
    DailyCost = 35,
});

::Legends.Background.LegendConscriptRanged <- null;
backgroundDefs.push({
    ID = "background.legend_conscript",
    Script = "scripts/skills/backgrounds/legend_conscript_ranged_background",
    Const = "LegendConscriptRanged",
    Name = "Conscript Ranged",
    HiringCost = 100,
    DailyCost = 35,
});

::Legends.Background.LegendCrusader <- null;
backgroundDefs.push({
    ID = "background.legend_crusader",
    Script = "scripts/skills/backgrounds/legend_crusader_background",
    Const = "LegendCrusader",
    Name = "Crusader",
    HiringCost = 3500,
    DailyCost = 0,
});

::Legends.Background.LegendDervish <- null;
backgroundDefs.push({
    ID = "background.legend_dervish",
    Script = "scripts/skills/backgrounds/legend_dervish_background",
    Const = "LegendDervish",
    Name = "Dervish",
    HiringCost = 140,
    DailyCost = 14,
});

::Legends.Background.LegendDisownedLady <- null;
backgroundDefs.push({
    ID = "background.legend_disowned_lady",
    Script = "scripts/skills/backgrounds/legend_disowned_lady_background",
    Const = "LegendDisownedLady",
    Name = "Disowned Lady",
    HiringCost = 135,
    DailyCost = 17,
});

::Legends.Background.LegendDonkey <- null;
backgroundDefs.push({
    ID = "background.legend_donkey",
    Script = "scripts/skills/backgrounds/legend_donkey_background",
    Const = "LegendDonkey",
    Name = "Donkey",
    HiringCost = 5000,
    DailyCost = 0,
});

::Legends.Background.LegendDruid <- null;
backgroundDefs.push({
    ID = "background.legend_druid",
    Script = "scripts/skills/backgrounds/legend_druid_background",
    Const = "LegendDruid",
    Name = "Druid",
    HiringCost = 2000,
    DailyCost = 25,
});

::Legends.Background.LegendGladiatorPrizefighter <- null;
backgroundDefs.push({
    ID = "background.gladiator",
    Script = "scripts/skills/backgrounds/legend_gladiator_prizefighter_background",
    Const = "LegendGladiatorPrizefighter",
    Name = "Gladiator Prizefighter",
    HiringCost = 550,
    DailyCost = 38,

});

::Legends.Background.LegendGuildmaster <- null;
backgroundDefs.push({
    ID = "background.legend_guildmaster",
    Script = "scripts/skills/backgrounds/legend_guildmaster_background",
    Const = "LegendGuildmaster",
    Name = "Guildmaster",
    HiringCost = 185,
    DailyCost = 27,
});

::Legends.Background.LegendHerbalist <- null;
backgroundDefs.push({
    ID = "background.legend_herbalist",
    Script = "scripts/skills/backgrounds/legend_herbalist_background",
    Const = "LegendHerbalist",
    Name = "Herbalist",
    HiringCost = 120,
    DailyCost = 18,
});

::Legends.Background.LegendHorse <- null;
backgroundDefs.push({
    ID = "background.legend_horse",
    Script = "scripts/skills/backgrounds/legend_horse",
    Const = "LegendHorse",
    Name = "Horse",
    HiringCost = 10000,
    DailyCost = 1,
});

::Legends.Background.LegendHorserider <- null;
backgroundDefs.push({
    ID = "background.legend_horserider",
    Script = "scripts/skills/backgrounds/legend_horserider",
    Const = "LegendHorserider",
    Name = "Horserider",
    HiringCost = 10000,
    DailyCost = 1,

});

::Legends.Background.LegendHorseCourser <- null;
backgroundDefs.push({
    ID = "background.legend_horse_courser",
    Script = "scripts/skills/backgrounds/legend_horse_courser",
    Const = "LegendHorseCourser",
    Name = "Horse Courser",
    HiringCost = 20000,
    DailyCost = 1,
});

::Legends.Background.LegendHorseDestrier <- null;
backgroundDefs.push({
    ID = "background.legend_horse_destrier",
    Script = "scripts/skills/backgrounds/legend_horse_destrier",
    Const = "LegendHorseDestrier",
    Name = "Horse Destrier",
    HiringCost = 55000,
    DailyCost = 1,
});

::Legends.Background.LegendHorseRouncey <- null;
backgroundDefs.push({
    ID = "background.legend_horse_rouncey",
    Script = "scripts/skills/backgrounds/legend_horse_rouncey",
    Const = "LegendHorseRouncey",
    Name = "Horse Rouncey",
    HiringCost = 10000,
    DailyCost = 1,
});

::Legends.Background.LegendHusk <- null;
backgroundDefs.push({
    ID = "background.legend_husk",
    Script = "scripts/skills/backgrounds/legend_husk_background",
    Const = "LegendHusk",
    Name = "Husk",
    HiringCost = 150,
    DailyCost = 20,
});

::Legends.Background.LegendIllusionist <- null;
backgroundDefs.push({
    ID = "background.legend_illusionist",
    Script = "scripts/skills/backgrounds/legend_illusionist_background",
    Const = "LegendIllusionist",
    Name = "Illusionist",
    HiringCost = 1000,
    DailyCost = 20,
});

::Legends.Background.LegendInventor <- null;
backgroundDefs.push({
    ID = "background.legend_inventor",
    Script = "scripts/skills/backgrounds/legend_inventor_background",
    Const = "LegendInventor",
    Name = "Inventor",
    HiringCost = 1250,
    DailyCost = 25,
});

::Legends.Background.LegendIronmonger <- null;
backgroundDefs.push({
    ID = "background.legend_ironmonger",
    Script = "scripts/skills/backgrounds/legend_ironmonger_background",
    Const = "LegendIronmonger",
    Name = "Ironmonger",
    HiringCost = 100,
    DailyCost = 11,
});

::Legends.Background.LegendLeechPeddler <- null;
backgroundDefs.push({
    ID = "background.legend_leech_peddler",
    Script = "scripts/skills/backgrounds/legend_leech_peddler_background",
    Const = "LegendLeechPeddler",
    Name = "Leech Peddler",
    HiringCost = 45,
    DailyCost = 6,
});

::Legends.Background.LegendLegionAuxiliary <- null;
backgroundDefs.push({
    ID = "background.legend_legion_auxiliary",
    Script = "scripts/skills/backgrounds/legend_legion_auxiliary_background",
    Const = "LegendLegionAuxiliary",
    Name = "Legion Auxiliary",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionCenturion <- null;
backgroundDefs.push({
    ID = "background.legend_legion_centurion",
    Script = "scripts/skills/backgrounds/legend_legion_centurion_background",
    Const = "LegendLegionCenturion",
    Name = "Legion Centurion",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionGladiator <- null;
backgroundDefs.push({
    ID = "background.legend_legion_gladiator",
    Script = "scripts/skills/backgrounds/legend_legion_gladiator_background",
    Const = "LegendLegionGladiator",
    Name = "Legion Gladiator",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionHonourGuard <- null;
backgroundDefs.push({
    ID = "background.legend_legion_honour_guard",
    Script = "scripts/skills/backgrounds/legend_legion_honour_guard_background",
    Const = "LegendLegionHonourGuard",
    Name = "Legion Honour Guard",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionLegate <- null;
backgroundDefs.push({
    ID = "background.legend_legion_legate",
    Script = "scripts/skills/backgrounds/legend_legion_legate_background",
    Const = "LegendLegionLegate",
    Name = "Legion Legate",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionLegionary <- null;
backgroundDefs.push({
    ID = "background.legend_legion_legionary",
    Script = "scripts/skills/backgrounds/legend_legion_legionary_background",
    Const = "LegendLegionLegionary",
    Name = "Legion Legionary",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionPrefect <- null;
backgroundDefs.push({
    ID = "background.legend_legion_prefect",
    Script = "scripts/skills/backgrounds/legend_legion_prefect_background",
    Const = "LegendLegionPrefect",
    Name = "Legion Prefect",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLegionSlave <- null;
backgroundDefs.push({
    ID = "background.legend_legion_slave",
    Script = "scripts/skills/backgrounds/legend_legion_slave_background",
    Const = "LegendLegionSlave",
    Name = "Legion Slave",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLonewolf <- null;
backgroundDefs.push({
    ID = "background.legend_lonewolf",
    Script = "scripts/skills/backgrounds/legend_lonewolf_background",
    Const = "LegendLonewolf",
    Name = "Lonewolf",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendLurker <- null;
backgroundDefs.push({
    ID = "background.legend_lurker",
    Script = "scripts/skills/backgrounds/legend_lurker_background",
    Const = "LegendLurker",
    Name = "Lurker",
    HiringCost = 120,
    DailyCost = 11,
});

::Legends.Background.LegendMagister <- null;
backgroundDefs.push({
    ID = "background.legend_magister",
    Script = "scripts/skills/backgrounds/legend_magister_background",
    Const = "LegendMagister",
    Name = "Magister",
    HiringCost = 250,
    DailyCost = 27,
});

::Legends.Background.LegendManAtArms <- null;
backgroundDefs.push({
    ID = "background.legend_man_at_arms",
    Script = "scripts/skills/backgrounds/legend_man_at_arms_background",
    Const = "LegendManAtArms",
    Name = "Man At Arms",
    HiringCost = 130,
    DailyCost = 15,
});

::Legends.Background.LegendMasterArcher <- null;
backgroundDefs.push({
    ID = "background.legend_master_archer",
    Script = "scripts/skills/backgrounds/legend_master_archer_background",
    Const = "LegendMasterArcher",
    Name = "Master Archer",
    HiringCost = 885,
    DailyCost = 32,
});

::Legends.Background.LegendMuladi <- null;
backgroundDefs.push({
    ID = "background.legend_muladi",
    Script = "scripts/skills/backgrounds/legend_muladi_background",
    Const = "LegendMuladi",
    Name = "Muladi",
    HiringCost = 100,
    DailyCost = 16,
});

::Legends.Background.LegendNecromancer <- null;
backgroundDefs.push({
    ID = "background.legend_necromancer",
    Script = "scripts/skills/backgrounds/legend_necromancer_background",
    Const = "LegendNecromancer",
    Name = "Necromancer",
    HiringCost = 1000,
    DailyCost = 20,
});

::Legends.Background.LegendNecrosavant <- null;
backgroundDefs.push({
    ID = "background.legend_necrosavant",
    Script = "scripts/skills/backgrounds/legend_necrosavant_background",
    Const = "LegendNecrosavant",
    Name = "Necrosavant",
    HiringCost = 1000,
    DailyCost = 20,
});

::Legends.Background.LegendNecro <- null;
backgroundDefs.push({
    ID = "background.legend_necro",
    Script = "scripts/skills/backgrounds/legend_necro_background",
    Const = "LegendNecro",
    Name = "Warlock",
    HiringCost = 20000,
    DailyCost = 50,
});

::Legends.Background.LegendNightwatch <- null;
backgroundDefs.push({
    ID = "background.legend_nightwatch",
    Script = "scripts/skills/backgrounds/legend_nightwatch_background",
    Const = "LegendNightwatch",
    Name = "Nightwatch",
    HiringCost = 120,
    DailyCost = 10,
});

::Legends.Background.LegendHouseGuard <- null;
backgroundDefs.push({
    ID = "background.legend_houseguard",
    Script = "scripts/skills/backgrounds/legend_houseguard_background",
    Const = "LegendHouseGuard",
    Name = "House Guard",
    HiringCost = 500,
    DailyCost = 35,
});

::Legends.Background.LegendArbalester <- null;
backgroundDefs.push({
    ID = "background.legend_arbalester",
    Script = "scripts/skills/backgrounds/legend_arbalester_background",
    Const = "LegendArbalester",
    Name = "Arbalester",
    HiringCost = 900,
    DailyCost = 35,
});

::Legends.Background.LegendFootSoldier <- null;
backgroundDefs.push({
    ID = "background.legend_foot_soldier",
    Script = "scripts/skills/backgrounds/legend_foot_soldier_background",
    Const = "LegendFootSoldier",
    Name = "Foot Soldier",
    HiringCost = 300,
    DailyCost = 35,
});

::Legends.Background.LegendPilgrim <- null;
backgroundDefs.push({
    ID = "background.legend_pilgrim",
    Script = "scripts/skills/backgrounds/legend_pilgrim_background",
    Const = "LegendPilgrim",
    Name = "Pilgrim",
    HiringCost = 0,
    DailyCost = 5,
});

::Legends.Background.LegendPreserver <- null;
backgroundDefs.push({
    ID = "background.legend_preserver",
    Script = "scripts/skills/backgrounds/legend_preserver_background",
    Const = "LegendPreserver",
    Name = "Preserver",
    HiringCost = 1200000000000,
    DailyCost = 0,
});

::Legends.Background.LegendPuppet <- null;
backgroundDefs.push({
    ID = "background.legend_puppet",
    Script = "scripts/skills/backgrounds/legend_puppet_background",
    Const = "LegendPuppet",
    Name = "Puppet",
    HiringCost = 0,
    DailyCost = 0,
});

::Legends.Background.LegendPuppetMaster <- null;
backgroundDefs.push({
    ID = "background.legend_puppet_master",
    Script = "scripts/skills/backgrounds/legend_puppet_master_background",
    Const = "LegendPuppetMaster",
    Name = "Puppet Master",
    HiringCost = 1200000000000,
    DailyCost = 0,
});

::Legends.Background.LegendRanger <- null;
backgroundDefs.push({
    ID = "background.legend_ranger",
    Script = "scripts/skills/backgrounds/legend_ranger_background",
    Const = "LegendRanger",
    Name = "Ranger",
    HiringCost = 2500,
    DailyCost = 35,
});

::Legends.Background.LegendShieldmaiden <- null;
backgroundDefs.push({
    ID = "background.legend_shieldmaiden",
    Script = "scripts/skills/backgrounds/legend_shieldmaiden_background",
    Const = "LegendShieldmaiden",
    Name = "Shieldmaiden",
    HiringCost = 450,
    DailyCost = 30,
});

::Legends.Background.LegendSurgeon <- null;
backgroundDefs.push({
    ID = "background.legend_surgeon",
    Script = "scripts/skills/backgrounds/legend_surgeon_background",
    Const = "LegendSurgeon",
    Name = "Surgeon",
    HiringCost = 0,
    DailyCost = 45,
});

::Legends.Background.LegendTaxidermist <- null;
backgroundDefs.push({
    ID = "background.legend_taxidermist",
    Script = "scripts/skills/backgrounds/legend_taxidermist_background",
    Const = "LegendTaxidermist",
    Name = "Taxidermist",
    HiringCost = 250,
    DailyCost = 10,
});

::Legends.Background.LegendVala <- null;
backgroundDefs.push({
    ID = "background.legend_vala",
    Script = "scripts/skills/backgrounds/legend_vala_background",
    Const = "LegendVala",
    Name = "Vala",
    HiringCost = 20000,
    DailyCost = 24,
});

::Legends.Background.LegendWarlock <- null;
backgroundDefs.push({
    ID = "background.legend_warlock",
    Script = "scripts/skills/backgrounds/legend_warlock_background",
    Const = "LegendWarlock",
    Name = "Warlock",
    HiringCost = 1000,
    DailyCost = 20,
});

::Legends.Background.LegendWarlockSummoner <- null;
backgroundDefs.push({
    ID = "background.legend_warlock_summoner",
    Script = "scripts/skills/backgrounds/legend_warlock_summoner_background",
    Const = "LegendWarlockSummoner",
    Name = "Warlock Summoner",
    HiringCost = 1200000000000,
    DailyCost = 0,
});

::Legends.Background.LegendYoungblood <- null;
backgroundDefs.push({
    ID = "background.legend_youngblood",
    Script = "scripts/skills/backgrounds/legend_youngblood_background",
    Const = "LegendYoungblood",
    Name = "Youngblood",
    HiringCost = 95,
    DailyCost = 10,
});

::Legends.Backgrounds.addBackgroundDefObjects(backgroundDefs);
