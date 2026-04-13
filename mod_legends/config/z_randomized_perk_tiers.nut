::Const.PerkPurchasePower <- {
    VeryLow = 2,
    Low = 4,
    Medium = 5,
    High = 7,
    VeryHigh = 9,
    ExtraHigh = 11
};

// Explanations of each of these is in the randomized_unit_abstract file
::Const.RandomizedCharacterInfo <- {}
::Const.RandomizedCharacterInfo["Default"] <- {
    Outfits = [
        [1, ::Legends.Outfit.low_tier_unit_catchall_outfit_01]
    ],
    ClassPerkList = [],
    DefensePerkList = [
        ::Const.Perks.HeavyArmorTree,
        ::Const.Perks.MediumArmorTree,
        ::Const.Perks.LightArmorTree,
        // ::Const.Perks.ClothArmorTree
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.MartyrTree,
        ::Const.Perks.ViciousTree,
        // ::Const.Perks.DeviousTree,
        // ::Const.Perks.InspirationalTree,
        // ::Const.Perks.IntelligentTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.OrganisedTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree
    ],
    GuaranteedPerks = [],
    LegendaryPerks = [],
	LegendaryTraits = [],
    WeaponsAndTrees = [
        ["knife",  100, 75] // [Weapon Script, Chance to roll weapon-perks, chacne to roll weapon-class-perks]
    ],
    LevelRange = [3, 3],
    PerkPower = ::Const.PerkPurchasePower.Low
}
::Const.RandomizedCharacterInfo[::Const.EntityType.Peasant] <- {
    Outfits = [
        [1, ::Legends.Outfit.peasant_outfit_00]
    ],
    WeaponsAndTrees = [
        [2, ["knife",  100, 80]],
        [2, ["pitchfork", 100, 60]],
        [2, ["wooden_stick", 100, 65]],
        [1, ["pickaxe", 100, 45]],
        [2, ["legend_hammer", 100, 60]],
        [2, ["legend_sickle", 100, 80]],
        [2, ["legend_wooden_pitchfork", 100, 65]],
        [2, ["legend_scythe", 100, 75]],
        [2, ["legend_hoe", 100]],
        [2, ["legend_shiv",  100, 75]],
        [2, ["legend_shovel", 100, 80]],
        [2, ["legend_staff", 100]],
        [1, ["butchers_cleaver", 100, 45]],
        [2, ["legend_wooden_spear", 100, 80]]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.OrganisedTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree
    ],
    LegendaryPerks = [
		::Legends.Perk.Nimble
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [1, 3]
    PerkPower = ::Const.PerkPurchasePower.VeryLow
}
::Const.RandomizedCharacterInfo[::Const.EntityType.CaravanHand] <- {
    Outfits = [
        [1, ::Legends.Outfit.caravan_hand_outfit_00]
    ],
    WeaponsAndTrees = [
        [1, ["dagger", 100, 75]],
        [1, ["knife",  100, 75]],
        [1, ["wooden_stick", 100, 75]],
        [2, ["hatchet", 100]],
        [2, ["bludgeon", 100]],
        [3, ["militia_spear", 100, 75]],
        [1, ["scramasax", 100]],
        [2, ["shortsword", 100]],
        [2, ["legend_militia_glaive", 100]]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.OrganisedTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree
    ],
    Shields = [
        [1, "buckler_shield"],
        [2, ""]
    ],
    GuaranteedPerks = [
		::Legends.Perk.Recover
    ],
    LegendaryPerks = [
		::Legends.Perk.ShieldBash,
		::Legends.Perk.Pathfinder,
		::Legends.Perk.Underdog,
		::Legends.Perk.LegendAlert,
		::Legends.Perk.CripplingStrikes
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [3, 5],
    PerkPower = ::Const.PerkPurchasePower.Low
}
::Const.RandomizedCharacterInfo[::Const.EntityType.CaravanGuard] <- {
    Outfits = [
        [1, ::Legends.Outfit.caravan_guard_outfit_00]
    ],
     DefensePerkList = [
        ::Const.Perks.HeavyArmorTree,
        ::Const.Perks.MediumArmorTree,
        ::Const.Perks.LightArmorTree,
        ::Const.Perks.ClothArmorTree
    ],
    WeaponsAndTrees = [
        [1, ["hand_axe", 100]],
        [1, ["boar_spear", 100]],
        [2, ["falchion", 100]],
        [2, ["shortsword", 100]],
        [1, ["arming_sword", 100]]
    ],
    GuaranteedPerks = [
		::Legends.Perk.Recover,
		::Legends.Perk.ShieldExpert
    ],
    LegendaryPerks = [
		::Legends.Perk.LegendSpecialistShieldSkill,
		::Legends.Perk.LegendSpecialistShieldPush,
		::Legends.Perk.ShieldBash,
		::Legends.Perk.HoldOut,
		::Legends.Perk.Underdog,
		::Legends.Perk.Rotation,
		::Legends.Perk.LegendAlert,
		::Legends.Perk.CripplingStrikes
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    Shields = [
        [1, "wooden_shield"]
    ],
    LevelRange = [4, 7],
    PerkPower = ::Const.PerkPurchasePower.Medium
}
::Const.RandomizedCharacterInfo[::Const.EntityType.BanditRabble] <- {
    Outfits = [
        [1, ::Legends.Outfit.bandit_rabble_outfit_00]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.ShadyTree
    ],
    WeaponsAndTrees = [
        [1, ["legend_wooden_pitchfork", 35], [::Legends.Perk.CoupDeGrace, ::Legends.Perk.LegendSpecialistFarmhand]],
        [1, ["legend_wooden_spear", 35], [::Legends.Perk.LegendSpecialistMilitia]],
        [1, ["legend_sickle", 35], [::Legends.Perk.LegendSpecialistHerbalist]],
        [1, ["legend_staff", 35], [::Legends.Perk.LegendSpecialistSelfdefense, ::Legends.Perk.LegendSpecStaffStun, ::Legends.Perk.FortifiedMind]],
        [1, ["legend_shovel", 35], [::Legends.Perk.LegendSpecialistGravedigger]],
        [1, ["wooden_stick", 35], [::Legends.Perk.LegendOnslaught, ::Legends.Perk.Overwhelm, ::Legends.Perk.Colossus, ::Legends.Perk.Recover, ::Legends.Perk.LegendRebound]],
        [1, ["legend_hammer", 35], [::Legends.Perk.LegendSpecialistBlacksmith, ::Legends.Perk.Colossus]],
        [1, ["legend_shiv",  35], [::Legends.Perk.LegendSpecialistPrisoner, ::Legends.Perk.Duelist]],
        [1, ["lute", 35], [::Legends.Perk.LegendSpecialistMusician, ::Legends.Perk.LegendMindOverBody, ::Legends.Perk.Recover]],
        [1, ["butchers_cleaver", 35], [::Legends.Perk.LegendBloodbath, ::Legends.Perk.LegendSpecialistButcher]],
        [1, ["legend_saw", 35], [::Legends.Perk.LegendSmashingShields, ::Legends.Perk.LegendSpecialistWoodsman]],
        [1, ["legend_hoe", 35], [::Legends.Perk.LegendSmackdown, ::Legends.Perk.LegendSpecialistFarmhand]],
        [1, ["wooden_flail", 35], [::Legends.Perk.HeadHunter, ::Legends.Perk.BattleFlow, ::Legends.Perk.LegendSpecialistFarmhand]]
    ],
    Shields = [
        [1, "buckler_shield"],
        [14, ""]
    ],
    LegendaryPerks = [
		::Legends.Perk.Dodge,
		::Legends.Perk.Backstabber
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [1, 3],
    PerkPower = ::Const.PerkPurchasePower.VeryLow
}
::Const.RandomizedCharacterInfo[::Const.EntityType.BanditRabblePoacher] <- {
    Outfits = [
        [1, ::Legends.Outfit.bandit_rabble_poacher_outfit_00]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree,
        ::Const.Perks.BowTree
    ],
    WeaponsAndTrees = [
        [1, ["wonky_bow", 50]],
        [2, ["legend_dilapitated_sling", 50]],
        [1, ["legend_slingshot", 50]],
    ],
    LegendaryPerks = [
		::Legends.Perk.Dodge,
		::Legends.Perk.Backstabber
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless,
		::Legends.Trait.Determined
	],
    LevelRange = [1, 3],
    PerkPower = ::Const.PerkPurchasePower.VeryLow
}
::Const.RandomizedCharacterInfo[::Const.EntityType.BanditThug] <- {
    Outfits = [
        [1, ::Legends.Outfit.bandit_thug_outfit_00]
    ],
    WeaponsAndTrees = [
        [1, ["woodcutters_axe", 70], [::Legends.Perk.LegendSmashingShields]],
        [1, ["goedendag", 70], [::Legends.Perk.LegendOnslaught]],
        [1, ["pitchfork", 70], [::Legends.Perk.CoupDeGrace]],
        [3, ["shortsword", 70], [::Legends.Perk.Duelist]],
        [3, ["hatchet", 70], [::Legends.Perk.LegendSmashingShields]],
        [3, ["bludgeon", 70], [::Legends.Perk.LegendOnslaught]],
        [3, ["militia_spear", 70], [::Legends.Perk.Overwhelm]],
        [3, ["pickaxe", 70], [::Legends.Perk.LegendSmackdown]],
        [3, ["reinforced_wooden_flail", 70], [::Legends.Perk.HeadHunter]],
        [3, ["wooden_flail", 70], [::Legends.Perk.HeadHunter]],
        [3, ["butchers_cleaver", 70], [::Legends.Perk.LegendBloodbath]],
        [3, ["dagger",  70], [::Legends.Perk.Duelist]],
        [3, ["legend_scythe", 70], [::Legends.Perk.CoupDeGrace]],
        [3, ["legend_tipstaff", 70], [::Legends.Perk.LegendReturnFavor]],
        [3, ["legend_militia_glaive", 70], [::Legends.Perk.KillingFrenzy]],
        [3, ["legend_tipstaff", 70], [::Legends.Perk.KillingFrenzy]],
        [3, ["legend_ranged_wooden_flail", 70], [::Legends.Perk.KillingFrenzy]]
    ],
    Shields = [
        [1, "wooden_shield"],
        [1, "buckler_shield"],
        [6, ""]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.ViciousTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree,
        ::Const.Perks.ShadyTree
    ],
    LegendaryPerks = [
		::Legends.Perk.Relentless,
		::Legends.Perk.Dodge,
		::Legends.Perk.Backstabber,
		::Legends.Perk.Underdog
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [2, 4],
    PerkPower = ::Const.PerkPurchasePower.Low
}
::Const.RandomizedCharacterInfo[::Const.EntityType.BanditPoacher] <- {
    Outfits = [
        [1, ::Legends.Outfit.bandit_poacher_outfit_00]
    ],
    WeaponsAndTrees = [
        [3, ["wonky_bow", 65]],
        [1, ["short_bow", 65]],
        [1, ["legend_sturdy_sling", 65]],
        [1, ["legend_slingshot", 65]],
        [1, ["short_bow", 65]],
        [3, ["legend_dilapitated_sling", 65]]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree,
        ::Const.Perks.BowTree
    ],
    LegendaryPerks = [
		::Legends.Perk.Dodge,
		::Legends.Perk.Backstabber
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [2, 4],
    GuaranteedPerks = [
		::Legends.Perk.Rotation,
		::Legends.Perk.Recover
    ],
    PerkPower = ::Const.PerkPurchasePower.Low
}
::Const.RandomizedCharacterInfo[::Const.EntityType.BanditRaider] <- {
    Outfits = [
        [1, ::Legends.Outfit.dark_southern_outfit_00],
        [19, ::Legends.Outfit.bandit_raider_outfit_00]
    ],
     DefensePerkList = [
        ::Const.Perks.HeavyArmorTree,
        ::Const.Perks.MediumArmorTree,
        ::Const.Perks.LightArmorTree,
    ],
    WeaponsAndTrees = [ // Author's Note: These are a substantially higher chance to purchase 2handers than current raiders, because of this (eventually) these will get weighted
        [1, ["legend_infantry_axe", 70], [::Legends.Perk.LegendSmashingShields]],
        [1, ["hooked_blade", 70], [::Legends.Perk.CripplingStrikes]],
        [1, ["pike", 70], [::Legends.Perk.ReachAdvantage]],
        [1, ["warbrand", 70], [::Legends.Perk.LegendBloodyHarvest]],
        [1, ["longaxe", 70], [::Legends.Perk.KillingFrenzy]],
        [1, ["two_handed_wooden_hammer", 70], [::Legends.Perk.LegendSmackdown]],
        [1, ["two_handed_wooden_flail", 70], [::Legends.Perk.HeadHunter]],
        [1, ["legend_ranged_flail", 70], [::Legends.Perk.Colossus]],
        [1, ["legend_reinforced_flail", 70], [::Legends.Perk.LegendVengeance]],
        [1, ["two_handed_mace", 70], [::Legends.Perk.LegendForcefulSwing]],
        [1, ["greatsword", 70], [::Legends.Perk.Colossus]],
        [1, ["longsword",  70], [::Legends.Perk.Duelist]],
        [1, ["legend_two_handed_club", 70], [::Legends.Perk.LegendSmashingShields]],
        [5, ["shortsword", 70, 30], [::Legends.Perk.Overwhelm]],
        [5, ["hand_axe", 70], [::Legends.Perk.LegendOnslaught]],
        [5, ["boar_spear", 70], [::Legends.Perk.Duelist]],
        [5, ["morning_star", 70], [::Legends.Perk.LegendFeint]],
        [5, ["falchion", 70], [::Legends.Perk.LegendFeint]],
        [5, ["arming_sword", 70], [::Legends.Perk.LegendBloodbath]],
        [5, ["flail", 70], [::Legends.Perk.HeadHunter]],
        [5, ["scramasax", 70], [::Legends.Perk.KillingFrenzy]],
        [5, ["military_pick", 70], [::Legends.Perk.LegendSmackdown]]
    ],
    Shields = [
        [3, ""],
        [4, "wooden_shield"],
        [2, "kite_shield"]
    ]
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.MartyrTree,
        ::Const.Perks.ViciousTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree,
        ::Const.Perks.ShadyTree
    ],
    LegendaryPerks = [
		::Legends.Perk.Relentless,
		::Legends.Perk.Dodge,
		::Legends.Perk.Backstabber,
		::Legends.Perk.Underdog
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    GuaranteedPerks = [
		::Legends.Perk.Bullseye,
		::Legends.Perk.Rotation,
		::Legends.Perk.Recover
    ],
    LevelRange = [3, 4],
    PerkPower = ::Const.PerkPurchasePower.Low
}

// Should look at how to normalize this for low-tier units?
::Const.RandomizedCharacterInfo["BanditRaiderLow"] <- {
    Outfits = [
        [1, ::Legends.Outfit.bandit_raider_low_outfit_00]
    ],
    WeaponsAndTrees = [
        [1, ["woodcutters_axe", 70]],
        [1, ["hooked_blade", 70]],
        [1, ["pike", 70]],
        [1, ["two_handed_wooden_hammer", 70]],
        [1, ["shortsword", 70]],
        [1, ["hand_axe", 70]],
        [1, ["boar_spear", 70]],
        [1, ["morning_star", 70]],
        [1, ["falchion", 70]],
        [1, ["flail", 70]]
    ],
    Shields = [
        [1, ""],
        [2, "buckler_shield"],
        [1, "wooden_shield"]
    ]
}

::Const.RandomizedCharacterInfo[::Const.EntityType.LegendCaravanPolearm] <- {
    Outfits = [
        [1, ::Legends.Outfit.legend_caravan_polearm_outfit_00]
    ],
    WeaponsAndTrees = [
        [5, ["legend_ranged_wooden_flail", 75, 35]],
        [5, ["legend_staff", 75, 65]],
        [4, ["legend_tipstaff", 75, 65]],
        [5, ["pitchfork", 50, 35]],
        [1, ["warfork", 50, 0]]
    ],
    TraitsPerkList = [
        ::Const.Perks.AgileTree,
        ::Const.Perks.CalmTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.OrganisedTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree
    ],
    DefensePerkList = [
        ::Const.Perks.LightArmorTree,
        ::Const.Perks.MediumArmorTree
    ],
    GuaranteedPerks = [
		::Legends.Perk.BagsAndBelts
    ],
    LegendaryPerks = [
		::Legends.Perk.Pathfinder,
		::Legends.Perk.CripplingStrikes,
		::Legends.Perk.Overwhelm
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [3, 4],
    PerkPower = ::Const.PerkPurchasePower.Low
}

::Const.RandomizedCharacterInfo[::Const.EntityType.NobleEliteFootman] <- {
    Outfits = [
        [1, ::Legends.Outfit.noble_elite_footman_outfit_00] //todo
    ],
    WeaponsAndTrees = [
        [4, ["military_pick", 100]],
        [1, ["warhammer",  100]],
        [4, ["arming_sword", 100]],
        [1, ["noble_sword", 100]],
        [3, ["morning_star", 100]],
        [3, ["winged_mace", 100]]
    ],
    DefensePerkList = [
        ::Const.Perks.HeavyArmorTree,
        ::Const.Perks.ForcefulTree
    ],
    TraitsPerkList = [
        ::Const.Perks.SparringTree,
        ::Const.Perks.GiantTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.TrainedTree
    ],
    Shields = [
        [1, "faction_kite_shield"],
        [1, "faction_heater_shield"]
    ],
    GuaranteedPerks = [
		::Legends.Perk.ShieldExpert,
		::Legends.Perk.Rotation
    ],
    LegendaryPerks = [
		::Legends.Perk.ShieldBash,
		::Legends.Perk.CripplingStrikes
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [6, 8], //At super high levels it stops mattering for what they can buy and just gives more exp
    PerkPower = ::Const.PerkPurchasePower.High + 1
}

::Const.RandomizedCharacterInfo[::Const.EntityType.NoblePollax] <- {
    Outfits = [
        [1, ::Legends.Outfit.mercury_pollax_00], //Looking @ around 200 each at most ideally
        [1, ::Legends.Outfit.mercury_pollax_colorful]
    ],
    WeaponsAndTrees = [
        [1, ["polehammer", 100]],
        [2, ["legend_halberd",  100]],
        [2, ["legend_battle_glaive", 100]],
        [2, ["longaxe", 100]]
    ],
    DefensePerkList = [
        ::Const.Perks.HeavyArmorTree,
        ::Const.Perks.ForcefulTree
    ],
    TraitsPerkList = [
        ::Const.Perks.GiantTree,
        ::Const.Perks.AggressiveTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.FastTree,
        ::Const.Perks.TrainedTree
    ],
    GuaranteedPerks = [ //Testing to see if they ever actually use indom, given no guaranteed perks right now these might vary wildly in power levels
		::Legends.Perk.Indomitable
    ],
    LegendaryPerks = [
		::Legends.Perk.CripplingStrikes,
		::Legends.Perk.Berserk
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [6, 9],
    PerkPower = ::Const.PerkPurchasePower.High + 1
}
::Const.RandomizedCharacterInfo[::Const.EntityType.NobleSureshot] <- {
    Outfits = [
        [1, ::Legends.Outfit.mercury_sureshot_00], // looking for low helmets maybe 150ish body
        [1, ::Legends.Outfit.mercury_sureshot_brown_00],
        [1, ::Legends.Outfit.mercury_sureshot_blue_00],
        [1, ::Legends.Outfit.mercury_sureshot_green_00]
    ],
    WeaponsAndTrees = [
        [3, ["war_bow", 100]],
        [2, ["heavy_crossbow",  100]]
    ],
    DefensePerkList = [
        ::Const.Perks.LightArmorTree
    ],
    TraitsPerkList = [
        ::Const.Perks.FastTree,
        ::Const.Perks.FitTree,
        ::Const.Perks.BowTree,
        ::Const.Perks.CrossbowTree,
        ::Const.Perks.RangerTree,
        ::Const.Perks.TrainedTree
    ],
    GuaranteedPerks = [
		::Legends.Perk.LegendBallistics,
		::Legends.Perk.LegendLookout,
		::Legends.Perk.Rotation
    ],
    LegendaryPerks = [
		::Legends.Perk.CripplingStrikes,
		::Legends.Perk.LegendClarity,
		::Legends.Perk.LegendSmackdown
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [6, 8],
    PerkPower = ::Const.PerkPurchasePower.High
}

::Const.RandomizedCharacterInfo[::Const.EntityType.LegendNobleGuard] <- {
    Outfits = [
        [1, ::Legends.Outfit.noble_footman_veteran_00] //todo
    ],
    WeaponsAndTrees = [
        [4, ["military_pick", 100]],
        [1, ["arming_sword",  100]],
        [4, ["fighting_axe", 100]],
        [1, ["morning_star", 100]]
    ],
    DefensePerkList = [
        ::Const.Perks.HeavyArmorTree,
        ::Const.Perks.ForcefulTree
    ],
    TraitsPerkList = [
        ::Const.Perks.SparringTree,
        ::Const.Perks.GiantTree,
        ::Const.Perks.IndestructibleTree,
        ::Const.Perks.LargeTree,
        ::Const.Perks.SturdyTree,
        ::Const.Perks.FitTree
    ],
    Shields = [
        [1, "legend_faction_tower_shield"]
    ],
    GuaranteedPerks = [
		::Legends.Perk.ShieldExpert,
		::Legends.Perk.BattleForged,
		::Legends.Perk.Rotation,
		::Legends.Perk.SteelBrow,
		::Legends.Perk.LegendSpecialistShieldSkill,
		::Legends.Perk.LegendSpecialistShieldPush,
		::Legends.Perk.ShieldBash
    ],
    LegendaryPerks = [
		::Legends.Perk.LegendDeflect,
		::Legends.Perk.LegendBruiser
    ],
	LegendaryTraits = [
		::Legends.Trait.Fearless
	],
    LevelRange = [7, 10],
    PerkPower = ::Const.PerkPurchasePower.High + 1
}

// Units TODO:
/*
    Bandit Leader
    Bandit Marksman
    Bandit Veteran
    Bandit Warlord
    Master Archer

    Mercenary

    Militia Captain
    Militia Ranged
    Militia Veteran
    Militia

    Nomad Archer
    Nomad Cutthroat
    Nomad Leader
    Nomad Outlaw
    Nomad Slinger
    Slave?

    Noble Arbalester
    Noble Billman
    Noble Footman
    Noble Greatsword
    Noble Man at Arms
    Noble Sergeant
    Knight

    Barbarian Champion
    Barbarian Chosen
    Barbarian Drummer
    Barbarian Madman
    Barbarian Marauder
    Barbarian Thrall

*/






// Randomized Malus is applied when we select a weapon-class-tree, e.g. a Poacher rolls Slinger's Spins, it would then apply the malus to offset some of the bonus
::Const.RandomizedMalus <- {
    Hitpoints = [
        0,
        0
    ],
    Bravery = [
        0,
        0
    ],
    Stamina = [
        0,
        0
    ],
    MeleeSkill = [
        -4,
        -6
    ],
    RangedSkill = [
        -4,
        -7
    ],
    MeleeDefense = [
        0,
        0
    ],
    RangedDefense = [
        0,
        0
    ],
    Initiative = [
        0,
        0
    ]
};

::Const.GetWeaponAndTree <- function ( _array ) {

    local candidates = [];
	local totalWeight = 0;

	foreach (weapon in _array)
	{
		if (weapon[0] == 0)
		{
			continue;
		}
		candidates.push(weapon);
		totalWeight += weapon[0];
	}

    local r = this.Math.rand(0, totalWeight);
    foreach (weapon in candidates)
	{
		r = r - weapon[0];
		if (r > 0)
		{
			continue;
		}
        if (weapon.len() >= 3) //probably will change this later, it should probably be a tree at this point
        {
            return [weapon[1], weapon[2]]
        }
        return [weapon[1]];
    }
}

// Only lower tiered weapons should really get these class trees, might expand this later to just work with any tier of weapon anyways? It"ll look the same as the other function if we do
::Const.GetWeaponClassTree <- function ( _item ) {

    switch(true) {
    //Shovel
        case _item.getID() == "weapon.legend_shovel" || _item.getID() == "weapon.legend_named_shovel":
            return ::Const.Perks.ShovelClassTree;

    //Sickle
        case _item.getID() == "weapon.sickle" || _item.getID() == "weapon.goblin_notched_blade" || _item.getID() == "weapon.legend_named_sickle":
            return ::Const.Perks.SickleClassTree;

    //Wood Axe
        case _item.getID() == "weapon.woodcutters_axe" || _item.getID() == "weapon.legend_saw":
            return ::Const.Perks.WoodaxeClassTree;

    //Blacksmith
        case _item.getID() == "weapon.legend_hammer" || _item.getID() == "weapon.legend_named_blacksmith_hammer":
            return ::Const.Perks.HammerClassTree;

    //Pickaxe
        case _item.getID() == "weapon.pickaxe" || _item.getID() == "weapon.heavy_mining_pick":
            return ::Const.Perks.PickaxeClassTree;

    //Butcher
        case _item.getID() == "weapon.butchers_cleaver" || _item.getID() == "weapon.legend_named_butchers_cleaver":
            return ::Const.Perks.ButcherClassTree;

    //Ninetails
        case _item.getID() == "weapon.legend_cat_o_nine_tails":
            return ::Const.Perks.NinetailsClassTree;

    //Knife
        case _item.getID() == "weapon.knife" || _item.getID() == "weapon.legend_shiv":
            return ::Const.Perks.KnifeClassTree;

    //Inventor
        case _item.isWeaponType(this.Const.Items.WeaponType.Firearm):
            return ::Const.Perks.InventorClassTree;

    //Bodyguard
        case _item.getID() == "weapon.greatsword" || _item.getID() == "weapon.longsword":
            return ::Const.Perks.LongswordClassTree;

    //Slings
        case _item.getID() == "weapon.legend_dilapitated_sling" || _item.getID() == "weapon.legend_sturdy_sling" || _item.getID() == "weapon.legend_slingshot":
            return ::Const.Perks.SlingClassTree;

    //Staves
        case _item.getID() == "weapon.legend_staff":
            return ::Const.Perks.StaffClassTree;

    //Inquisition
        case _item.getID() == "weapon.legend_wooden_stake":
            return ::Const.Perks.InquisitionClassTree;

    //Club
        case _item.getID() == "weapon.wooden_stick":
            return ::Const.Perks.ClubClassTree;

    //Pitchfork
        case _item.isItemType(this.Const.Items.ItemType.Pitchfork):
            return ::Const.Perks.PitchforkClassTree;

    //Shortbow
        case _item.isItemType(this.Const.Items.ItemType.Shortbow):
            return ::Const.Perks.ShortbowClassTree;

    //Militia
        case _item.getID() == "weapon.militia_spear" || _item.getID() == "weapon.legend_wooden_spear" || _item.getID() == "weapon.ancient_spear":
            return ::Const.Perks.MilitiaClassTree;
    }

    return null;
}

// Greatswords are special in that they're the only 2-Handed weapon that also isn't it's own weapon type (I guess like contrary to Staves, but Staves have no 1-Handed equivalent)
// Otherwise, we just return the actual weapon tree(s) applicable, sometimes a weapon is multiple so it returns both
::Const.GetWeaponPerkTree <- function ( _item ) {
    // WeaponTypes
    local ret = []; // Push all applicable WeaponTypes into array (supports Hybrid weapons)
    local weaponToPerkMap = {
        Axe = ::Const.Perks.AxeTree,
        Bow = ::Const.Perks.BowTree,
        Cleaver = ::Const.Perks.CleaverTree,
        Crossbow = ::Const.Perks.CrossbowTree,
        Dagger = ::Const.Perks.DaggerTree,
        Firearm = ::Const.Perks.CrossbowTree,
        Flail = ::Const.Perks.FlailTree,
        Hammer = ::Const.Perks.HammerTree,
        Mace = ::Const.Perks.MaceTree,
        Polearm = ::Const.Perks.PolearmTree,
        Staff = ::Const.Perks.PolearmTree,
        Sling = ::Const.Perks.SlingTree,
        Spear = ::Const.Perks.SpearTree,
        Sword = ::Const.Perks.SwordTree,
        Throwing = ::Const.Perks.ThrowingTree,
        Musical = ::Const.Perks.BardMagicTree
    }
    foreach (weapon, tree in weaponToPerkMap)
    {
        if (_item.isWeaponType(this.Const.Items.WeaponType[weapon])) ret.push(tree);
    }
    return ret;

}
