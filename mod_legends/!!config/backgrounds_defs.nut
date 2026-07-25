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

::Legends.Backgrounds.getStats <- function (_def, _isFemale = false) {
    if (_isFemale) { 
        return ::Legends.BackgroundDefObjects[_def].Stats.top();
    }
    else {
        return ::Legends.BackgroundDefObjects[_def].Stats[0];
    }
}
local backgroundDefs = [];

::Legends.Background.AdventurousNoble <- null;
backgroundDefs.push({
	ID = "background.adventurous_noble",
	Script = "scripts/skills/backgrounds/adventurous_noble_background",
	Const = "AdventurousNoble",
	Name = "Adventurous Noble",
	Stats = ::Legends.BackgroundsStats.AdventurousNoble
});

::Legends.Background.Anatomist <- null;
backgroundDefs.push({
    ID = "background.anatomist",
    Script = "scripts/skills/backgrounds/anatomist_background",
    Const = "Anatomist",
    Name = "Anatomist",
	Stats = ::Legends.BackgroundsStats.Anatomist
});

::Legends.Background.Apprentice <- null;
backgroundDefs.push({
    ID = "background.apprentice",
    Script = "scripts/skills/backgrounds/apprentice_background",
    Const = "Apprentice",
    Name = "Apprentice",
	Stats = ::Legends.BackgroundsStats.Apprentice
});

::Legends.Background.Assassin <- null;
backgroundDefs.push({
    ID = "background.assassin",
    Script = "scripts/skills/backgrounds/assassin_background",
    Const = "Assassin",
    Name = "Assassin",
	Stats = ::Legends.BackgroundsStats.Assassin
});

::Legends.Background.AssassinSouthern <- null;
backgroundDefs.push({
    ID = "background.assassin_southern",
    Script = "scripts/skills/backgrounds/assassin_southern_background",
    Const = "AssassinSouthern",
    Name = "Southern Assassin",
	Stats = ::Legends.BackgroundsStats.AssassinSouthern
});

::Legends.Background.Barbarian <- null;
backgroundDefs.push({
    ID = "background.barbarian",
    Script = "scripts/skills/backgrounds/barbarian_background",
    Const = "Barbarian",
    Name = "Barbarian",
	Stats = ::Legends.BackgroundsStats.Barbarian
});

::Legends.Background.Bastard <- null;
backgroundDefs.push({
    ID = "background.bastard",
    Script = "scripts/skills/backgrounds/bastard_background",
    Const = "Bastard",
    Name = "Bastard",
	Stats = ::Legends.BackgroundsStats.Bastard
});

::Legends.Background.BeastSlayer <- null;
backgroundDefs.push({
    ID = "background.beast_slayer",
    Script = "scripts/skills/backgrounds/beast_hunter_background",
    Const = "BeastSlayer",
    Name = "Beast Slayer",
	Stats = ::Legends.BackgroundsStats.BeastSlayer
});

::Legends.Background.Beggar <- null;
backgroundDefs.push({
    ID = "background.beggar",
    Script = "scripts/skills/backgrounds/beggar_background",
    Const = "Beggar",
    Name = "Beggar",
	Stats = ::Legends.BackgroundsStats.Beggar
});

::Legends.Background.BeggarSouthern <- null;
backgroundDefs.push({
    ID = "background.beggar",
    Script = "scripts/skills/backgrounds/beggar_southern_background",
    Const = "BeggarSouthern",
    Name = "Beggar",
	Stats = ::Legends.BackgroundsStats.Beggar
});

::Legends.Background.BellyDancer <- null;
backgroundDefs.push({
    ID = "background.belly_dancer",
    Script = "scripts/skills/backgrounds/belly_dancer_background",
    Const = "BellyDancer",
    Name = "Belly Dancer",
	Stats = ::Legends.BackgroundsStats.BellyDancer
});

::Legends.Background.Bowyer <- null;
backgroundDefs.push({
    ID = "background.bowyer",
    Script = "scripts/skills/backgrounds/bowyer_background",
    Const = "Bowyer",
    Name = "Bowyer",
	Stats = ::Legends.BackgroundsStats.Bowyer
});

::Legends.Background.Brawler <- null;
backgroundDefs.push({
    ID = "background.brawler",
    Script = "scripts/skills/backgrounds/brawler_background",
    Const = "Brawler",
    Name = "Brawler",
	Stats = ::Legends.BackgroundsStats.Brawler
});

::Legends.Background.Butcher <- null;
backgroundDefs.push({
    ID = "background.butcher",
    Script = "scripts/skills/backgrounds/butcher_background",
    Const = "Butcher",
    Name = "Butcher",
	Stats = ::Legends.BackgroundsStats.Butcher
});

::Legends.Background.CaravanHand <- null;
backgroundDefs.push({
    ID = "background.caravan_hand",
    Script = "scripts/skills/backgrounds/caravan_hand_background",
    Const = "CaravanHand",
    Name = "Caravan Hand",
	Stats = ::Legends.BackgroundsStats.CaravanHand
});

::Legends.Background.CaravanHandSouthern <- null;
backgroundDefs.push({
    ID = "background.caravan_hand",
    Script = "scripts/skills/backgrounds/caravan_hand_southern_background",
    Const = "CaravanHandSouthern",
    Name = "Caravan Hand",
	Stats = ::Legends.BackgroundsStats.CaravanHand
});

::Legends.Background.Companion <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_1h_background",
    Const = "Companion",
    Name = "Companion",
	Stats = ::Legends.BackgroundsStats.Companion
});

::Legends.Background.Companion2h <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_2h_background",
    Const = "Companion2h",
    Name = "Companion",
	Stats = ::Legends.BackgroundsStats.Companion2h
});

::Legends.Background.CompanionRanged <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_ranged_background",
    Const = "CompanionRanged",
    Name = "Companion",
	Stats = ::Legends.BackgroundsStats.CompanionRanged
});

::Legends.Background.CompanionSouthern <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_1h_southern_background",
    Const = "CompanionSouthern",
    Name = "Companion",
	Stats = ::Legends.BackgroundsStats.Companion
});

::Legends.Background.CompanionSouthern2h <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_2h_southern_background",
    Const = "Companion2hSouthern",
    Name = "Companion",
	Stats = ::Legends.BackgroundsStats.Companion2h
});

::Legends.Background.CompanionSouthernRanged <- null;
backgroundDefs.push({
    ID = "background.companion",
    Script = "scripts/skills/backgrounds/companion_ranged_southern_background",
    Const = "CompanionRangedSouthern",
    Name = "Companion",
	Stats = ::Legends.BackgroundsStats.CompanionRanged
});

::Legends.Background.ConvertedCultist <- null;
backgroundDefs.push({
    ID = "background.converted_cultist",
    Script = "scripts/skills/backgrounds/converted_cultist_background",
    Const = "ConvertedCultist",
    Name = "Converted Cultist",
	Stats = ::Legends.BackgroundsStats.Cultist
});

::Legends.Background.Cripple <- null;
backgroundDefs.push({
    ID = "background.cripple",
    Script = "scripts/skills/backgrounds/cripple_background",
    Const = "Cripple",
    Name = "Cripple",
	Stats = ::Legends.BackgroundsStats.Cripple
});

::Legends.Background.CrippleSouthern <- null;
backgroundDefs.push({
    ID = "background.cripple",
    Script = "scripts/skills/backgrounds/cripple_southern_background",
    Const = "CrippleSouthern",
    Name = "Cripple",
	Stats = ::Legends.BackgroundsStats.Cripple
});

::Legends.Background.Crucified <- null;
backgroundDefs.push({
    ID = "background.crucified",
    Script = "scripts/skills/backgrounds/crucified_background",
    Const = "Crucified",
    Name = "Crucified",
	Stats = ::Legends.BackgroundsStats.Crucified
});

::Legends.Background.Crusader <- null;
backgroundDefs.push({
    ID = "background.crusader",
    Script = "scripts/skills/backgrounds/crusader_background",
    Const = "Crusader",
    Name = "Crusader",
	Stats = ::Legends.BackgroundsStats.Crusader
});

::Legends.Background.Cultist <- null;
backgroundDefs.push({
    ID = "background.cultist",
    Script = "scripts/skills/backgrounds/cultist_background",
    Const = "Cultist",
    Name = "Cultist",
	Stats = ::Legends.BackgroundsStats.Cultist
});

::Legends.Background.Daytaler <- null;
backgroundDefs.push({
    ID = "background.daytaler",
    Script = "scripts/skills/backgrounds/daytaler_background",
    Const = "Daytaler",
    Name = "Daytaler",
	Stats = ::Legends.BackgroundsStats.Daytaler
});

::Legends.Background.DaytalerSouthern <- null;
backgroundDefs.push({
    ID = "background.daytaler",
    Script = "scripts/skills/backgrounds/daytaler_southern_background",
    Const = "DaytalerSouthern",
    Name = "Daytaler",
	Stats = ::Legends.BackgroundsStats.Daytaler
});

::Legends.Background.Deserter <- null;
backgroundDefs.push({
    ID = "background.deserter",
    Script = "scripts/skills/backgrounds/deserter_background",
    Const = "Deserter",
    Name = "Deserter",
	Stats = ::Legends.BackgroundsStats.Deserter
});

::Legends.Background.DisownedNoble <- null;
backgroundDefs.push({
    ID = "background.disowned_noble",
    Script = "scripts/skills/backgrounds/disowned_noble_background",
    Const = "DisownedNoble",
    Name = "Disowned Noble",
	Stats = ::Legends.BackgroundsStats.DisownedNoble
});

::Legends.Background.Eunuch <- null;
backgroundDefs.push({
    ID = "background.eunuch",
    Script = "scripts/skills/backgrounds/eunuch_background",
    Const = "Eunuch",
    Name = "Eunuch",
	Stats = ::Legends.BackgroundsStats.Eunuch
});

::Legends.Background.EunuchSouthern <- null;
backgroundDefs.push({
    ID = "background.eunuch",
    Script = "scripts/skills/backgrounds/eunuch_southern_background",
    Const = "EunuchSouthern",
    Name = "Eunuch",
	Stats = ::Legends.BackgroundsStats.Eunuch
});

::Legends.Background.Executioner <- null;
backgroundDefs.push({
    ID = "background.executioner",
    Script = "scripts/skills/backgrounds/executioner_background",
    Const = "Executioner",
    Name = "Executioner",
	Stats = ::Legends.BackgroundsStats.Executioner
});

::Legends.Background.ExecutionerSouthern <- null;
backgroundDefs.push({
    ID = "background.executioner",
    Script = "scripts/skills/backgrounds/executioner_southern_background",
    Const = "ExecutionerSouthern",
    Name = "Executioner",
	Stats = ::Legends.BackgroundsStats.Executioner
});

::Legends.Background.Farmhand <- null;
backgroundDefs.push({
    ID = "background.farmhand",
    Script = "scripts/skills/backgrounds/farmhand_background",
    Const = "Farmhand",
    Name = "Farmhand",
	Stats = ::Legends.BackgroundsStats.Farmhand
});

::Legends.Background.Fisherman <- null;
backgroundDefs.push({
    ID = "background.fisherman",
    Script = "scripts/skills/backgrounds/fisherman_background",
    Const = "Fisherman",
    Name = "Fisherman",
	Stats = ::Legends.BackgroundsStats.Fisherman
});

::Legends.Background.FishermanSouthern <- null;
backgroundDefs.push({
    ID = "background.fisherman",
    Script = "scripts/skills/backgrounds/fisherman_southern_background",
    Const = "FishermanSouthern",
    Name = "Fisherman",
	Stats = ::Legends.BackgroundsStats.Fisherman
});

::Legends.Background.Flagellant <- null;
backgroundDefs.push({
    ID = "background.flagellant",
    Script = "scripts/skills/backgrounds/flagellant_background",
    Const = "Flagellant",
    Name = "Flagellant",
	Stats = ::Legends.BackgroundsStats.Flagellant
});

::Legends.Background.Gambler <- null;
backgroundDefs.push({
    ID = "background.gambler",
    Script = "scripts/skills/backgrounds/gambler_background",
    Const = "Gambler",
    Name = "Gambler",
	Stats = ::Legends.BackgroundsStats.Gambler
});

::Legends.Background.Gladiator <- null;
backgroundDefs.push({
    ID = "background.gladiator",
    Script = "scripts/skills/backgrounds/gladiator_background",
    Const = "Gladiator",
    Name = "Gladiator",
	Stats = ::Legends.BackgroundsStats.Gladiator
});

::Legends.Background.GladiatorOrigin <- null;
backgroundDefs.push({
    ID = "background.gladiator",
    Script = "scripts/skills/backgrounds/gladiator_origin_background",
    Const = "GladiatorOrigin",
    Name = "Gladiator",
	Stats = ::Legends.BackgroundsStats.Gladiator
});

::Legends.Background.Gravedigger <- null;
backgroundDefs.push({
    ID = "background.gravedigger",
    Script = "scripts/skills/backgrounds/gravedigger_background",
    Const = "Gravedigger",
    Name = "Gravedigger",
	Stats = ::Legends.BackgroundsStats.Gravedigger
});

::Legends.Background.Graverobber <- null;
backgroundDefs.push({
    ID = "background.graverobber",
    Script = "scripts/skills/backgrounds/graverobber_background",
    Const = "Graverobber",
    Name = "Graverobber",
	Stats = ::Legends.BackgroundsStats.Graverobber
});

::Legends.Background.HedgeKnight <- null;
backgroundDefs.push({
    ID = "background.hedge_knight",
    Script = "scripts/skills/backgrounds/hedge_knight_background",
    Const = "HedgeKnight",
    Name = "Hedge Knight",
	Stats = ::Legends.BackgroundsStats.HedgeKnight
});

::Legends.Background.Historian <- null;
backgroundDefs.push({
    ID = "background.historian",
    Script = "scripts/skills/backgrounds/historian_background",
    Const = "Historian",
    Name = "Historian",
	Stats = ::Legends.BackgroundsStats.Historian
});

::Legends.Background.Houndmaster <- null;
backgroundDefs.push({
    ID = "background.houndmaster",
    Script = "scripts/skills/backgrounds/houndmaster_background",
    Const = "Houndmaster",
    Name = "Houndmaster",
	Stats = ::Legends.BackgroundsStats.Houndmaster
});

::Legends.Background.Hunter <- null;
backgroundDefs.push({
    ID = "background.hunter",
    Script = "scripts/skills/backgrounds/hunter_background",
    Const = "Hunter",
    Name = "Hunter",
	Stats = ::Legends.BackgroundsStats.Hunter
});

::Legends.Background.Juggler <- null;
backgroundDefs.push({
    ID = "background.juggler",
    Script = "scripts/skills/backgrounds/juggler_background",
    Const = "Juggler",
    Name = "Juggler",
	Stats = ::Legends.BackgroundsStats.Juggler
});

::Legends.Background.JugglerSouthern <- null;
backgroundDefs.push({
    ID = "background.juggler",
    Script = "scripts/skills/backgrounds/juggler_southern_background",
    Const = "JugglerSouthern",
    Name = "Juggler",
	Stats = ::Legends.BackgroundsStats.JugglerSouthern
});

::Legends.Background.KillerOnTheRun <- null;
backgroundDefs.push({
    ID = "background.killer_on_the_run",
    Script = "scripts/skills/backgrounds/killer_on_the_run_background",
    Const = "KillerOnTheRun",
    Name = "Killer On The Run",
	Stats = ::Legends.BackgroundsStats.KillerOnTheRun
});

::Legends.Background.KingsGuard <- null;
backgroundDefs.push({
    ID = "background.kings_guard",
    Script = "scripts/skills/backgrounds/kings_guard_background",
    Const = "KingsGuard",
    Name = "Kings Guard",
	Stats = ::Legends.BackgroundsStats.Cripple
});

::Legends.Background.LindwurmSlayer <- null;
backgroundDefs.push({
    ID = "background.lindwurm_slayer",
    Script = "scripts/skills/backgrounds/lindwurm_slayer_background",
    Const = "LindwurmSlayer",
    Name = "Lindwurm Slayer",
	Stats = ::Legends.BackgroundsStats.LindwurmSlayer
});

::Legends.Background.Lumberjack <- null;
backgroundDefs.push({
    ID = "background.lumberjack",
    Script = "scripts/skills/backgrounds/lumberjack_background",
    Const = "Lumberjack",
    Name = "Lumberjack",
	Stats = ::Legends.BackgroundsStats.Lumberjack
});

::Legends.Background.Manhunter <- null;
backgroundDefs.push({
    ID = "background.manhunter",
    Script = "scripts/skills/backgrounds/manhunter_background",
    Const = "Manhunter",
    Name = "Manhunter",
	Stats = ::Legends.BackgroundsStats.Manhunter
});

::Legends.Background.Mason <- null;
backgroundDefs.push({
    ID = "background.mason",
    Script = "scripts/skills/backgrounds/mason_background",
    Const = "Mason",
    Name = "Mason",
	Stats = ::Legends.BackgroundsStats.Mason
});

::Legends.Background.Messenger <- null;
backgroundDefs.push({
    ID = "background.messenger",
    Script = "scripts/skills/backgrounds/messenger_background",
    Const = "Messenger",
    Name = "Messenger",
	Stats = ::Legends.BackgroundsStats.Messenger
});

::Legends.Background.Militia <- null;
backgroundDefs.push({
    ID = "background.militia",
    Script = "scripts/skills/backgrounds/militia_background",
    Const = "Militia",
    Name = "Militia",
	Stats = ::Legends.BackgroundsStats.Militia
});

::Legends.Background.Miner <- null;
backgroundDefs.push({
    ID = "background.miner",
    Script = "scripts/skills/backgrounds/miner_background",
    Const = "Miner",
    Name = "Miner",
	Stats = ::Legends.BackgroundsStats.Miner
});

::Legends.Background.Miller <- null;
backgroundDefs.push({
    ID = "background.miller",
    Script = "scripts/skills/backgrounds/miller_background",
    Const = "Miller",
    Name = "Miller",
	Stats = ::Legends.BackgroundsStats.Miller
});

::Legends.Background.Minstrel <- null;
backgroundDefs.push({
    ID = "background.minstrel",
    Script = "scripts/skills/backgrounds/minstrel_background",
    Const = "Minstrel",
    Name = "Minstrel",
	Stats = ::Legends.BackgroundsStats.Minstrel
});

::Legends.Background.Monk <- null;
backgroundDefs.push({
    ID = "background.monk",
    Script = "scripts/skills/backgrounds/monk_background",
    Const = "Monk",
    Name = "Monk",
	Stats = ::Legends.BackgroundsStats.Monk
});

::Legends.Background.MonkTurnedFlagellant <- null;
backgroundDefs.push({
    ID = "background.monk_turned_flagellant",
    Script = "scripts/skills/backgrounds/monk_turned_flagellant_background",
    Const = "MonkTurnedFlagellant",
    Name = "Monk Turned Flagellant",
	Stats = ::Legends.BackgroundsStats.Monk
});

::Legends.Background.Nomad <- null;
backgroundDefs.push({
    ID = "background.nomad",
    Script = "scripts/skills/backgrounds/nomad_background",
    Const = "Nomad",
    Name = "Nomad",
	Stats = ::Legends.BackgroundsStats.Nomad
});

::Legends.Background.NomadRanged <- null;
backgroundDefs.push({
    ID = "background.nomad",
    Script = "scripts/skills/backgrounds/nomad_ranged_background",
    Const = "NomadRanged",
    Name = "Nomad",
	Stats = ::Legends.BackgroundsStats.NomadRanged
});

::Legends.Background.OrcSlayer <- null;
backgroundDefs.push({
    ID = "background.orc_slayer",
    Script = "scripts/skills/backgrounds/orc_slayer_background",
    Const = "OrcSlayer",
    Name = "Orc Slayer",
	Stats = ::Legends.BackgroundsStats.OrcSlayer
});

::Legends.Background.PacifiedFlagellant <- null;
backgroundDefs.push({
    ID = "background.pacified_flagellant",
    Script = "scripts/skills/backgrounds/pacified_flagellant_background",
    Const = "PacifiedFlagellant",
    Name = "Pacified Flagellant",
	Stats = ::Legends.BackgroundsStats.Flagellant
});

::Legends.Background.Paladin <- null;
backgroundDefs.push({
    ID = "background.paladin",
    Script = "scripts/skills/backgrounds/paladin_background",
    Const = "Paladin",
    Name = "Paladin",
	Stats = ::Legends.BackgroundsStats.Paladin
});

::Legends.Background.PaladinOld <- null;
backgroundDefs.push({
    ID = "background.paladin",
    Script = "scripts/skills/backgrounds/old_paladin_background",
    Const = "PaladinOld",
    Name = "Paladin",
	Stats = ::Legends.BackgroundsStats.Paladin
});

::Legends.Background.Peddler <- null;
backgroundDefs.push({
    ID = "background.peddler",
    Script = "scripts/skills/backgrounds/peddler_background",
    Const = "Peddler",
    Name = "Peddler",
	Stats = ::Legends.BackgroundsStats.Peddler
});

::Legends.Background.PeddlerSouthern <- null;
backgroundDefs.push({
    ID = "background.peddler",
    Script = "scripts/skills/backgrounds/peddler_southern_background",
    Const = "PeddlerSouthern",
    Name = "Peddler",
	Stats = ::Legends.BackgroundsStats.Peddler
});

::Legends.Background.Pimp <- null;
backgroundDefs.push({
    ID = "background.pimp",
    Script = "scripts/skills/backgrounds/pimp_background",
    Const = "Pimp",
    Name = "Pimp",
	Stats = ::Legends.BackgroundsStats.Pimp
});

::Legends.Background.Poacher <- null;
backgroundDefs.push({
    ID = "background.poacher",
    Script = "scripts/skills/backgrounds/poacher_background",
    Const = "Poacher",
    Name = "Poacher",
	Stats = ::Legends.BackgroundsStats.Poacher
});

::Legends.Background.Raider <- null;
backgroundDefs.push({
    ID = "background.raider",
    Script = "scripts/skills/backgrounds/raider_background",
    Const = "Raider",
    Name = "Raider",
	Stats = ::Legends.BackgroundsStats.Raider
});

::Legends.Background.Ratcatcher <- null;
backgroundDefs.push({
    ID = "background.ratcatcher",
    Script = "scripts/skills/backgrounds/ratcatcher_background",
    Const = "Ratcatcher",
    Name = "Ratcatcher",
	Stats = ::Legends.BackgroundsStats.Ratcatcher
});

::Legends.Background.Refugee <- null;
backgroundDefs.push({
    ID = "background.refugee",
    Script = "scripts/skills/backgrounds/refugee_background",
    Const = "Refugee",
    Name = "Refugee",
	Stats = ::Legends.BackgroundsStats.Refugee
});

::Legends.Background.RegentInAbsentia <- null;
backgroundDefs.push({
    ID = "background.regent_in_absentia",
    Script = "scripts/skills/backgrounds/regent_in_absentia_background",
    Const = "RegentInAbsentia",
    Name = "Regent In Absentia",
	Stats = ::Legends.BackgroundsStats.RegentInAbsentia
});

::Legends.Background.RetiredSoldier <- null;
backgroundDefs.push({
    ID = "background.retired_soldier",
    Script = "scripts/skills/backgrounds/retired_soldier_background",
    Const = "RetiredSoldier",
    Name = "Retired Soldier",
	Stats = ::Legends.BackgroundsStats.RetiredSoldier
});

::Legends.Background.Sellsword <- null;
backgroundDefs.push({
    ID = "background.sellsword",
    Script = "scripts/skills/backgrounds/sellsword_background",
    Const = "Sellsword",
    Name = "Sellsword",
	Stats = ::Legends.BackgroundsStats.Sellsword
});

::Legends.Background.Servant <- null;
backgroundDefs.push({
    ID = "background.servant",
    Script = "scripts/skills/backgrounds/servant_background",
    Const = "Servant",
    Name = "Servant",
	Stats = ::Legends.BackgroundsStats.Servant
});

::Legends.Background.Shepherd <- null;
backgroundDefs.push({
    ID = "background.shepherd",
    Script = "scripts/skills/backgrounds/shepherd_background",
    Const = "Shepherd",
    Name = "Shepherd",
	Stats = ::Legends.BackgroundsStats.Shepherd
});

::Legends.Background.ShepherdSouthern <- null;
backgroundDefs.push({
    ID = "background.shepherd",
    Script = "scripts/skills/backgrounds/shepherd_southern_background",
    Const = "ShepherdSouthern",
    Name = "Shepherd",
	Stats = ::Legends.BackgroundsStats.Shepherd
});

::Legends.Background.Slave <- null;
backgroundDefs.push({
    ID = "background.slave",
    Script = "scripts/skills/backgrounds/slave_background",
    Const = "Slave",
    Name = "Slave",
	Stats = ::Legends.BackgroundsStats.Slave
});

::Legends.Background.SlaveBarbarian <- null;
backgroundDefs.push({
    ID = "background.slave",
    Script = "scripts/skills/backgrounds/slave_barbarian_background",
    Const = "Slave",
    Name = "Slave",
	Stats = ::Legends.BackgroundsStats.SlaveBarbarian
});

::Legends.Background.SlaveSouthern <- null;
backgroundDefs.push({
    ID = "background.slave",
    Script = "scripts/skills/backgrounds/slave_southern_background",
    Const = "SlaveSouthern",
    Name = "Slave",
	Stats = ::Legends.BackgroundsStats.SlaveSouthern
});

::Legends.Background.Squire <- null;
backgroundDefs.push({
    ID = "background.squire",
    Script = "scripts/skills/backgrounds/squire_background",
    Const = "Squire",
    Name = "Squire",
	Stats = ::Legends.BackgroundsStats.Squire
});

::Legends.Background.Swordmaster <- null;
backgroundDefs.push({
    ID = "background.swordmaster",
    Script = "scripts/skills/backgrounds/swordmaster_background",
    Const = "Swordmaster",
    Name = "Swordmaster",
	Stats = ::Legends.BackgroundsStats.Swordmaster
});

::Legends.Background.Tailor <- null;
backgroundDefs.push({
    ID = "background.tailor",
    Script = "scripts/skills/backgrounds/tailor_background",
    Const = "Tailor",
    Name = "Tailor",
	Stats = ::Legends.BackgroundsStats.Tailor
});

::Legends.Background.Thief <- null;
backgroundDefs.push({
    ID = "background.thief",
    Script = "scripts/skills/backgrounds/thief_background",
    Const = "Thief",
    Name = "Thief",
	Stats = ::Legends.BackgroundsStats.Thief
});

::Legends.Background.Vagabond <- null;
backgroundDefs.push({
    ID = "background.vagabond",
    Script = "scripts/skills/backgrounds/vagabond_background",
    Const = "Vagabond",
    Name = "Vagabond",
	Stats = ::Legends.BackgroundsStats.Vagabond
});

::Legends.Background.Wildman <- null;
backgroundDefs.push({
    ID = "background.wildman",
    Script = "scripts/skills/backgrounds/wildman_background",
    Const = "Wildman",
    Name = "Wildman",
	Stats = ::Legends.BackgroundsStats.Wildman
});

::Legends.Background.Witchhunter <- null;
backgroundDefs.push({
    ID = "background.witchhunter",
    Script = "scripts/skills/backgrounds/witchhunter_background",
    Const = "Witchhunter",
    Name = "Witchhunter",
	Stats = ::Legends.BackgroundsStats.Witchhunter
});

::Legends.Background.LegendAlchemist <- null;
backgroundDefs.push({
    ID = "background.legend_alchemist",
    Script = "scripts/skills/backgrounds/legend_alchemist_background",
    Const = "LegendAlchemist",
    Name = "Alchemist",
	Stats = ::Legends.BackgroundsStats.LegendAlchemist
});

::Legends.Background.LegendAncientSummoner <- null;
backgroundDefs.push({
    ID = "background.legend_ancient_summoner",
    Script = "scripts/skills/backgrounds/legend_ancient_summoner_background",
    Const = "LegendAncientSummoner",
    Name = "Ancient Summoner",
	Stats = ::Legends.BackgroundsStats.LegendAncientSummoner
});

::Legends.Background.LegendAstrologist <- null;
backgroundDefs.push({
    ID = "background.legend_astrologist",
    Script = "scripts/skills/backgrounds/legend_astrologist_background",
    Const = "LegendAstrologist",
    Name = "Astrologist",
	Stats = ::Legends.BackgroundsStats.LegendAstrologist
});

::Legends.Background.LegendBattleSister <- null;
backgroundDefs.push({
    ID = "background.legend_battle_sister",
    Script = "scripts/skills/backgrounds/legend_battle_sister_background",
    Const = "LegendBattleSister",
    Name = "Battle Sister",
	Stats = ::Legends.BackgroundsStats.LegendBattleSister
});

::Legends.Background.LegendBerserker <- null;
backgroundDefs.push({
    ID = "background.legend_berserker",
    Script = "scripts/skills/backgrounds/legend_berserker_background",
    Const = "LegendBerserker",
    Name = "Berserker",
	Stats = ::Legends.BackgroundsStats.LegendBerserker
});

::Legends.Background.LegendBlacksmith <- null;
backgroundDefs.push({
    ID = "background.legend_blacksmith",
    Script = "scripts/skills/backgrounds/legend_blacksmith_background",
    Const = "LegendBlacksmith",
    Name = "Blacksmith",
	Stats = ::Legends.BackgroundsStats.LegendBlacksmith
});

::Legends.Background.LegendBladedancer <- null;
backgroundDefs.push({
    ID = "background.legend_bladedancer",
    Script = "scripts/skills/backgrounds/legend_bladedancer_background",
    Const = "LegendBladedancer",
    Name = "Bladedancer",
	Stats = ::Legends.BackgroundsStats.LegendBladedancer
});

::Legends.Background.LegendBountyHunter <- null;
backgroundDefs.push({
    ID = "background.legend_bounty_hunter",
    Script = "scripts/skills/backgrounds/legend_bounty_hunter_background",
    Const = "LegendBountyHunter",
    Name = "Bounty Hunter",
	Stats = ::Legends.BackgroundsStats.LegendBountyHunter
});

::Legends.Background.LegendCannibal <- null;
backgroundDefs.push({
    ID = "background.legend_cannibal",
    Script = "scripts/skills/backgrounds/legend_cannibal_background",
    Const = "LegendCannibal",
    Name = "Cannibal",
	Stats = ::Legends.BackgroundsStats.LegendCannibal
});

::Legends.Background.LegendCommanderAssassin <- null;
backgroundDefs.push({
    ID = "background.legend_commander_assassin",
    Script = "scripts/skills/backgrounds/legend_assassin_commander_background",
    Const = "LegendCommanderAssassin",
    Name = "Assassin Commander",
	Stats = ::Legends.BackgroundsStats.LegendCommanderAssassin
});

::Legends.Background.LegendCommanderBeggar <- null;
backgroundDefs.push({
    ID = "background.legend_commander_beggar",
    Script = "scripts/skills/backgrounds/legend_beggar_commander_background",
    Const = "LegendCommanderBeggar",
    Name = "Beggar Commander",
	Stats = ::Legends.BackgroundsStats.LegendCommanderBeggar
});

::Legends.Background.LegendCommanderBeggarScaling <- null;
backgroundDefs.push({
    ID = "background.legend_beggar_commander_op",
    Script = "scripts/skills/backgrounds/legend_beggar_commander_op_background",
    Const = "LegendCommanderBeggarScaling",
    Name = "Beggar Commander",
	Stats = ::Legends.BackgroundsStats.Beggar
});

::Legends.Background.LegendCommanderBerserker <- null;
backgroundDefs.push({
    ID = "background.legend_commander_berserker",
    Script = "scripts/skills/backgrounds/legend_berserker_commander_background",
    Const = "LegendCommanderBerserker",
    Name = "Berserker Commander",
    Stats = ::Legends.BackgroundsStats.LegendCommanderBerserker
});

::Legends.Background.LegendCommanderDruid <- null;
backgroundDefs.push({
    ID = "background.legend_commander_druid",
    Script = "scripts/skills/backgrounds/legend_druid_commander_background",
    Const = "LegendCommanderDruid",
    Name = "Druid Commander",
    Stats = ::Legends.BackgroundsStats.LegendDruid
});

::Legends.Background.LegendCommanderNecro <- null;
backgroundDefs.push({
    ID = "background.legend_commander_necro",
    Script = "scripts/skills/backgrounds/legend_necro_commander_background",
    Const = "LegendCommanderNecro",
    Name = "Master Necromancer",
    Stats = ::Legends.BackgroundsStats.LegendCommanderNecro
});

::Legends.Background.LegendCommanderNoble <- null;
backgroundDefs.push({
    ID = "background.legend_commander_noble",
    Script = "scripts/skills/backgrounds/legend_noble_commander_background",
    Const = "LegendCommanderNoble",
    Name = "Noble Commander",
    Stats = ::Legends.BackgroundsStats.LegendCommanderNoble
});

::Legends.Background.LegendCommanderPeddler <- null;
backgroundDefs.push({
    ID = "background.legend_commander_peddler",
    Script = "scripts/skills/backgrounds/legend_peddler_commander_background",
    Const = "LegendCommanderPeddler",
    Name = "Peddler Commander",
    Stats = ::Legends.BackgroundsStats.LegendCommanderPeddler
});

::Legends.Background.LegendCommanderRanger <- null;
backgroundDefs.push({
    ID = "background.legend_commander_ranger",
    Script = "scripts/skills/backgrounds/legend_ranger_commander_background",
    Const = "LegendCommanderRanger",
    Name = "Ranger Commander",
    Stats = ::Legends.BackgroundsStats.LegendCommanderRanger
});

::Legends.Background.LegendCommanderTrader <- null;
backgroundDefs.push({
    ID = "background.legend_commander_trader",
    Script = "scripts/skills/backgrounds/legend_trader_commander_background",
    Const = "LegendCommanderTrader",
    Name = "Trader Commander",
    Stats = ::Legends.BackgroundsStats.LegendCommanderTrader
});

::Legends.Background.LegendCommanderWitch <- null;
backgroundDefs.push({
    ID = "background.legend_commander_witch",
    Script = "scripts/skills/backgrounds/legend_witch_commander_background",
    Const = "LegendCommanderWitch",
    Name = "Witch Commander",
    Stats = ::Legends.BackgroundsStats.LegendCommanderWitch
});

::Legends.Background.LegendCompanionMelee <- null;
backgroundDefs.push({
    ID = "background.legend_companion_melee",
    Script = "scripts/skills/backgrounds/legend_companion_melee_background",
    Const = "LegendCompanionMelee",
    Name = "Companion"
});

::Legends.Background.LegendCompanionRanged <- null;
backgroundDefs.push({
    ID = "background.legend_companion_ranged",
    Script = "scripts/skills/backgrounds/legend_companion_ranged_background",
    Const = "LegendCompanionRanged",
    Name = "Companion",
    Stats = ::Legends.BackgroundsStats.LegendCompanionRanged
});

::Legends.Background.LegendConjurer <- null;
backgroundDefs.push({
    ID = "background.legend_conjurer",
    Script = "scripts/skills/backgrounds/legend_conjurer_background",
    Const = "LegendConjurer",
    Name = "Conjurer",
    Stats = ::Legends.BackgroundsStats.LegendConjurer
});

::Legends.Background.LegendConscript <- null;
backgroundDefs.push({
    ID = "background.legend_conscript",
    Script = "scripts/skills/backgrounds/legend_conscript_background",
    Const = "LegendConscript",
    Name = "Conscript",
    Stats = ::Legends.BackgroundsStats.LegendConscript
});

::Legends.Background.LegendConscriptRanged <- null;
backgroundDefs.push({
    ID = "background.legend_conscript",
    Script = "scripts/skills/backgrounds/legend_conscript_ranged_background",
    Const = "LegendConscriptRanged",
    Name = "Conscript Ranged",
    Stats = ::Legends.BackgroundsStats.LegendConscriptRanged
});

::Legends.Background.LegendCrusader <- null;
backgroundDefs.push({
    ID = "background.legend_crusader",
    Script = "scripts/skills/backgrounds/legend_crusader_background",
    Const = "LegendCrusader",
    Name = "Crusader",
    Stats = ::Legends.BackgroundsStats.LegendCrusader
});

::Legends.Background.LegendDeathSummoner <- null;
backgroundDefs.push({
    ID = "background.legend_death_summoner",
    Script = "scripts/skills/backgrounds/legend_death_summoner_background",
    Const = "LegendDeathSummoner",
    Name = "Death Summoner",
    Stats = ::Legends.BackgroundsStats.LegendDeathSummoner
});

::Legends.Background.LegendDervish <- null;
backgroundDefs.push({
    ID = "background.legend_dervish",
    Script = "scripts/skills/backgrounds/legend_dervish_background",
    Const = "LegendDervish",
    Name = "Dervish",
    Stats = ::Legends.BackgroundsStats.LegendDervish
});

::Legends.Background.LegendDiviner <- null;
backgroundDefs.push({
    ID = "background.legend_diviner",
    Script = "scripts/skills/backgrounds/legend_diviner_background",
    Const = "LegendDiviner",
    Name = "Diviner",
    Stats = ::Legends.BackgroundsStats.LegendDiviner
});

::Legends.Background.LegendDonkey <- null;
backgroundDefs.push({
    ID = "background.legend_donkey",
    Script = "scripts/skills/backgrounds/legend_donkey_background",
    Const = "LegendDonkey",
    Name = "Donkey",
    Stats = ::Legends.BackgroundsStats.LegendDonkey
});

::Legends.Background.LegendDruid <- null;
backgroundDefs.push({
    ID = "background.legend_druid",
    Script = "scripts/skills/backgrounds/legend_druid_background",
    Const = "LegendDruid",
    Name = "Druid",
    Stats = ::Legends.BackgroundsStats.LegendDruid
});

::Legends.Background.LegendEnchanter <- null;
backgroundDefs.push({
    ID = "background.legend_enchanter",
    Script = "scripts/skills/backgrounds/legend_enchanter_background",
    Const = "LegendEnchanter",
    Name = "Enchanter",
    Stats = ::Legends.BackgroundsStats.LegendEnchanter
});

::Legends.Background.LegendEntrancer <- null;
backgroundDefs.push({
    ID = "background.legend_entrancer",
    Script = "scripts/skills/backgrounds/legend_entrancer_background",
    Const = "LegendEntrancer",
    Name = "Entrancer",
    Stats = ::Legends.BackgroundsStats.LegendEntrancer
});

::Legends.Background.LegendGladiatorPrizefighter <- null;
backgroundDefs.push({
    ID = "background.gladiator",
    Script = "scripts/skills/backgrounds/legend_gladiator_prizefighter_background",
    Const = "LegendGladiatorPrizefighter",
    Name = "Gladiator Prizefighter",
    Stats = ::Legends.BackgroundsStats.LegendGladiatorPrizefighter
});

::Legends.Background.LegendGuildmaster <- null;
backgroundDefs.push({
    ID = "background.legend_guildmaster",
    Script = "scripts/skills/backgrounds/legend_guildmaster_background",
    Const = "LegendGuildmaster",
    Name = "Guildmaster",
    Stats = ::Legends.BackgroundsStats.LegendGuildmaster
});

::Legends.Background.LegendHealer <- null;
backgroundDefs.push({
    ID = "background.legend_healer",
    Script = "scripts/skills/backgrounds/legend_healer_background",
    Const = "LegendHealer",
    Name = "Healer",
    Stats = ::Legends.BackgroundsStats.LegendHealer
});

::Legends.Background.LegendHerbalist <- null;
backgroundDefs.push({
    ID = "background.legend_herbalist",
    Script = "scripts/skills/backgrounds/legend_herbalist_background",
    Const = "LegendHerbalist",
    Name = "Herbalist",
    Stats = ::Legends.BackgroundsStats.LegendHerbalist
});

::Legends.Background.LegendHorse <- null;
backgroundDefs.push({
    ID = "background.legend_horse",
    Script = "scripts/skills/backgrounds/legend_horse",
    Const = "LegendHorse",
    Name = "Horse",
    Stats = ::Legends.BackgroundsStats.LegendHorse
});

::Legends.Background.LegendHorserider <- null;
backgroundDefs.push({
    ID = "background.legend_horserider",
    Script = "scripts/skills/backgrounds/legend_horserider",
    Const = "LegendHorserider",
    Name = "Horserider",
    Stats = ::Legends.BackgroundsStats.LegendHorserider
});

::Legends.Background.LegendHorseCourser <- null;
backgroundDefs.push({
    ID = "background.legend_horse_courser",
    Script = "scripts/skills/backgrounds/legend_horse_courser",
    Const = "LegendHorseCourser",
    Name = "Horse Courser",
    Stats = ::Legends.BackgroundsStats.LegendHorseCourser
});

::Legends.Background.LegendHorseDestrier <- null;
backgroundDefs.push({
    ID = "background.legend_horse_destrier",
    Script = "scripts/skills/backgrounds/legend_horse_destrier",
    Const = "LegendHorseDestrier",
    Name = "Horse Destrier",
    Stats = ::Legends.BackgroundsStats.LegendHorseDestrier
});

::Legends.Background.LegendHorseRouncey <- null;
backgroundDefs.push({
    ID = "background.legend_horse_rouncey",
    Script = "scripts/skills/backgrounds/legend_horse_rouncey",
    Const = "LegendHorseRouncey",
    Name = "Horse Rouncey",
    Stats = ::Legends.BackgroundsStats.LegendHorseRouncey
});

::Legends.Background.LegendHusk <- null;
backgroundDefs.push({
    ID = "background.legend_husk",
    Script = "scripts/skills/backgrounds/legend_husk_background",
    Const = "LegendHusk",
    Name = "Husk",
    Stats = ::Legends.BackgroundsStats.LegendHusk
});

::Legends.Background.LegendIllusionist <- null;
backgroundDefs.push({
    ID = "background.legend_illusionist",
    Script = "scripts/skills/backgrounds/legend_illusionist_background",
    Const = "LegendIllusionist",
    Name = "Illusionist",
    Stats = ::Legends.BackgroundsStats.LegendIllusionist
});

::Legends.Background.LegendInventor <- null;
backgroundDefs.push({
    ID = "background.legend_inventor",
    Script = "scripts/skills/backgrounds/legend_inventor_background",
    Const = "LegendInventor",
    Name = "Inventor",
    Stats = ::Legends.BackgroundsStats.LegendInventor
});

::Legends.Background.LegendIronmonger <- null;
backgroundDefs.push({
    ID = "background.legend_ironmonger",
    Script = "scripts/skills/backgrounds/legend_ironmonger_background",
    Const = "LegendIronmonger",
    Name = "Ironmonger",
    Stats = ::Legends.BackgroundsStats.LegendIronmonger
});

::Legends.Background.LegendLeechPeddler <- null;
backgroundDefs.push({
    ID = "background.legend_leech_peddler",
    Script = "scripts/skills/backgrounds/legend_leech_peddler_background",
    Const = "LegendLeechPeddler",
    Name = "Leech Peddler",
    Stats = ::Legends.BackgroundsStats.LegendLeechPeddler
});

::Legends.Background.LegendLegionAuxiliary <- null;
backgroundDefs.push({
    ID = "background.legend_legion_auxiliary",
    Script = "scripts/skills/backgrounds/legend_legion_auxiliary_background",
    Const = "LegendLegionAuxiliary",
    Name = "Legion Auxiliary",
    Stats = ::Legends.BackgroundsStats.LegendLegionAuxiliary
});

::Legends.Background.LegendLegionCenturion <- null;
backgroundDefs.push({
    ID = "background.legend_legion_centurion",
    Script = "scripts/skills/backgrounds/legend_legion_centurion_background",
    Const = "LegendLegionCenturion",
    Name = "Legion Centurion",
    Stats = ::Legends.BackgroundsStats.LegendLegionCenturion
});

::Legends.Background.LegendLegionGladiator <- null;
backgroundDefs.push({
    ID = "background.legend_legion_gladiator",
    Script = "scripts/skills/backgrounds/legend_legion_gladiator_background",
    Const = "LegendLegionGladiator",
    Name = "Legion Gladiator",
    Stats = ::Legends.BackgroundsStats.LegendLegionGladiator
});

::Legends.Background.LegendLegionHonourGuard <- null;
backgroundDefs.push({
    ID = "background.legend_legion_honour_guard",
    Script = "scripts/skills/backgrounds/legend_legion_honour_guard_background",
    Const = "LegendLegionHonourGuard",
    Name = "Legion Honour Guard",
    Stats = ::Legends.BackgroundsStats.LegendLegionHonourGuard
});

::Legends.Background.LegendLegionLegate <- null;
backgroundDefs.push({
    ID = "background.legend_legion_legate",
    Script = "scripts/skills/backgrounds/legend_legion_legate_background",
    Const = "LegendLegionLegate",
    Name = "Legion Legate",
    Stats = ::Legends.BackgroundsStats.LegendLegionLegate
});

::Legends.Background.LegendLegionLegionary <- null;
backgroundDefs.push({
    ID = "background.legend_legion_legionary",
    Script = "scripts/skills/backgrounds/legend_legion_legionary_background",
    Const = "LegendLegionLegionary",
    Name = "Legion Legionary",
    Stats = ::Legends.BackgroundsStats.LegendLegionLegionary
});

::Legends.Background.LegendLegionPrefect <- null;
backgroundDefs.push({
    ID = "background.legend_legion_prefect",
    Script = "scripts/skills/backgrounds/legend_legion_prefect_background",
    Const = "LegendLegionPrefect",
    Name = "Legion Prefect",
    Stats = ::Legends.BackgroundsStats.LegendLegionPrefect
});

::Legends.Background.LegendLegionSlave <- null;
backgroundDefs.push({
    ID = "background.legend_legion_slave",
    Script = "scripts/skills/backgrounds/legend_legion_slave_background",
    Const = "LegendLegionSlave",
    Name = "Legion Slave",
    Stats = ::Legends.BackgroundsStats.LegendLegionSlave
});

::Legends.Background.LegendLonewolf <- null;
backgroundDefs.push({
    ID = "background.legend_lonewolf",
    Script = "scripts/skills/backgrounds/legend_lonewolf_background",
    Const = "LegendLonewolf",
    Name = "Lonewolf",
    Stats = ::Legends.BackgroundsStats.LegendLonewolf
});

::Legends.Background.LegendLurker <- null;
backgroundDefs.push({
    ID = "background.legend_lurker",
    Script = "scripts/skills/backgrounds/legend_lurker_background",
    Const = "LegendLurker",
    Name = "Lurker",
    Stats = ::Legends.BackgroundsStats.LegendLurker
});

::Legends.Background.LegendMagister <- null;
backgroundDefs.push({
    ID = "background.legend_magister",
    Script = "scripts/skills/backgrounds/legend_magister_background",
    Const = "LegendMagister",
    Name = "Magister",
    Stats = ::Legends.BackgroundsStats.LegendMagister
});

::Legends.Background.LegendManAtArms <- null;
backgroundDefs.push({
    ID = "background.legend_man_at_arms",
    Script = "scripts/skills/backgrounds/legend_man_at_arms_background",
    Const = "LegendManAtArms",
    Name = "Man At Arms",
    Stats = ::Legends.BackgroundsStats.LegendManAtArms
});

::Legends.Background.LegendMasterArcher <- null;
backgroundDefs.push({
    ID = "background.legend_master_archer",
    Script = "scripts/skills/backgrounds/legend_master_archer_background",
    Const = "LegendMasterArcher",
    Name = "Master Archer",
    Stats = ::Legends.BackgroundsStats.LegendMasterArcher
});

::Legends.Background.LegendMuladi <- null;
backgroundDefs.push({
    ID = "background.legend_muladi",
    Script = "scripts/skills/backgrounds/legend_muladi_background",
    Const = "LegendMuladi",
    Name = "Muladi",
    Stats = ::Legends.BackgroundsStats.LegendMuladi
});

::Legends.Background.LegendNecromancer <- null;
backgroundDefs.push({
    ID = "background.legend_necromancer",
    Script = "scripts/skills/backgrounds/legend_necromancer_background",
    Const = "LegendNecromancer",
    Name = "Necromancer",
    Stats = ::Legends.BackgroundsStats.LegendNecromancer
});

::Legends.Background.LegendNecrosavant <- null;
backgroundDefs.push({
    ID = "background.legend_necrosavant",
    Script = "scripts/skills/backgrounds/legend_necrosavant_background",
    Const = "LegendNecrosavant",
    Name = "Necrosavant",
    Stats = ::Legends.BackgroundsStats.LegendNecrosavant
});

::Legends.Background.LegendNecro <- null;
backgroundDefs.push({
    ID = "background.legend_necro",
    Script = "scripts/skills/backgrounds/legend_necro_background",
    Const = "LegendNecro",
    Name = "Necro",
    Stats = ::Legends.BackgroundsStats.LegendNecro
});

::Legends.Background.LegendNightwatch <- null;
backgroundDefs.push({
    ID = "background.legend_nightwatch",
    Script = "scripts/skills/backgrounds/legend_nightwatch_background",
    Const = "LegendNightwatch",
    Name = "Nightwatch",
    Stats = ::Legends.BackgroundsStats.LegendNightwatch
});

::Legends.Background.LegendNoble <- null;
backgroundDefs.push({
    ID = "background.legend_noble",
    Script = "scripts/skills/backgrounds/legend_noble_background",
    Const = "LegendNoble",
    Name = "Noble",
    Stats = ::Legends.BackgroundsStats.LegendNoble
});

::Legends.Background.LegendNoble2h <- null;
backgroundDefs.push({
    ID = "background.legend_noble_2h",
    Script = "scripts/skills/backgrounds/legend_noble_2h",
    Const = "LegendNoble2h",
    Name = "Noble 2h",
    Stats = ::Legends.BackgroundsStats.LegendNoble2h
});

::Legends.Background.LegendNobleRanged <- null;
backgroundDefs.push({
    ID = "background.legend_noble_ranged",
    Script = "scripts/skills/backgrounds/legend_noble_ranged",
    Const = "LegendNobleRanged",
    Name = "Noble Ranged",
    Stats = ::Legends.BackgroundsStats.LegendNobleRanged
});

::Legends.Background.LegendNobleShield <- null;
backgroundDefs.push({
    ID = "background.legend_noble_shield",
    Script = "scripts/skills/backgrounds/legend_noble_shield",
    Const = "LegendNobleShield",
    Name = "Noble Shield",
    Stats = ::Legends.BackgroundsStats.LegendNobleShield
});

::Legends.Background.LegendPhilosopher <- null;
backgroundDefs.push({
    ID = "background.legend_philosopher",
    Script = "scripts/skills/backgrounds/legend_philosopher_background",
    Const = "LegendPhilosopher",
    Name = "Philosopher",
    Stats = ::Legends.BackgroundsStats.LegendPhilosopher
});

::Legends.Background.LegendPilgrim <- null;
backgroundDefs.push({
    ID = "background.legend_pilgrim",
    Script = "scripts/skills/backgrounds/legend_pilgrim_background",
    Const = "LegendPilgrim",
    Name = "Pilgrim",
    Stats = ::Legends.BackgroundsStats.LegendPilgrim
});

::Legends.Background.LegendPremonitionist <- null;
backgroundDefs.push({
    ID = "background.legend_premonitionist",
    Script = "scripts/skills/backgrounds/legend_premonitionist_background",
    Const = "LegendPremonitionist",
    Name = "Premonitionist",
    Stats = ::Legends.BackgroundsStats.LegendPremonitionist
});

::Legends.Background.LegendPreserver <- null;
backgroundDefs.push({
    ID = "background.legend_preserver",
    Script = "scripts/skills/backgrounds/legend_preserver_background",
    Const = "LegendPreserver",
    Name = "Preserver",
    Stats = ::Legends.BackgroundsStats.LegendPreserver
});

::Legends.Background.LegendPuppet <- null;
backgroundDefs.push({
    ID = "background.legend_puppet",
    Script = "scripts/skills/backgrounds/legend_puppet_background",
    Const = "LegendPuppet",
    Name = "Puppet",
    Stats = ::Legends.BackgroundsStats.LegendPuppet
});

::Legends.Background.LegendPuppetMaster <- null;
backgroundDefs.push({
    ID = "background.legend_puppet_master",
    Script = "scripts/skills/backgrounds/legend_puppet_master_background",
    Const = "LegendPuppetMaster",
    Name = "Puppet Master",
    Stats = ::Legends.BackgroundsStats.LegendPuppetMaster
});

::Legends.Background.LegendQiyan <- null;
backgroundDefs.push({
    ID = "background.legend_qiyan",
    Script = "scripts/skills/backgrounds/legend_qiyan_background",
    Const = "LegendQiyan",
    Name = "Qiyan",
    Stats = ::Legends.BackgroundsStats.LegendQiyan
});

::Legends.Background.LegendRanger <- null;
backgroundDefs.push({
    ID = "background.legend_ranger",
    Script = "scripts/skills/backgrounds/legend_ranger_background",
    Const = "LegendRanger",
    Name = "Ranger",
    Stats = ::Legends.BackgroundsStats.LegendRanger
});

::Legends.Background.LegendRunesmith <- null;
backgroundDefs.push({
    ID = "background.legend_runesmith",
    Script = "scripts/skills/backgrounds/legend_runesmith_background",
    Const = "LegendRunesmith",
    Name = "Runesmith",
    Stats = ::Legends.BackgroundsStats.LegendRunesmith
});

::Legends.Background.LegendShieldmaiden <- null;
backgroundDefs.push({
    ID = "background.legend_shieldmaiden",
    Script = "scripts/skills/backgrounds/legend_shieldmaiden_background",
    Const = "LegendShieldmaiden",
    Name = "Shieldmaiden",
    Stats = ::Legends.BackgroundsStats.LegendShieldmaiden
});

::Legends.Background.LegendSpiritualist <- null;
backgroundDefs.push({
    ID = "background.legend_spiritualist",
    Script = "scripts/skills/backgrounds/legend_spiritualist_background",
    Const = "LegendSpiritualist",
    Name = "Spiritualist",
    Stats = ::Legends.BackgroundsStats.LegendSpiritualist
});

::Legends.Background.LegendSurgeon <- null;
backgroundDefs.push({
    ID = "background.legend_surgeon",
    Script = "scripts/skills/backgrounds/legend_surgeon_background",
    Const = "LegendSurgeon",
    Name = "Surgeon",
    Stats = ::Legends.BackgroundsStats.LegendSurgeon
});

::Legends.Background.LegendTaxidermist <- null;
backgroundDefs.push({
    ID = "background.legend_taxidermist",
    Script = "scripts/skills/backgrounds/legend_taxidermist_background",
    Const = "LegendTaxidermist",
    Name = "Taxidermist",
    Stats = ::Legends.BackgroundsStats.LegendTaxidermist
});

::Legends.Background.LegendTrader <- null;
backgroundDefs.push({
    ID = "background.legend_trader",
    Script = "scripts/skills/backgrounds/legend_trader_background",
    Const = "LegendTrader",
    Name = "Trader",
    Stats = ::Legends.BackgroundsStats.LegendTrader
});

::Legends.Background.LegendTransmuter <- null;
backgroundDefs.push({
    ID = "background.legend_transmuter",
    Script = "scripts/skills/backgrounds/legend_transmuter_background",
    Const = "LegendTransmuter",
    Name = "Transmuter",
    Stats = ::Legends.BackgroundsStats.LegendTransmuter
});

::Legends.Background.LegendVala <- null;
backgroundDefs.push({
    ID = "background.legend_vala",
    Script = "scripts/skills/backgrounds/legend_vala_background",
    Const = "LegendVala",
    Name = "Vala",
    Stats = ::Legends.BackgroundsStats.LegendVala
});

::Legends.Background.LegendWarlock <- null;
backgroundDefs.push({
    ID = "background.legend_warlock",
    Script = "scripts/skills/backgrounds/legend_warlock_background",
    Const = "LegendWarlock",
    Name = "Warlock",
    Stats = ::Legends.BackgroundsStats.LegendWarlock
});

::Legends.Background.LegendWarlockSummoner <- null;
backgroundDefs.push({
    ID = "background.legend_warlock_summoner",
    Script = "scripts/skills/backgrounds/legend_warlock_summoner_background",
    Const = "LegendWarlockSummoner",
    Name = "Warlock Summoner",
    Stats = ::Legends.BackgroundsStats.LegendWarlockSummoner
});

::Legends.Background.LegendWitch <- null;
backgroundDefs.push({
    ID = "background.legend_witch",
    Script = "scripts/skills/backgrounds/legend_witch_background",
    Const = "LegendWitch",
    Name = "Witch",
    Stats = ::Legends.BackgroundsStats.LegendWitch
});

::Legends.Background.LegendYoungblood <- null;
backgroundDefs.push({
    ID = "background.legend_youngblood",
    Script = "scripts/skills/backgrounds/legend_youngblood_background",
    Const = "LegendYoungblood",
    Name = "Youngblood",
    Stats = ::Legends.BackgroundsStats.LegendYoungblood
});

::Legends.Backgrounds.addBackgroundDefObjects(backgroundDefs);
