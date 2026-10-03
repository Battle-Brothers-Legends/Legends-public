if (!("Backgrounds" in ::Legends)) {
    ::Legends.Backgrounds <- {};
}

if (!("Background" in ::Legends)) {
    ::Legends.Background <- {};
}

::Legends.Backgrounds.BackgroundDefObjects <- [];
::Legends.Backgrounds.BackgroundDefs <- {};
::Legends.Backgrounds.LookupMap <- {};

::Legends.Backgrounds.createBackgroundDef <- function (_def) {
    ::Legends.Background[_def.Const] <- null;
    local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
    if (!("ID" in _def)) {
        _def.ID <- "background." + snakeCase;
    }

    if (!("Script" in _def)) {
        _def.Script <- "scripts/skills/backgrounds/" + snakeCase + "_background";
    }

    if (!("Name" in _def)) {
        _def.Name <- ::Legends.DefsHelpers.convertToDisplayName(_def.Const);

    }

    if (!("Icon" in _def)) {
        _def.Icon <- "ui/backgrounds/" + snakeCase + ".png";
    }

    if (!("HiringCost" in _def)) {
        _def.HiringCost <- 0;
    }

    if (!("DailyCost" in _def)) {
        _def.DailyCost <- 0;
    }

    return _def;
};

::Legends.Backgrounds.addBackgroundDefObjects <- function (_backgroundDefObjects) {
    local size = ::Legends.Backgrounds.BackgroundDefObjects.len();
    local i = 0;
    foreach (constName, def in _backgroundDefObjects) {
        def.Const <- constName;
        ::Legends.Backgrounds.BackgroundDefObjects.push(::Legends.Backgrounds.createBackgroundDef(def));
        if (def.Const in ::Legends.Background) {
            ::Legends.Background[def.Const] = size + i;
        } else {
            ::Legends.Background[def.Const] <- size + i;
        }
        ::Legends.Backgrounds.BackgroundDefs[def.Const] <- size + i;
        ::Legends.Backgrounds.LookupMap[def.ID] <- def;
        i++;
    }
}

// need the ID getter earlier in this case, for config functions
::Legends.Backgrounds.getID <- function (_def) {
    return ::Legends.Backgrounds.BackgroundDefObjects[_def].ID;
}

::Legends.Backgrounds.findById <- function (_backgroundID) {
    if (_backgroundID != null && _backgroundID in ::Legends.Backgrounds.LookupMap) {
        return ::Legends.Backgrounds.LookupMap[_backgroundID];
    }

    return null;
};

local backgroundDefs = {
    AdventurousNoble = {
        HiringCost = 300,
        DailyCost = 35,
        Icon = "ui/backgrounds/background_06.png"
    },
    Anatomist = {
        HiringCost = 130,
        DailyCost = 12,
        Icon = "ui/backgrounds/background_70.png"
    },
    Apprentice = {
        HiringCost = 80,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_40.png"
    },
    Assassin = {
        HiringCost = 2000,
        DailyCost = 25,
        Icon = "ui/backgrounds/background_53.png"
    },
    AssassinSouthern = {
        // @wiki_name "Southern Assassin",
        Name = "Assassin",
        HiringCost = 800,
        DailyCost = 25,
        Icon = "ui/backgrounds/background_53.png"
    },
    Barbarian = {
        HiringCost = 300,
        DailyCost = 30,
        Icon = "ui/backgrounds/background_58.png"
    },
    Bastard = {
        HiringCost = 170,
        DailyCost = 21,
        Icon = "ui/backgrounds/background_37.png"
    },
    BeastSlayer = {
        Script = "scripts/skills/backgrounds/beast_hunter_background",
        HiringCost = 150,
        DailyCost = 15,
        Icon = "ui/backgrounds/background_57.png"
    },
    Beggar = {
        HiringCost = 30,
        DailyCost = 3,
        Icon = "ui/backgrounds/background_18.png"
    },
    BeggarSouthern = {
        // @wiki_skip
        ID = "background.beggar",
        Name = "Beggar",
        HiringCost = 30,
        DailyCost = 3,
        Icon = "ui/backgrounds/background_18.png"
    },
    BellyDancer = {
        // @wiki_name "Belly Dancer Event",
        HiringCost = 500,
        DailyCost = 20,
        Icon = "ui/backgrounds/background_64.png",
    },
    Bowyer = {
        HiringCost = 80,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_29.png"
    },
    Brawler = {
        HiringCost = 84,
        DailyCost = 13,
        Icon = "ui/backgrounds/background_27.png"
    },
    Butcher = {
        HiringCost = 80,
        DailyCost = 9,
        Icon = "ui/backgrounds/background_43.png"
    },
    ButcherSouthern = {
        // @wiki_skip
        ID = "background.butcher",
        Name = "Butcher",
        HiringCost = 80,
        DailyCost = 9,
        Icon = "ui/backgrounds/background_43.png"
    },
    CaravanHand = {
        HiringCost = 75,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_12.png"
    },
    CaravanHandSouthern = {
        // @wiki_skip
        ID = "background.caravan_hand",
        Name = "Caravan Hand",
        HiringCost = 75,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_12.png"
    },
    Companion = {
        Script = "scripts/skills/backgrounds/companion_1h_background",
        HiringCost = 0,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_companion.png",
    },
    Companion2h = {
        // @wiki_name "Companion Twohanded",
        ID = "background.companion",
        Script = "scripts/skills/backgrounds/companion_2h_background",
        Name = "Companion",
        HiringCost = 0,
        DailyCost = 12,
        Icon = "ui/backgrounds/background_companion.png",
    },
    CompanionRanged = {
        // @wiki_name "Companion Ranged",
        ID = "background.companion",
        Name = "Companion",
        HiringCost = 0,
        DailyCost = 11,
        Icon = "ui/backgrounds/background_companion.png",
    },
    CompanionSouthern = {
        // @wiki_skip
        ID = "background.companion",
        Script = "scripts/skills/backgrounds/companion_1h_southern_background",
        Name = "Companion",
        HiringCost = 0,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_companion.png",
    },
    CompanionSouthern2h = {
        // @wiki_skip
        ID = "background.companion",
        Script = "scripts/skills/backgrounds/companion_2h_southern_background",
        Name = "Companion",
        HiringCost = 0,
        DailyCost = 12,
        Icon = "ui/backgrounds/background_companion.png",
    },
    CompanionSouthernRanged = {
        // @wiki_skip
        ID = "background.companion",
        Script = "scripts/skills/backgrounds/companion_ranged_southern_background",
        Name = "Companion",
        HiringCost = 0,
        DailyCost = 11,
        Icon = "ui/backgrounds/background_companion.png"
    },
    ConvertedCultist = {
        HiringCost = 45,
        DailyCost = 4,
        Icon = "ui/backgrounds/background_34.png"
    },
    Cripple = {
        HiringCost = 30,
        DailyCost = 2,
        Icon = "ui/backgrounds/background_51.png"
    },
    CrippleSouthern = {
        // @wiki_skip
        ID = "background.cripple",
        Name = "Cripple",
        HiringCost = 30,
        DailyCost = 2,
        Icon = "ui/backgrounds/background_51.png"
    },
    Crucified = {
        DailyCost = 30,
        HiringCost = 0,
        Icon = "ui/backgrounds/background_65.png"
    },
    Crusader = {
        HiringCost = 200,
        DailyCost = 23,
        Icon = "ui/backgrounds/background_54.png"
    },
    Cultist = {
        HiringCost = 50,
        DailyCost = 7,
        Icon = "ui/backgrounds/background_34.png"
    },
    Daytaler = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_36.png"
    },
    DaytalerSouthern = {
        // @wiki_skip
        ID = "background.daytaler",
        Name = "Daytaler",
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_36.png",
    },
    Deserter = {
        HiringCost = 85,
        DailyCost = 11,
        Icon = "ui/backgrounds/background_07.png"
    },
    DisownedNoble = {
        HiringCost = 135,
        DailyCost = 17,
        Icon = "ui/backgrounds/background_08.png"
    },
    Eunuch = {
        HiringCost = 60,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_52.png"
    },
    EunuchSouthern = {
        // @wiki_skip
        ID = "background.eunuch",
        Name = "Eunuch",
        HiringCost = 60,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_52.png"
    },
    Executioner = {
        HiringCost = 100,
        DailyCost = 12,
        Icon = "ui/backgrounds/background_72.png"
    },
    ExecutionerSouthern = {
        // @wiki_skip
        ID = "background.executioner",
        Name = "Executioner",
        HiringCost = 100,
        DailyCost = 12,
        Icon = "ui/backgrounds/background_72.png",
    },
    Farmhand = {
        HiringCost = 90,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_09.png"
    },
    Fisherman = {
        HiringCost = 78,
        DailyCost = 9,
        Icon = "ui/backgrounds/background_15.png"
    },
    FishermanSouthern = {
        // @wiki_skip
        ID = "background.fisherman",
        Name = "Fisherman",
        HiringCost = 78,
        DailyCost = 9,
        Icon = "ui/backgrounds/background_15.png",
    },
    Flagellant = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_26.png"
    },
    Gambler = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_20.png"
    },
    GamblerSouthern = {
        // @wiki_skip
        ID = "background.gambler",
        Name = "Gambler",
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_20.png"
    },
    Gladiator = {
        HiringCost = 200,
        DailyCost = 38,
        Icon = "ui/backgrounds/background_61.png"
    },
    GladiatorOrigin = {
        // @wiki_skip
        ID = "background.gladiator",
        Name = "Gladiator",
        HiringCost = 200,
        DailyCost = 50,
        Icon = "ui/backgrounds/background_61.png"
    },
    Gravedigger = {
        HiringCost = 50,
        DailyCost = 5,
        Icon = "ui/backgrounds/background_28.png"
    },
    Graverobber = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_25.png"
    },
    HedgeKnight = {
        HiringCost = 500,
        DailyCost = 50,
        Icon = "ui/backgrounds/background_33.png"
    },
    Historian = {
        HiringCost = 100,
        DailyCost = 7,
        Icon = "ui/backgrounds/background_47.png"
    },
    HistorianSouthern = {
        // @wiki_skip
        ID = "background.historian",
        Name = "Historian",
        HiringCost = 100,
        DailyCost = 7,
        Icon = "ui/backgrounds/background_47.png"
    },
    Houndmaster = {
        HiringCost = 85,
        DailyCost = 11,
        Icon = "ui/backgrounds/background_50.png"
    },
    Hunter = {
        HiringCost = 120,
        DailyCost = 20,
        Icon = "ui/backgrounds/background_22.png"
    },
    Juggler = {
        HiringCost = 100,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_14.png"
    },
    JugglerSouthern = {
        // @wiki_skip
        ID = "background.juggler",
        Name = "Juggler",
        HiringCost = 100,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_14.png"
    },
    KillerOnTheRun = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_02.png"
    },
    KingsGuard = {
        Name = "King\'s Guard",
        HiringCost = 0,
        DailyCost = 30,
        Icon = "ui/backgrounds/background_59.png",
    },
    LindwurmSlayer = {
        DailyCost = 28,
        HiringCost = 0,
        Icon = "ui/backgrounds/background_71.png"
    },
    Lumberjack = {
        HiringCost = 115,
        DailyCost = 13,
        Icon = "ui/backgrounds/background_04.png"
    },
    Manhunter = {
        HiringCost = 120,
        DailyCost = 18,
        Icon = "ui/backgrounds/background_62.png"
    },
    Mason = {
        HiringCost = 90,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_17.png"
    },
    Messenger = {
        HiringCost = 80,
        DailyCost = 9,
        Icon = "ui/backgrounds/background_46.png"
    },
    Militia = {
        HiringCost = 85,
        DailyCost = 14,
        Icon = "ui/backgrounds/background_35.png"
    },
    Miller = {
        HiringCost = 65,
        DailyCost = 7,
        Icon = "ui/backgrounds/background_05.png"
    },
    Miner = {
        HiringCost = 75,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_45.png",
    },
    Minstrel = {
        HiringCost = 665,
        DailyCost = 19,
        Icon = "ui/backgrounds/legend_troubadour.png"
    },
    Monk = {
        HiringCost = 60,
        DailyCost = 5,
        Icon = "ui/backgrounds/background_13.png"
    },
    MonkTurnedFlagellant = {
        HiringCost = 60,
        DailyCost = 5,
        Icon = "ui/backgrounds/background_26.png"
    },
    Nomad = {
        HiringCost = 200,
        DailyCost = 28,
        Icon = "ui/backgrounds/background_63.png"
    },
    NomadRanged = {
        // @wiki_name "Nomad Ranged",
        ID = "background.nomad",
        Name = "Nomad",
        HiringCost = 300,
        DailyCost = 28,
        Icon = "ui/backgrounds/background_63.png"
    },
    OrcSlayer = {
        HiringCost = 200,
        DailyCost = 25,
        Icon = "ui/backgrounds/background_55.png"
    },
    PacifiedFlagellant = {
        HiringCost = 60,
        DailyCost = 5,
        Icon = "ui/backgrounds/background_13.png"
    },
    Paladin = {
        Name = "Oathtaker",
        HiringCost = 150,
        DailyCost = 25,
        Icon = "ui/backgrounds/background_69.png"
    },
    PaladinOld = {
        // @wiki_name "Old Oathtaker",
        ID = "background.paladin",
        Script = "scripts/skills/backgrounds/old_paladin_background",
        Name = "Oathtaker",
        HiringCost = 150,
        DailyCost = 25,
        Icon = "ui/backgrounds/background_69.png"
    },
    Peddler = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_19.png"
    },
    PeddlerSouthern = {
        // @wiki_skip
        ID = "background.peddler",
        Name = "Peddler",
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_19.png"
    },
    Pimp = {
        HiringCost = 60,
        DailyCost = 6,
        Icon = "ui/backgrounds/background_56.png"
    },
    Poacher = {
        HiringCost = 100,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_21.png"
    },
    Raider = {
        HiringCost = 160,
        DailyCost = 28,
        Icon = "ui/backgrounds/background_49.png"
    },
    Ratcatcher = {
        HiringCost = 40,
        DailyCost = 4,
        Icon = "ui/backgrounds/background_41.png"
    },
    Refugee = {
        HiringCost = 40,
        DailyCost = 4,
        Icon = "ui/backgrounds/background_38.png"
    },
    RegentInAbsentia = {
        // @wiki_skip
        HiringCost = 135,
        DailyCost = 30,
        Icon = "ui/backgrounds/background_06.png"
    },
    RetiredSoldier = {
        HiringCost = 140,
        DailyCost = 15,
        Icon = "ui/backgrounds/background_24.png"
    },
    Sellsword = {
        HiringCost = 100,
        DailyCost = 35,
        Icon = "ui/backgrounds/background_10.png"
    },
    Servant = {
        HiringCost = 45,
        DailyCost = 4,
        Icon = "ui/backgrounds/background_16.png"
    },
    Shepherd = {
        HiringCost = 80,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_44.png"
    },
    ShepherdSouthern = {
        // @wiki_skip
        ID = "background.shepherd",
        Name = "Shepherd",
        HiringCost = 80,
        DailyCost = 8,
        Icon = "ui/backgrounds/background_44.png"
    },
    Slave = {
        HiringCost = @() ::Math.rand(19, 22) * 10,
        DailyCost = 0,
        Icon = "ui/backgrounds/background_60.png"
    },
    SlaveBarbarian = {
        //@wiki_skip
        ID = "background.slave",
        Name = "Slave",
        HiringCost = @() ::Math.rand(19, 22) * 10,
        DailyCost = 0,
        Icon = "ui/backgrounds/background_60.png"
    },
    SlaveSouthern = {
        //@wiki_skip
        ID = "background.slave",
        Name = "Slave",
        HiringCost = @() ::Math.rand(19, 22) * 10,
        DailyCost = 0,
        Icon = "ui/backgrounds/background_60.png"
    },
    Squire = {
        HiringCost = 320,
        DailyCost = 26,
        Icon = "ui/backgrounds/background_03.png"
    },
    Swordmaster = {
        HiringCost = 400,
        DailyCost = 35,
        Icon = "ui/backgrounds/background_30.png"
    },
    Tailor = {
        HiringCost = 50,
        DailyCost = 5,
        Icon = "ui/backgrounds/background_48.png"
    },
    TailorSouthern = {
        // @wiki_skip
        ID = "background.tailor",
        Name = "Tailor",
        HiringCost = 50,
        DailyCost = 5,
        Icon = "ui/backgrounds/background_48.png"
    },
    Thief = {
        HiringCost = 95,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_11.png"
    },
    ThiefSouthern = {
        // @wiki_skip
        ID = "background.thief",
        Name = "Thief",
        HiringCost = 95,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_11.png"
    },
    Vagabond = {
        HiringCost = 70,
        DailyCost = 9,
        Icon = "ui/backgrounds/background_32.png"
    },
    Wildman = {
        HiringCost = 200,
        DailyCost = 18,
        Icon = "ui/backgrounds/background_31.png"
    },
    Witchhunter = {
        HiringCost = 325,
        DailyCost = 21,
        Icon = "ui/backgrounds/background_23.png"
    },
    LegendAdventurousNobleRanged = {
        // @wiki_name "Adventurous Noble Ranged",
        Name = "Adventurous Noble",
        HiringCost = 300,
        DailyCost = 35,
    },
    LegendAlchemist = {
        HiringCost = 1250,
        DailyCost = 20,
    },
    LegendArbalester = {
        HiringCost = 900,
        DailyCost = 35
    },
    LegendBattleSister = {
        HiringCost = 160, //currently cannot recruit battle sisters - will update in inq. origin update - Luft
        DailyCost = 18,
        Icon = "ui/backgrounds/background_26.png"
    },
    LegendBellyDancer = {
        HiringCost = 500,
        DailyCost = 10,
        Icon = "ui/backgrounds/background_64.png"
    },
    LegendBerserker = {
        HiringCost = 3500,
        DailyCost = 35
    },
    LegendBlacksmith = {
        HiringCost = 500,
        DailyCost = 23
    },
    LegendBladedancer = {
        HiringCost = 850,
        DailyCost = 45
    },
    LegendBountyHunter = {
        HiringCost = 500,
        DailyCost = 55
    },
    LegendCommanderAssassin = {
        Name = "Master Assassin",
        HiringCost = 10000,
        Icon = "ui/backgrounds/background_53.png"
    },
    LegendCommanderBeggar = {
        Name = "Framed Beggar",
        HiringCost = 30,
        Icon = "ui/backgrounds/background_18.png"
    },
    LegendCommanderBeggarScaling = {
        // @wiki_name "Framed Beggar Pending Deletion",
        ID = "background.legend_beggar_commander_op",
        Script = "scripts/skills/backgrounds/legend_beggar_commander_op_background",
        Const = "LegendCommanderBeggarScaling",
        Name = "Framed Beggar",
        HiringCost = 30,
        Icon = "ui/backgrounds/background_18.png"
    },
    LegendCommanderBerserker = {
        Name = "Chosen Berserker",
        HiringCost = 10000,
        Icon = "ui/backgrounds/legend_berserker.png"
    },
    LegendCommanderCrusader = {
        Name = "Holy Crusader",
        HiringCost = 3500,
        DailyCost = 25,
        Icon = "ui/backgrounds/background_54.png"
    },
    LegendCommanderNecro = {
        Name = "Master Necromancer",
    },
    LegendCommanderNoble = {
        Name = "Noble Usurper",
        HiringCost = 25000,
        DailyCost = 25,
        Icon = "ui/backgrounds/legend_noble_usurper.png"
    },
    LegendCommanderPeddler = {
        Name = "Merchant",
        HiringCost = 10000,
        Icon = "ui/backgrounds/background_19.png"
    },
    LegendCommanderRanger = {
        Name = "Ranger",
        HiringCost = 12000,
        Icon = "ui/backgrounds/legend_warden.png"
    },
    LegendCompanionMelee = {
        // @wiki_name "Lonewolf Companion",
        Name = "Companion",
        Icon = "ui/backgrounds/background_companion.png"
    },
    LegendCompanionRanged = {
        // @wiki_name "Lonewolf Companion Ranged",
        Name = "Companion",
        Icon = "ui/backgrounds/background_companion.png"
    },
    LegendConscript = {
        HiringCost = 300,
        DailyCost = 35,
    },
    LegendConscriptRanged = {
        ID = "background.legend_conscript",
        Name = "Conscript Gunner",
        HiringCost = 100,
        DailyCost = 35,
    },
    LegendDervish = {
        HiringCost = 140,
        DailyCost = 14,
    },
    LegendDisownedNobleRanged = {
        // @wiki_name "Disowned Noble Ranged",
        Name = "Disowned Noble",
        HiringCost = 135,
        DailyCost = 17,
        Icon = "ui/backgrounds/background_08.png"
    },
    LegendDonkey = {
        HiringCost = 5000
    },
    LegendDruid = {
        HiringCost = 2000,
        DailyCost = 25,
    },
    LegendFootSoldier = {
        HiringCost = 300,
        DailyCost = 35
    },
    LegendGladiatorPrizefighter = {
        ID = "background.gladiator",
        HiringCost = 550,
        DailyCost = 38
    },
    LegendGuildMaster = {
        HiringCost = 185,
        DailyCost = 27
    },
    LegendHerbalist = {
        HiringCost = 120,
        DailyCost = 18
    },
    LegendHouseGuard = {
        HiringCost = 500,
        DailyCost = 35
    },
    LegendHusk = {
        HiringCost = 150,
        DailyCost = 20,
    },
    LegendIllusionist = {
        HiringCost = 1000,
        DailyCost = 20
    },
    LegendInventor = {
        HiringCost = 1250,
        DailyCost = 25
    },
    LegendIronmonger = {
        HiringCost = 100,
        DailyCost = 11
    },
    LegendLeechPeddler = {
        HiringCost = 45,
        DailyCost = 6
    },
    LegendLegionAuxiliary = {
        Name = "Auxiliary"
    },
    LegendLegionCenturion = {
        Name = "Centurion"
    },
    LegendLegionGladiator = {
        // @wiki_name "Legion Gladiator",
        Name = "Gladiator"
    },
    LegendLegionHonourGuard = {
        Name = "Honour Guard"
    },
    LegendLegionLegate = {
        Name = "Legate"
    },
    LegendLegionLegionary = {
        Name = "Legionary"
    },
    LegendLegionPrefect = {
        Name = "Prefect"
    },
    LegendLegionSlave = {
        Name = "Servus"
    },
    LegendLoneWolf = {},
    LegendLurker = {
        HiringCost = 120,
        DailyCost = 11
    },
    LegendMagister = {
        HiringCost = 250,
        DailyCost = 27
    },
    LegendManAtArms = {
        Name = "Man-At-Arms",
        HiringCost = 130,
        DailyCost = 15,
    },
    LegendMasterArcher = {
        HiringCost = 885,
        DailyCost = 32
    },
    LegendMuladi = {
        HiringCost = 100,
        DailyCost = 16
    },
    LegendNecromancer = {
        HiringCost = 1000,
        DailyCost = 20
    },
    LegendNecrosavant = {
        HiringCost = 1000,
        DailyCost = 20
    },
    LegendNightwatch = {
        HiringCost = 120,
        DailyCost = 10
    },
    LegendPilgrim = {
        DailyCost = 5
    },
    LegendPreserver = {},
    LegendPuppet = {},
    LegendPuppetMaster = {},
    LegendReanimator = {},
    LegendSeer = {
        HiringCost = 250
    },
    LegendShieldmaiden = {
        HiringCost = 450,
        DailyCost = 30
    },
    LegendSurgeon = {
        DailyCost = 45
    },
    LegendTaxidermist = {
        HiringCost = 250,
        DailyCost = 10
    },
    LegendVala = {
        HiringCost = 20000,
        DailyCost = 24
    },
    LegendWarden = {
        HiringCost = 2500,
        DailyCost = 35
    },
    LegendWarlock = {
        HiringCost = 1000,
        DailyCost = 20
    },
    LegendYoungblood = {
        HiringCost = 95,
        DailyCost = 10
    },
    LegendHorse = {
        // @wiki_skip
        HiringCost = 10000,
        DailyCost = 1
    },
    LegendHorserider = {
        // @wiki_skip
        HiringCost = 10000,
        DailyCost = 1,
        Icon = "ui/backgrounds/donkey.png"
    },
    LegendHorseCourser = {
        // @wiki_skip
        HiringCost = 20000,
        DailyCost = 1,
        Icon = "ui/backgrounds/legend_horse.png"
    },
    LegendHorseDestrier = {
        // @wiki_skip
        HiringCost = 55000,
        DailyCost = 1,
        Icon = "ui/backgrounds/legend_horse.png"
    },
    LegendHorseRouncey = {
        // @wiki_skip
        HiringCost = 10000,
        DailyCost = 1,
        Icon = "ui/backgrounds/legend_horse.png"
    }
};

::Legends.Backgrounds.addBackgroundDefObjects(backgroundDefs);
