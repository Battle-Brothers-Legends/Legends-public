local gt = this.getroottable();
gt.tnf_debug <- {};

//*************************//
//        FUNCTIONS        //
//                         //
// awful ugly functions    //
// are at the file bottom  //
//*************************//


gt.tnf_debug.getAttributesValues <- function (character, levelup = true, perk = true) {
  local attributes = {
    Hitpoints     = 0,
    Bravery       = 0,
    Fatigue       = 0,
    Initiative    = 0,
    MeleeSkill    = 0,
    RangedSkill   = 0,
    MeleeDefense  = 0,
    RangedDefense = 0
  };

  local properties = character.getCurrentProperties();

  attributes.Hitpoints = character.getHitpointsMax();
  attributes.Bravery = character.getBravery();
  attributes.Fatigue = character.getFatigueMax();
  attributes.Initiative = character.getInitiative();
  attributes.MeleeSkill = properties.getMeleeSkill();
  attributes.RangedSkill = properties.getRangedSkill();
  attributes.MeleeDefense = properties.getMeleeDefense();
  attributes.RangedDefense = properties.getRangedDefense();

  if (levelup) {
    foreach (attribute, index in gt.Const.Attributes) { //table w/ HP = 0, RES = 1, etc.
      if (index > 7) continue; //only 8 attributes
      foreach (level in character.m.Attributes[index]) { //level up values
        attributes[attribute] += level;
      }
      //this.logInfo("TNF | " + character.getName() + " current and level up value for " + attribute + " = " + attributes[attribute]);
    }
  }

  if (perk) {
    local skills = character.getSkills();
    if (skills.hasTrait(::Legends.Trait.IronLungs)) attributes.Fatigue += 20;
    if (skills.hasTrait(::Legends.Trait.Asthmatic)) attributes.Fatigue -= 15;
    if (skills.hasTrait(::Legends.Trait.Athletic)) attributes.Fatigue += 10;
    if (skills.hasTrait(::Legends.Trait.Clubfooted)) attributes.Fatigue -= 10;
  }

  return attributes;
};

/***************************************************/

/* running the IO function inside gt will cause bugs */
gt.tnf_debug.fillFileList <- function(fileList) {
  foreach (type, value in fileList)
  {
    fileList[type] = this.IO.enumerateFiles(gt.tnf_debug.directories[type]);
  }
};

/***************************************************/

gt.tnf_debug.purgeFileList <- function(fileList) {
  foreach (type, files in fileList)
  {
    local fileToExclude = fileList[type].find(gt.tnf_debug.excludedFiles[type]);
    fileList[type].remove(fileToExclude);
  }
  return fileList;
};

/***************************************************/

gt.tnf_debug.getRandomActor <- function(faction = "random") {
  if (faction == "random" ) faction = gt.tnf_debug.factions[this.Math.rand(0, gt.tnf_debug.factions.len() - 1)];
  local actor = gt.tnf_debug.actors[faction][this.Math.rand(0, gt.tnf_debug.actors[faction].len() - 1)];
  return [faction, actor];
};

/***************************************************/

gt.tnf_debug.getTraits <- function(character) {
  local traits = [];
  foreach(skill in character.m.Skills.m.Skills)
  {
    if (skill.getType() == this.Const.SkillType.Trait) traits.push(skill.getID());
  }
  return traits;
};

/***************************************************/


/***************************************************/

gt.tnf_debug.getActorFaction <- function(actor) {
  foreach (faction, actors in gt.tnf_debug.actors)
  {
    foreach (factionActor in actors)
    {
      if (actor != factionActor) continue;
      return faction;
    }
  }
  return null;
};

/***************************************************/

/***************************************************/

//gt.tnf_debug. <- function() {
//
//};

/***************************************************/

//*************************//
//                         //
//     ARRAYS & TABLES     //
//                         //
//*************************//

gt.tnf_debug.positiveTraits <- [
    "athletic",
    "bloodthirsty",
    "brave",
    "bright",
    "cultist_chosen",
    "deathwish",
    "determined",
    "dexterous",
    "drunkard",
    "eagle_eyes",
    "fearless",
    "athletic",
    "hate_beasts",
    "hate_greenskins",
    "hate_undead",
    "huge",
    "impatient",
    "iron_jaw",
    "iron_lungs",
    "loyal",
    "lucky",
    "night_owl",
    "optimist",
    "paranoid",
    //"player_character",
    "quick",
    "sure_footing",
    "survivor",
    "swift",
    "teamplayer",
    "tough",
    "weasel"
];

gt.tnf_debug.negativeStatusEffects <- [
  "acid",
  "bleeding",
  "charmed",
  "chilled",
  "dazed",
  "disarmed",
  "goblin_poison",
  "hex_slave",
  "horrified",
  "insect_swarm",
  "kraken_ensnare",
  "lindwurm_acid",
  "net",
  "overwhelmed",
  "rooted",
  "sleeping",
  "spider_poison",
  "staggered",
  "stunned",
  "web"
];

//gt.tnf_debug.factions <- [
//  "bandits",
//  "barbarians",
//  "beasts",
//  "civilian",
//  "greenskins",
//  "military",
//  "undead"
//];

gt.tnf_debug.factions <- [
  "Bandits",
  "Barbarians",
  "Beasts",
  "Civilian",
  "Goblins",
  "NobleHouse",
  "Orcs",
  "Undead",
  "Zombies",
];

gt.tnf_debug.actors <- {
  //M for MONSTER                Summons a random enemy from list
  M = [
    "LegendDemonAlp"
    // "LegendMummyLight",
    // "LegendMummyMedium",
    // "LegendMummyHeavy",
    // "LegendMummyQueen"
    //"SkeletonGladiator",
    // "KoboldFighter",
    // "KoboldWolfrider"
    // "GoblinSkirmisher",
    // "GoblinSkirmisherLOW",
    // "GoblinAmbusher",
    // "GoblinAmbusherLOW",
    // "GoblinShaman",
    // "GoblinOverseer",
    // "GoblinWolfrider"
  ],
  Bandits = [
    "Wardog",
    "BanditThug",
    "BanditMarksman",
    "BanditMarksmanLOW",
    "BanditRaider",
    "BanditRaiderLOW",
    "BanditRaiderWolf",
    "BanditLeader",
    "LegendManhunter",
    "LegendManhunterVeteran",
    "BanditVermes",
    "BanditRabblePoacher",
    "BanditOutrider",
    "BanditWarlord",
    "BanditVeteran",
  ],
  Barbarians = [
    "Warhound",
    "BarbarianThrall",
    "BarbarianMarauder",
    "BarbarianChampion",
    "BarbarianChosen",
    "BarbarianDrummer",
    //"BarbarianUnhold",
    //"BarbarianUnholdFrost",
    "BarbarianBeastmaster"
  ],

  Beasts = [
    "BarbarianUnhold",
    "BarbarianUnholdFrost",
    "Direwolf",
    "DirewolfHIGH",
    "DirewolfBodyguard",
    "GhoulLOW",
    "Ghoul",
    "GhoulHIGH",
    "Lindwurm",
    "Unhold",
    "UnholdFrost",
    "UnholdBog",
    "Spider",
    "SpiderBodyguard",
    "Alp",
    "Hexe",
    "Schrat",
    "Kraken",
    "TricksterGod",
    "LegendWhiteWarwolf",
    "LegendGreenwoodSchratSmall",
    "LegendGreenwoodSchrat",
    "LegendHexeLeader",
    "LegendDemonAlp",
    "LegendRedbackSpider",
    "LegendRockUnhold",
    "LegendStollwurm",
    "LegendWhiteDirewolf",
  ],
  Settlement = [
    "Militia",
    "MilitiaRanged",
    "MilitiaVeteran",
    "MilitiaCaptain",
    "BountyHunter",
    "BountyHunterRanged",
    "Peasant",
    "PeasantArmed",
    "Mercenary",
    "MercenaryLOW",
    "MercenaryRanged",
    "Swordmaster",
    "HedgeKnight",
    "MasterArcher",
    "Cultist",
    "CultistAmbush",
    "CaravanHand",
    "CaravanGuard",
    //"CaravanDonkey"
    "LegendPeasantWitchHunter",
    "LegendPeasantSquire",
    "LegendPeasantMiner",
    "LegendPeasantWoodsman",
    "LegendPeasantPoacher",
    "LegendPeasantMinstrel",
    "LegendPeasantFarmhand",
    "LegendPeasantMonk",
    "LegendPeasantBlacksmith",
    "LegendPeasantButcher",
    "BanditRabble",
  ],
  Goblins = [
    //"GreenskinCatapult",
    "GoblinSkirmisher",
    "GoblinSkirmisherLOW",
    "GoblinAmbusher",
    "GoblinAmbusherLOW",
    "GoblinShaman",
    "GoblinOverseer",
    "GoblinWolfrider"
  ],
  Orcs = [
    "OrcYoung",
    "OrcYoungLOW",
    "OrcBerserker",
    "OrcWarrior",
    "OrcWarriorLOW",
    "OrcWarlord",
    "LegendOrcBehemoth",
    "LegendOrcElite",
  ],
  NobleHouse = [
    "ArmoredWardog",
    "Footman",
    "Greatsword",
    "Billman",
    "Arbalester",
    "StandardBearer",
    "Sergeant",
    "Knight",
    "LegendFencer",
    "LegendSlinger",
    "LegendHalberdier"

    //"MilitaryDonkey"
  ],
  Undead = [
    "SkeletonLight",
    "SkeletonMedium",
    "SkeletonMediumPolearm",
    "SkeletonHeavy",
    "SkeletonHeavyPolearm",
    "SkeletonHeavyBodyguard",
    "SkeletonPriest",
    "SkeletonBoss",
    "Vampire",
    "VampireLOW",
    "LegendVampireLord",
    "SkeletonGladiator",

  ],
  Zombies = [
    "Necromancer",
    "Zombie",
    "ZombieYeoman",
    "ZombieKnight",
    "ZombieBodyguard",
    "ZombieYeomanBodyguard",
    "ZombieKnightBodyguard",
    "ZombieBetrayer",
    "ZombieBoss",
    "Ghost",
    "LegendDemonHound",
    "LegendBanshee",
    "LegendMummyLight",
    "LegendMummyMedium",
    "LegendMummyHeavy",
    "LegendMummyQueen"

  ]
};

gt.tnf_debug.attributes <- [
  "Hitpoints",
  "Bravery",
  "Stamina",
  "Initiative",
  "MeleeSkill",
  "RangedSkill",
  "MeleeDefense",
  "RangedDefense"
];

gt.tnf_debug.attributeAbbr <- {
  Hitpoints     = "HP",
  Bravery       = "RES",
  Fatigue       = "FAT",
  Initiative    = "INI",
  MeleeSkill    = "MSK",
  RangedSkill   = "RSK",
  MeleeDefense  = "MDF",
  RangedDefense = "RDF"
};


gt.tnf_debug.itemTypes <- [
  "armors",
  "helmets",
  "weapons",
  "shields",
];

gt.tnf_debug.directories <- {
  named_armors	= "scripts/items/armor/named/",
  named_helmets	= "scripts/items/helmets/named/",
  named_weapons	= "scripts/items/weapons/named/",
  named_shields	= "scripts/items/shields/named/",
  backgrounds   = "scripts/skills/backgrounds/",
};

gt.tnf_debug.files <- {
//  named_armors	= [],
//  named_helmets	= [],
//  named_weapons	= [],
//  named_shields	= [],
};

/* populate the file list with arrays for files */
foreach(item, directory in gt.tnf_debug.directories) {gt.tnf_debug.files[item] <- [];}

gt.tnf_debug.excludedFiles <- {
  named_armors	= "scripts/items/armor/named/named_armor",
  named_helmets	= "scripts/items/helmets/named/named_helmet",
  named_weapons	= "scripts/items/weapons/named/named_weapon",
  named_shields	= "scripts/items/shields/named/named_shield",
  backgrounds   = "scripts/skills/backgrounds/character_background",
};

gt.tnf_debug.prefixes <- {
  named_weapon  = "weapon.named_",
  named_shield  = "shield.named_",
  named_armor   = "armor.body.",
  named_helmet  = "armor.head."
};

gt.tnf_debug.DDAWeapons <- {
  goblin_heavy_bow = 1,
  heavy_rusty_axe = 1,
  rusty_warblade = 1,
  skullhammer = 1,
  two_handed_spiked_mace = 1
};

gt.tnf_debug.itemStats <- {
  weapons = {
    axe = {
      condition = 80,
      regular   = 90,
      direct    = 0.3,
      armor     = 1.3,
      shield    = 16,
      head      = 0,
      fat       = -12
    },
    orc_axe = {
      condition = 64,
      regular   = 100,
      direct    = 0.3,
      armor     = 1.3,
      shield    = 16,
      head      = 0,
      fat       = -22
    },
    battle_whip = {
      condition = 40,
      regular   = 45,
      direct    = 0.1,
      armor     = 0.25,
      shield    = 0,
      head      = 0,
      fat       = -6
    },
    cleaver = {
      condition = 80,
      regular   = 100,
      direct    = 0.25,
      armor     = 0.9,
      shield    = 0,
      head      = 0,
      fat       = -12
    },
    khopesh = {
      condition = 42,
      regular   = 90,
      direct    = 0.25,
      armor     = 1.2,
      shield    = 0,
      head      = 0,
      fat       = -10
    },
    orc_cleaver = {
      condition = 52,
      regular   = 110,
      direct    = 0.25,
      armor     = 1.1,
      shield    = 0,
      head      = 0,
      fat       = -18
    },
    dagger = {
      condition = 50,
      regular   = 60,
      direct    = 0.2,
      armor     = 0.7,
      shield    = 0,
      head      = 0,
      fat       = 0
    },
    flail = {
      condition = 72,
      regular   = 80,
      direct    = 0.3,
      armor     = 1,
      shield    = 0,
      head      = 10,
      fat       = -8
    },
    three_headed_flail = {
      condition = 60,
      regular   = 105,
      direct    = 0.3,
      armor     = 1,
      shield    = 0,
      head      = 10,
      fat       = -10
    },
    warhammer = {
      condition = 100,
      regular   = 70,
      direct    = 0.5,
      armor     = 2.25,
      shield    = 0,
      head      = 0,
      fat       = -8
    },
    mace = {
      condition = 80,
      regular   = 90,
      direct    = 0.4,
      armor     = 1.1,
      shield    = 0,
      head      = 0,
      fat       = -10
    },
    goblin_spear = {
      condition = 36,
      regular   = 60,
      direct    = 0.25,
      armor     = 0.7,
      shield    = 0,
      head      = 0,
      fat       = -2
    },
    spear = {
      condition = 72,
      regular   = 75,
      direct    = 0.25,
      armor     = 1,
      shield    = 0,
      head      = 0,
      fat       = -10
    },
    goblin_falchion = {
      condition = 52,
      regular   = 80,
      direct    = 0.2,
      armor     = 0.7,
      shield    = 0,
      head      = 0,
      fat       = -2
    },
    fencing_sword = {
      condition = 48,
      regular   = 85,
      direct    = 0.2,
      armor     = 0.75,
      shield    = 0,
      head      = 0,
      fat       = -4
    },
    shamshir = {
      condition = 72,
      regular   = 95,
      direct    = 0.2,
      armor     = 0.75,
      shield    = 0,
      head      = 0,
      fat       = -8
    },
    sword = {
      condition = 72,
      regular   = 95,
      direct    = 0.2,
      armor     = 0.85,
      shield    = 0,
      head      = 0,
      fat       = -8
    },
    bardiche = {
      condition = 64,
      regular   = 170,
      direct    = 0.4,
      armor     = 1.3,
      shield    = 24,
      head      = 0,
      fat       = -16
    },
    greataxe = {
      condition = 72,
      regular   = 180,
      direct    = 0.4,
      armor     = 1.5,
      shield    = 36,
      head      = 0,
      fat       = -16
    },
    heavy_rusty_axe = {
      condition = 96,
      regular   = 165,
      direct    = 0.5,
      armor     = 1.5,
      shield    = 36,
      head      = 0,
      fat       = -16
    },
    longaxe = {
      condition = 72,
      regular   = 165,
      direct    = 0.3,
      armor     = 1.1,
      shield    = 24,
      head      = 5,
      fat       = -14
    },
    crypt_cleaver = {
      condition = 48,
      regular   = 150,
      direct    = 0.25,
      armor     = 1.15,
      shield    = 16,
      head      = 0,
      fat       = -16
    },
    rusty_warblade = {
      condition = 52,
      regular   = 140,
      direct    = 0.35,
      armor     = 1.1,
      shield    = 16,
      head      = 0,
      fat       = -18
    },
    two_handed_flail = {
      condition = 80,
      regular   = 120,
      direct    = 0.3,
      armor     = 1.1,
      shield    = 0,
      head      = 15,
      fat       = -16
    },
    polehammer = {
      condition = 100,
      regular   = 125,
      direct    = 0.5,
      armor     = 1.75,
      shield    = 0,
      head      = 5,
      fat       = -14
    },
    two_handed_hammer = {
      condition = 120,
      regular   = 150,
      direct    = 0.5,
      armor     = 2,
      shield    = 26,
      head      = 0,
      fat       = -18
    },
    skullhammer = {
      condition = 120,
      regular   = 110,
      direct    = 0.6,
      armor     = 1.8,
      shield    = 26,
      head      = 0,
      fat       = -16
    },
    two_handed_mace = {
      condition = 120,
      regular   = 170,
      direct    = 0.5,
      armor     = 1.25,
      shield    = 26,
      head      = 0,
      fat       = -16
    },
    two_handed_spiked_mace = {
      condition = 72,
      regular   = 120,
      direct    = 0.6,
      armor     = 1.15,
      shield    = 20,
      head      = 0,
      fat       = -14
    },
    billhook = {
      condition = 72,
      regular   = 140,
      direct    = 0.3,
      armor     = 1.4,
      shield    = 0,
      head      = 5,
      fat       = -14
    },
    bladed_pike = {
      condition = 30,
      regular   = 135,
      direct    = 0.3,
      armor     = 1.25,
      shield    = 0,
      head      = 5,
      fat       = -14
    },
    goblin_pike = {
      condition = 40,
      regular   = 120,
      direct    = 0.25,
      armor     = 0.9,
      shield    = 0,
      head      = 5,
      fat       = -6
    },
    pike = {
      condition = 64,
      regular   = 140,
      direct    = 0.3,
      armor     = 1,
      shield    = 0,
      head      = 5,
      fat       = -14
    },
    warscythe = {
      condition = 36,
      regular   = 135,
      direct    = 0.35,
      armor     = 1.05,
      shield    = 0,
      head      = 0,
      fat       = -16
    },
    spetum = {
      condition = 60,
      regular   = 130,
      direct    = 0.25,
      armor     = 1,
      shield    = 0,
      head      = 5,
      fat       = -14
    },
    greatsword = {
      condition = 72,
      regular   = 185,
      direct    = 0.25,
      armor     = 1,
      shield    = 16,
      head      = 5,
      fat       = -12
    },
    warbrand = {
      condition = 64,
      regular   = 125,
      direct    = 0.2,
      armor     = 0.75,
      shield    = 0,
      head      = 5,
      fat       = -10
    },
    goblin_heavy_bow = {
      condition = 62,
      regular   = 80,
      direct    = 0.45,
      armor     = 0.6,
      shield    = 0,
      head      = 0,
      fat       = -2
    },
    warbow = {
      condition = 100,
      regular   = 120,
      direct    = 0.35,
      armor     = 0.6,
      shield    = 0,
      head      = 0,
      fat       = -6
    },
    crossbow = {
      condition = 64,
      regular   = 120,
      direct    = 0.5,
      armor     = 0.75,
      shield    = 0,
      head      = 0,
      fat       = -12
    },
    javelin = {
      condition = 0,
      regular   = 75,
      direct    = 0.45,
      armor     = 0.75,
      shield    = 0,
      head      = 0,
      fat       = -6
    },
    throwing_axe = {
      condition = 0,
      regular   = 65,
      direct    = 0.25,
      armor     = 1.1,
      shield    = 0,
      head      = 5,
      fat       = -4
    },
    handgonne = {
      condition = 60,
      regular   = 110,
      direct    = 0.25,
      armor     = 1,
      shield    = 0,
      head      = 0,
      fat       = -12
    },
    polemace = {
      condition = 64,
      regular   = 135,
      direct    = 0.4,
      armor     = 1.2,
      shield    = 0,
      head      = 5,
      fat       = -14
    },
    qatal_dagger = {
      condition = 60,
      regular   = 75,
      direct    = 0.2,
      armor     = 0.7,
      shield    = 0,
      head      = 0,
      fat       = 0
    },
    swordlance = {
      condition = 52,
      regular   = 140,
      direct    = 0.3,
      armor     = 0.9,
      shield    = 0,
      head      = 0,
      fat       = -14
    },
    two_handed_scimitar = {
      condition = 64,
      regular   = 150,
      direct    = 0.25,
      armor     = 1.1,
      shield    = 16,
      head      = 0,
      fat       = -14
    }
  },
  armors = {
    black_leather = {
      condition = 110,
      fat       = -11
    },
    blue_studded_mail = {
      condition = 150,
      fat       = -18
    },
    brown_coat_of_plates = {
      condition = 300,
      fat       = -36
    },
    golden_scale = {
      condition = 230,
      fat       = -30
    },
    green_coat_of_plates = {
      condition = 320,
      fat       = -42
    },
    heraldic_mail = {
      condition = 210,
      fat       = -26
    },
    lindwurm_armor = {
      condition = 300,
      fat       = -36
    },
    named_bronze_armor = {
      condition = 280,
      fat       = -35
    },
    named_golden_lamellar_armor = {
      condition = 285,
      fat       = -40
    },
    named_noble_mail_armor = {
      condition = 160,
      fat       = -15
    },
    named_plated_fur_armor = {
      condition = 130,
      fat       = -14
    },
    named_skull_and_chain_armor ={
      condition = 190,
      fat       = -24
    },
    named_sellswords_armor = {
      condition = 260,
      fat       = -32
    },
    black_and_gold = {
      condition = 210,
      fat       = -25
    },
    leopard_armor = {
      condition = 290,
      fat       = -35
    }
  },
  helmets = {
    golden_feathers = {
      condition = 240,
      fat       = -16
    },
    heraldic_mail = {
      condition = 280,
      fat       = -19
    },
    lindwurm_helmet = {
      condition = 265,
      fat       = -18
    },
    named_conic_helmet_with_faceguard = {
      condition = 280,
      fat       = -19
    },
    named_metal_bull_helmet = {
      condition = 300,
      fat       = -22
    },
    named_metal_nose_horn_helmet = {
      condition = 230,
      fat       = -15
    },
    named_metal_skull_helmet = {
      condition = 210,
      fat       = -13
    },
    named_nordic_helmet_with_closed_mail = {
      condition = 265,
      fat       = -18
    },
    named_steppe_helmet_with_mail = {
      condition = 200,
      fat       = -12
    },
    nasal_feather = {
      condition = 265,
      fat       = -18
    },
    norse = {
      condition = 125,
      fat       = -6
    },
    sallet_green = {
      condition = 265,
      fat       = -18
    },
    wolf = {
      condition = 140,
      fat       = -8
    },
    norse_old = { //tnf restored
      condition = 180,
      fat       = -10
    },
    gold_and_black_turban = {
      condition = 290,
      fat       = -20
    },
    red_and_gold_band_helmet = {
      condition = 255,
      fat       = -17
    }
  },
  shields = {
    bandit_heater = {
      condition = 32,
      mdf       = 20,
      rdf       = 15,
      fat       = -14
    },
    bandit_kite_shield = {
      condition = 48,
      mdf       = 15,
      rdf       = 25,
      fat       = -16
    },
    dragon = {
      condition = 48,
      mdf       = 15,
      rdf       = 25,
      fat       = -16
    },
    full_metal_heater = {
      condition = 50,
      mdf       = 20,
      rdf       = 15,
      fat       = -18
    },
    golden_round = {
      condition = 50,
      mdf       = 20,
      rdf       = 15,
      fat       = -18
    },
    orc_heavy_shield = {
      condition = 72,
      mdf       = 15,
      rdf       = 15,
      fat       = -22
    },
    red_white = {
      condition = 48,
      mdf       = 15,
      rdf       = 25,
      fat       = -16
    },
    rider_on_horse = {
      condition = 32,
      mdf       = 20,
      rdf       = 15,
      fat       = -14
    },
    undead_heater_shield = {
      condition = 32,
      mdf       = 20,
      rdf       = 15,
      fat       = -14
    },
    undead_kite_shield = {
      condition = 48,
      mdf       = 15,
      rdf       = 25,
      fat       = -16
    },
    wing = {
      condition = 32,
      mdf       = 20,
      rdf       = 15,
      fat       = -14
    },
    sipar_shield = {
      condition = 60,
      mdf       = 18,
      rdf       = 18,
      fat       = -18
    }
  }
};

//if (::mods_getRegisteredMod("tnf_oldNorseHelmet")) gt.tnf_debug.itemStats.helmets <- norse_old = {condition = 180, fat = -10};

//************************//
//  AWFUL UGLY FUNCTIONS  //
//************************//

gt.tnf_debug.logSeedFertility <- function() {
//// ROSTER ////
  local rosterLog = "";
  foreach (character in this.World.getPlayerRoster().getAll()) {
    local attributesValuesMin = gt.tnf_debug.getAttributesValues(character, false, false); //current values
    local attributesValuesMax = gt.tnf_debug.getAttributesValues(character, true, false); //current + level up values

    rosterLog += "> ";
    foreach (attribute, index in gt.Const.Attributes) {
      if (index == 8) continue;
      rosterLog += gt.tnf_debug.attributeAbbr[attribute] + " [" + attributesValuesMin[attribute] + "-" + attributesValuesMax[attribute] + "]";
      if (index < 7) rosterLog += ", ";
    }

    local traits = character.getSkills().getAllSkillsOfType(this.Const.SkillType.Trait);
    foreach (trait in traits) {
      if (trait.isType(this.Const.SkillType.Background) || trait.isType(this.Const.SkillType.Special)) continue;
      rosterLog += " " + trait.getName() + " +";
    }
    if (traits.len() > 2) rosterLog = rosterLog.slice(0, rosterLog.len() - 2); //trim
    rosterLog += " (" + character.getNameOnly() + ")";
    rosterLog += "\n";
  }
  rosterLog = rosterLog.slice(0, rosterLog.len() - 1); //trim
  this.logDebug("tnf_debugMode | Roster [min-max] attributes values up to veteran level:");
  this.logInfo(rosterLog);

  //// NAMED ITEMS ////
  local itemsNum = 0, weaponsNum = 0, shieldsNum = 0, armorsNum = 0, helmetsNum = 0;
  local weaponsLog = "", shieldsLog = "", armorsLog = "", helmetsLog = "";
  local bonus;

  foreach (location in this.World.EntityManager.getLocations()) {
    if (location.isAlliedWithPlayer()) continue;
    if (!location.getLoot().isEmpty()) {
      foreach (item in location.getLoot().getItems()) {
        if (item.isItemType(this.Const.Items.ItemType.Named)) {
          itemsNum++;
          if (item.m.ID.find("weapon") != null) {
            weaponsNum++;
            local weapon = item.m.ID.slice(gt.tnf_debug.prefixes.named_weapon.len());
            weaponsLog += weaponsNum + "° [" + weapon.slice(0, 1).toupper() + weapon.slice(1) + "]";

            if (item.m.ConditionMax != gt.tnf_debug.itemStats.weapons[weapon].condition && !(weapon == "throwing_axe" || weapon == "javelin")) {
              bonus = 1.0 * item.m.ConditionMax / gt.tnf_debug.itemStats.weapons[weapon].condition;
              bonus = format("%.2f", bonus);
              weaponsLog += " durability (x" + bonus + "),";
            }
            if (item.m.RegularDamage + item.m.RegularDamageMax != gt.tnf_debug.itemStats.weapons[weapon].regular) {
              bonus = 1.0 * (item.m.RegularDamage + item.m.RegularDamageMax) / gt.tnf_debug.itemStats.weapons[weapon].regular;
              bonus = format("%.2f", bonus);
              weaponsLog += " damage (x" + bonus + "),";
            }
            if (item.m.DirectDamageAdd != 0 || (weapon in gt.tnf_debug.DDAWeapons && item.m.DirectDamageAdd != 0.1)) {
              if (!(weapon in gt.tnf_debug.DDAWeapons && item.m.DirectDamageAdd == 0.1)) {
                bonus = weapon in gt.tnf_debug.DDAWeapons ? (item.m.DirectDamageAdd - 0.1) * 100 : item.m.DirectDamageAdd * 100;
                weaponsLog += " damage ignoring armor (+" + bonus + "%),";
             }
            }
            if (item.m.ArmorDamageMult != gt.tnf_debug.itemStats.weapons[weapon].armor) {
              bonus = 100 * (item.m.ArmorDamageMult - gt.tnf_debug.itemStats.weapons[weapon].armor);
              weaponsLog += " armor damage (+" + bonus + "%),";
            }
            if (item.m.ShieldDamage != gt.tnf_debug.itemStats.weapons[weapon].shield) {
              bonus = 1.0 * item.m.ShieldDamage / gt.tnf_debug.itemStats.weapons[weapon].shield;
              bonus = format("%.2f", bonus);
              weaponsLog += " shield damage (x" + bonus + "),";
            }
            if (item.m.ChanceToHitHead != gt.tnf_debug.itemStats.weapons[weapon].head) {
              bonus = item.m.ChanceToHitHead - gt.tnf_debug.itemStats.weapons[weapon].head;
              weaponsLog += " critical hit chance (+" + bonus + "%),";
            }
            if (item.m.StaminaModifier != gt.tnf_debug.itemStats.weapons[weapon].fat) {
              bonus = 1.0 * item.m.StaminaModifier / gt.tnf_debug.itemStats.weapons[weapon].fat;
              bonus = format("%.2f", bonus);
              weaponsLog += " Fatigue (x" + bonus + "),";
            }
            if (item.m.FatigueOnSkillUse != 0) {
              if (!((weapon == "orc_axe" || weapon == "orc_cleaver") && item.m.FatigueOnSkillUse == 5))
                weaponsLog += " skill cost (" + item.m.FatigueOnSkillUse + "),";
            }
            if (item.m.AdditionalAccuracy != 0) {
              weaponsLog += " hit chance (+" + item.m.AdditionalAccuracy + "%),";
            }
            if (item.m.AmmoMax > 5) {
              weaponsLog += " ammo (+" + item.m.AmmoMax + "),";
            }
            weaponsLog = weaponsLog.slice(0, weaponsLog.len() - 1);
            weaponsLog += "\n";
          } //weapons

          else if (item.m.ID.find("body") != null) {
            armorsNum++;
            local armor = item.m.ID.slice(gt.tnf_debug.prefixes.named_armor.len());
            armorsLog += armorsNum + "° [" + armor.slice(0, 1).toupper() + armor.slice(1) + "] ";
            bonus = 1.0 * item.m.ConditionMax / gt.tnf_debug.itemStats.armors[armor].condition;
            bonus = format("%.2f", bonus);
            armorsLog += item.m.ConditionMax + " Durability (x" + bonus + "), ";
            bonus = item.m.StaminaModifier - gt.tnf_debug.itemStats.armors[armor].fat;
            armorsLog += item.m.StaminaModifier + " Fatigue (+" + bonus + ")";
            armorsLog += "\n";
          } //armors

          else if (item.m.ID.find("head") != null) {
            helmetsNum++;
            local helmet = item.m.ID.slice(gt.tnf_debug.prefixes.named_helmet.len());
            helmetsLog += helmetsNum + "° [" + helmet.slice(0, 1).toupper() + helmet.slice(1) + "] ";
            bonus = 1.0 * item.m.ConditionMax / gt.tnf_debug.itemStats.helmets[helmet].condition;
            bonus = format("%.2f", bonus);
            helmetsLog += item.m.ConditionMax + " Durability (x" + bonus + "), ";
            bonus = item.m.StaminaModifier - gt.tnf_debug.itemStats.helmets[helmet].fat;
            helmetsLog += item.m.StaminaModifier + " Fatigue (+" + bonus + ")";
            helmetsLog += "\n";
          } //helmets

          else if (item.m.ID.find("shield") != null) {
            shieldsNum++;
            local shield = item.m.ID.slice(gt.tnf_debug.prefixes.named_shield.len());
            shieldsLog += shieldsNum + "° [" + shield.slice(0, 1).toupper() + shield.slice(1) + "] ";
            if (item.m.ConditionMax != gt.tnf_debug.itemStats.shields[shield].condition) {
              bonus = 1.0 * item.m.ConditionMax / gt.tnf_debug.itemStats.shields[shield].condition;
              bonus = format("%.2f", bonus);
              shieldsLog += " durability (x" + bonus + "),";
            }
            if (item.m.MeleeDefense != gt.tnf_debug.itemStats.shields[shield].mdf) {
              bonus = 1.0 * item.m.MeleeDefense / gt.tnf_debug.itemStats.shields[shield].mdf;
              bonus = format("%.2f", bonus);
              shieldsLog += " " + item.m.MeleeDefense + " melee defense (x" + bonus + "),";
            }
            if (item.m.RangedDefense != gt.tnf_debug.itemStats.shields[shield].rdf) {
              bonus = 1.0 * item.m.RangedDefense / gt.tnf_debug.itemStats.shields[shield].rdf;
              bonus = format("%.2f", bonus);
              shieldsLog += " " + item.m.RangedDefense + " ranged defense (x" + bonus + "),";
            }
            if (item.m.StaminaModifier != gt.tnf_debug.itemStats.shields[shield].fat) {
              bonus = 1.0 * item.m.StaminaModifier / gt.tnf_debug.itemStats.shields[shield].fat;
              bonus = format("%.2f", bonus);
              shieldsLog += " Fatigue (x" + bonus + "),";
            }
            if (item.m.FatigueOnSkillUse != 0 || (shield == "orc_heavy_shield" && item.m.FatigueOnSkillUse != 5)) {
              shieldsLog += " skill cost (" + item.m.FatigueOnSkillUse + "),";
            }
            shieldsLog = shieldsLog.slice(0, shieldsLog.len() - 1);
            shieldsLog += "\n";
          } //shields
        } //named
      } //items
    }
  } //locations

  this.logDebug("tnf_debugMode | Found (" + itemsNum + ") named items!");
  if (weaponsNum > 0) {
    this.logDebug("Weapons (" + weaponsNum + "):");
    weaponsLog = weaponsLog.slice(0, weaponsLog.len() - 1); //trim nl
    this.logInfo(weaponsLog);
  }
  if (armorsNum > 0) {
    this.logDebug("Armors (" + armorsNum + "):");
    armorsLog = armorsLog.slice(0, armorsLog.len() - 1); //trim nl
    this.logInfo(armorsLog);
  }
  if (helmetsNum > 0) {
    this.logDebug("Helmets (" + helmetsNum + "):");
    helmetsLog = helmetsLog.slice(0, helmetsLog.len() - 1); //trim nl
    this.logInfo(helmetsLog);
  }
  if (shieldsNum > 0) {
    this.logDebug("Shields (" + shieldsNum + "):");
    shieldsLog = shieldsLog.slice(0, shieldsLog.len() - 1); //trim nl
    this.logInfo(shieldsLog);
  }
};
