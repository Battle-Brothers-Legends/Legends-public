if (!("Blueprints" in ::Legends)) {
    ::Legends.Blueprints <- {};
}

::Legends.Blueprints.BlueprintDefObjects <- {};
::Legends.Blueprints.BlueprintDefs <- {};
::Legends.Blueprints.LookupMap <- {};

::Legends.Blueprints.defaultDef <- function (_def) {
    local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
    return {
        Const = _def.Const,
        ID = ::format("blueprint.%s", snakeCase),
        Script = ::format("scripts/crafting/blueprints/%s_blueprint", snakeCase),
        BlueprintType = "Crafting",
        ItemScript = "",
        Ingredients = [],
        Cost = 0,
        Category = 0,
        ProfessionRequired = false,
        AlternativeRequirements = [],
        RequireAll = false,
        Crafts = 1
    }
}

::Legends.Blueprints.transformDef <- function (_def) {
    local defaultDef = ::Legends.Blueprints.defaultDef(_def);
    foreach (key, value in _def) {
        if (key in defaultDef) {
            defaultDef[key] = value; // overwrite
        } else {
            // here's weird situation, we have a slot that was not defined in default, which most likely means bug
            defaultDef[key] <- value;
            ::logWarning(::format("blueprint '%s' defines unknown field '%s' in blueprints_defs", defaultDef.ID, key));
        }
    }
    if (defaultDef.BlueprintType != "Crafting") {
        local constBlueprintType = ::Legends.DefsHelpers.convertToSnakeCase(defaultDef.BlueprintType);
        local constSnakeCase = ::Legends.DefsHelpers.convertToSnakeCase(defaultDef.Const);
        defaultDef.Script = ::format("scripts/crafting/blueprints/%s/%s_blueprint", constBlueprintType, constSnakeCase);
    }
    return defaultDef;
};

/**
 * @param _professionDefObjects is an array of profession definitions
 * @param _container is namespace where ids will reside, you can use your own in submods
 */
::Legends.Blueprints.addBlueprintDefObjects <- function (_blueprintDefObjects, _container = null) {
    if (_container == null) {
        _container = ::Legends.Blueprint;
    }
    foreach (constName, def in _blueprintDefObjects) {
        def.Const <- constName;
        def = ::Legends.Blueprints.transformDef(def);
        local hash = ::IO.scriptHashByFilename(def.Script);
        if (hash == null) {
            ::logError(::format("%s: hash is null for '%s'", def.Const, def.Script));
        }
        ::Legends.Blueprints.BlueprintDefObjects[hash] <- def;
        if (def.Const in _container) {
            _container[def.Const] = hash;
        } else {
            _container[def.Const] <- hash;
        }
        ::Legends.Blueprints.BlueprintDefs[def.Const] <- hash;
        ::Legends.Blueprints.LookupMap[def.ID] <- def;
    }
}

::Legends.Blueprint <- {
    AcidFlask = {
        ItemScript = "scripts/items/tools/acid_flask_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/lindwurm_blood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    AdditionalPaddingUpgrade = {
        ItemScript = "scripts/items/legend_armor/armor_upgrades/legend_additional_padding_upgrade",
        Cost = 400,
        Ingredients = [
            {
                Script = "scripts/items/misc/frost_unhold_fur_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    AlpTrophy = {
        ItemScript = "scripts/items/accessory/alp_trophy_item",
        Cost = 300,
        Ingredients = [
            {
                Script = "scripts/items/misc/parched_skin_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/third_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    Antidote = {
        ItemScript = "scripts/items/accessory/antidote_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    BonePlatingsUpgrade = {
        ItemScript = "scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade",
        Cost = 450,
        Ingredients = [
            {
                Script = "scripts/items/misc/lindwurm_bones_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/unhold_bones_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    CatPotion = {
        ItemScript = "scripts/items/accessory/cat_potion_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/adrenaline_gland_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/parched_skin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    DazeBomb = {
        ItemScript = "scripts/items/tools/daze_bomb_item",
        Cost = 70,
        Ingredients = [
            {
                Script = "scripts/items/misc/glistening_scales_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendPetardry,
        ProfessionRequired = true
    },
    DirewolfPeltUpgrade = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_direwolf_pelt_cloak",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    FireBomb = {
        ItemScript = "scripts/items/tools/fire_bomb_item",
        Cost = 100,
        Ingredients = [
            {
                Script = "scripts/items/misc/sulfurous_rocks_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendPetardry,
        ProfessionRequired = true
    },
    GhoulTrophy = {
        ItemScript = "scripts/items/accessory/ghoul_trophy_item",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    HappyPowder = {
        ItemScript = "scripts/items/misc/happy_powder_item",
        Cost = 100,
        Ingredients = [
            {
                Script = "scripts/items/misc/vampire_dust_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/parched_skin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    HeavyWardogArmorUpgrade = {
        ItemScript = "scripts/items/misc/wardog_heavy_armor_upgrade_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/unhold_hide_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    HexenTrophy = {
        ItemScript = "scripts/items/accessory/hexen_trophy_item",
        Cost = 350,
        Ingredients = [
            {
                Script = "scripts/items/misc/witch_hair_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/poisoned_apple_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/mysterious_herbs_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    HyenaFurUpgrade = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_hyena_fur_cloak",
        Cost = 200,
        Ingredients = [
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    IronWillPotion = {
        ItemScript = "scripts/items/accessory/iron_will_potion_item",
        Cost = 200,
        Ingredients = [
            {
                Script = "scripts/items/misc/adrenaline_gland_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    KrakenShield = {
        ItemScript = "scripts/items/shields/special/legend_craftable_kraken_shield",
        Cost = 1100,
        Ingredients = [
            {
                Script = "scripts/items/misc/kraken_horn_plate_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/glowing_resin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LargePowderBag = {
        ItemScript = "scripts/items/ammo/large_powder_bag",
        Cost = 300,
        Ingredients = [
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/serpent_skin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LargeQuiverOfArrows = {
        ItemScript = "scripts/items/ammo/large_quiver_of_arrows",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LargeQuiverOfBolts = {
        ItemScript = "scripts/items/ammo/large_quiver_of_bolts",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LightPaddingUpgrade = {
        ItemScript = "scripts/items/legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade",
        Cost = 450,
        Ingredients = [
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/glowing_resin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LindwurmShield = {
        ItemScript = "scripts/items/shields/named/named_lindwurm_shield",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/misc/lindwurm_scales_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/lindwurm_bones_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LionheartPotion = {
        ItemScript = "scripts/items/accessory/lionheart_potion_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/poison_gland_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/parched_skin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    MiracleDrug = {
        ItemScript = "scripts/items/misc/miracle_drug_item",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/unhold_heart_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/mysterious_herbs_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    NightVisionElixir = {
        ItemScript = "scripts/items/accessory/night_vision_elixir_item",
        Cost = 350,
        Ingredients = [
            {
                Script = "scripts/items/misc/third_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/witch_hair_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    PoisonedOil = {
        ItemScript = "scripts/items/accessory/spider_poison_item",
        Cost = 75,
        Ingredients = [
            {
                Script = "scripts/items/misc/poison_gland_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    PotionOfKnowledge = {
        ItemScript = "scripts/items/misc/potion_of_knowledge_item",
        Cost = 300,
        Ingredients = [
            {
                Script = "scripts/items/misc/poisoned_apple_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/third_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/heart_of_the_forest_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    PotionOfOblivion = {
        ItemScript = "scripts/items/misc/potion_of_oblivion_item",
        Cost = 5000,
        Ingredients = [
            {
                Script = "scripts/items/misc/poisoned_apple_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/unhold_heart_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/poison_gland_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/heart_of_the_forest_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/kraken_tentacle_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    ProtectiveRunesUpgrade = {
        ItemScript = "scripts/items/legend_armor/armor_upgrades/legend_protective_runes_upgrade",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/misc/vampire_dust_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/parched_skin_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/witch_hair_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    RecoveryPotion = {
        ItemScript = "scripts/items/accessory/recovery_potion_item",
        Cost = 200,
        Ingredients = [
            {
                Script = "scripts/items/misc/adrenaline_gland_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/mysterious_herbs_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    ReinforcedThrowingNet = {
        ItemScript = "scripts/items/tools/reinforced_throwing_net",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/tools/throwing_net",
                Num = 1
            },
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    SchratShield = {
        ItemScript = "scripts/items/shields/special/legend_craftable_schrat_shield",
        Cost = 650,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/glowing_resin_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    SmokeBomb = {
        ItemScript = "scripts/items/tools/smoke_bomb_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/acidic_saliva_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendPetardry,
        ProfessionRequired = true
    },
    SnakeOil01 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/serpent_skin_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil02 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/poison_gland_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/glistening_scales_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil03 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/adrenaline_gland_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil04 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/acidic_saliva_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil05 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/glistening_scales_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil06 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/serpent_skin_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/acidic_saliva_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil07 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/third_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil08 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/third_eye_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/poison_gland_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil09 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/adrenaline_gland_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil10 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/ghoul_teeth_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil11 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/poison_gland_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil12 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/serpent_skin_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/glistening_scales_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil13 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/adrenaline_gland_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    SnakeOil14 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/acidic_saliva_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    WardogArmorUpgrade = {
        ItemScript = "scripts/items/misc/wardog_armor_upgrade_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendAntidote = {
        ItemScript = "scripts/items/accessory/antidote_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendBandage = {
        ItemScript = "scripts/items/accessory/bandage_item",
        Cost = 10,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true,
        Crafts = 2
    },
    LegendBandageTunic = {
        ItemScript = "scripts/items/accessory/bandage_item",
        Cost = 10,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 1
            },
            {
                Script = "scripts/items/legend_armor/cloth/legend_armor_tunic",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendBasiliskCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_basilisk_cloak",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_basilisk_feathers_item",
                Num = 4
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendBasiliskTrophy = {
        ItemScript = "scripts/items/accessory/legend_basilisk_trophy_item",
        Cost = 1500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_basilisk_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_basilisk_feathers_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    LegendBerserkerMushrooms = {
        ItemScript = "scripts/items/accessory/berserker_mushrooms_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendBonePlatingsUpgrade = {
        ItemScript = "scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade",
        Cost = 450,
        Ingredients = [
            {
                Script = "scripts/items/misc/unhold_bones_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    LegendCatPotion = {
        ItemScript = "scripts/items/accessory/cat_potion_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            },
            {
                Script = "scripts/items/accessory/berserker_mushrooms_item",
                Num = 1
            },
            {
                Script = "scripts/items/accessory/antidote_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendCloakCommon = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_armor_cloak",
        Cost = 100,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/dies_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendCloakHeavy = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_armor_cloak_heavy",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 2
            },
            {
                Script = "scripts/items/trade/furs_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/dies_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendCloakNoble = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_armor_cloak_noble",
        Cost = 3000,
        Ingredients = [
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 6
            },
            {
                Script = "scripts/items/trade/dies_item",
                Num = 4
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendDemonAlpHelmet = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_demon_alp_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_demon_alp_skin_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_demon_third_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_tools",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendDemonAlpTrophy = {
        ItemScript = "scripts/items/accessory/legend_demonalp_trophy_item",
        Cost = 3000,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_demon_alp_skin_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_demon_third_eye_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    LegendDemonBansheeTrophy = {
        ItemScript = "scripts/items/accessory/legend_demon_banshee_trophy_item",
        Cost = 1000,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_demon_hound_bones_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_banshee_essence_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    LegendFurs01 = {
        ItemScript = "scripts/items/trade/furs_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendFurs02 = {
        ItemScript = "scripts/items/trade/furs_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendFurs03 = {
        ItemScript = "scripts/items/trade/furs_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendFurs04 = {
        ItemScript = "scripts/items/trade/furs_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/werewolf_pelt_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendHeartwoodSapFlask = {
        ItemScript = "scripts/items/accessory/legend_heartwood_sap_flask_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_ancient_green_wood_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/glowing_resin_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendHexenIchorPotion = {
        ItemScript = "scripts/items/accessory/legend_hexen_ichor_potion_item",
        Cost = 2000,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_witch_leader_hair_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/mysterious_herbs_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/poisoned_apple_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendGoldIngot01 = {
        ItemScript = "scripts/items/trade/legend_gold_ingots_item",
        Cost = 3600,
        Ingredients = [
            {
                Script = "scripts/items/loot/ancient_gold_coins_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendGoldIngot02 = {
        ItemScript = "scripts/items/trade/legend_gold_ingots_item",
        Cost = 3600,
        Ingredients = [
            {
                Script = "scripts/items/loot/ancient_gold_coins_item",
                Num = 1
            },
            {
                Script = "scripts/items/loot/golden_chalice_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendGoldIngot03 = {
        ItemScript = "scripts/items/trade/legend_gold_ingots_item",
        Cost = 3600,
        Ingredients = [
            {
                Script = "scripts/items/loot/golden_chalice_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendGreenwoodSchratShield = {
        ItemScript = "scripts/items/shields/special/legend_craftable_greenwood_schrat_shield",
        Cost = 450,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_ancient_green_wood_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/glowing_resin_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendHappyPowder = {
        ItemScript = "scripts/items/misc/happy_powder_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/misc/mysterious_herbs_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_mistletoe_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendHeaterShield = {
        ItemScript = "scripts/items/shields/heater_shield",
        Cost = 200,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendHelmetFullMask = {
        ItemScript = "scripts/items/legend_helmets/hood/legend_helmet_full_mask",
        Cost = 85,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendHelmetMaskBeak = {
        ItemScript = "scripts/items/legend_helmets/top/legend_helmet_mask_beak",
        Cost = 110,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_mistletoe_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendHexenLeaderCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_hexen_leader_cloak",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_witch_leader_hair_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 6
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendHolyWater = {
        ItemScript = "scripts/items/tools/holy_water_item",
        Cost = 100,
        Ingredients = [
            {
                Script = "scripts/items/supplies/wine_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_mistletoe_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendHornPlate = {
        ItemScript = "scripts/items/legend_armor/plate/legend_armor_horn_plate_named",
        Cost = 2000,
        Ingredients = [
            {
                Script = "scripts/items/misc/kraken_horn_plate_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendHugeQuiverOfArrows = {
        ItemScript = "scripts/items/ammo/legend_huge_quiver_of_arrows",
        Cost = 3000,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_ancient_green_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendHugeQuiverOfBolts = {
        ItemScript = "scripts/items/ammo/legend_huge_quiver_of_bolts",
        Cost = 3000,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_ancient_green_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendIronWillPotion = {
        ItemScript = "scripts/items/accessory/iron_will_potion_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            },
            {
                Script = "scripts/items/accessory/legend_apothecary_mushrooms_item",
                Num = 1
            },
            {
                Script = "scripts/items/accessory/antidote_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendKiteShield = {
        ItemScript = "scripts/items/shields/kite_shield",
        Cost = 200,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendLargeQuiverOfBroadArrows = {
        ItemScript = "scripts/items/ammo/legend_large_broad_head_arrows",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendLargeQuiverOfBroadBolts = {
        ItemScript = "scripts/items/ammo/legend_large_broad_head_bolts",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendLargeQuiverOfPiercingArrows = {
        ItemScript = "scripts/items/ammo/legend_large_armor_piercing_arrows",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendLargeQuiverOfPiercingBolts = {
        ItemScript = "scripts/items/ammo/legend_large_armor_piercing_bolts",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/misc/ancient_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendLeatherHood = {
        ItemScript = "scripts/items/legend_helmets/top/legend_helmet_cult_hood",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true,
        AlternativeRequirements = [
            [::Legends.Perk.LegendDedication, ::Legends.Perks]
        ],
        Crafts = 2
    },
    LegendLeatherRobe = {
        ItemScript = "scripts/items/legend_armor/plate/legend_armor_cult_armor",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/trade/furs_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true,
        AlternativeRequirements = [
            [::Legends.Perk.LegendPenance, ::Legends.Perks]
        ],
        Crafts = 2
    },
    LegendLindwurmHelmet = {
        ItemScript = "scripts/items/legend_helmets/named/legend_named_lindwurm_helmet",
        Cost = 1500,
        Ingredients = [
            {
                Script = "scripts/items/misc/lindwurm_scales_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendLindwurmScaleArmor = {
        ItemScript = "scripts/items/legend_armor/named/legend_lindwurm_scale_armor",
        Cost = 1500,
        Ingredients = [
            {
                Script = "scripts/items/misc/lindwurm_scales_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/legend_masterwork_metal",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendLindwurmScalesCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_lindwurm_scales_cloak",
        Cost = 350,
        Ingredients = [
            {
                Script = "scripts/items/misc/lindwurm_scales_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/unhold_hide_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendMiracleDrug = {
        ItemScript = "scripts/items/misc/miracle_drug_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_mistletoe_item",
                Num = 1
            },
            {
                Script = "scripts/items/accessory/antidote_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendMountainArmor = {
        ItemScript = "scripts/items/legend_armor/legendary/legend_armor_mountain_named",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_rock_unhold_bones_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_rock_unhold_hide_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_masterwork_metal",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_tools",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendMountainHelmet = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_mountain_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_rock_unhold_bones_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_rock_unhold_hide_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_metal",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_tools",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendMushrooms = {
        ItemScript = "scripts/items/accessory/legend_apothecary_mushrooms_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_mistletoe_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendNet = {
        ItemScript = "scripts/items/tools/throwing_net",
        Cost = 10,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true,
        Crafts = 2
    },
    LegendOblivionPotion = {
        ItemScript = "scripts/items/misc/potion_of_oblivion_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_stollwurm_blood_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_demon_third_eye_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_redback_poison_gland_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_witch_leader_hair_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/mysterious_herbs_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/snake_oil_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendPackLarge = {
        ItemScript = "scripts/items/accessory/legend_pack_large",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendPackSmall = {
        ItemScript = "scripts/items/accessory/legend_pack_small",
        Cost = 100,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendPauldronsKraken = {
        ItemScript = "scripts/items/legend_armor/armor_upgrades/legend_armor_pauldrons_kraken",
        Cost = 1000,
        Ingredients = [
            {
                Script = "scripts/items/misc/kraken_horn_plate_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendPoison = {
        ItemScript = "scripts/items/accessory/poison_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendProstheticEar = {
        ItemScript = "scripts/items/misc/legend_prosthetic_ear_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_wax_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticEye = {
        ItemScript = "scripts/items/misc/legend_prosthetic_eye_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticFinger = {
        ItemScript = "scripts/items/misc/legend_prosthetic_finger_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticFoot = {
        ItemScript = "scripts/items/misc/legend_prosthetic_foot_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_iron_ingots_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticForearm = {
        ItemScript = "scripts/items/misc/legend_prosthetic_forearm_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 2
            },
            {
                Script = "scripts/items/trade/legend_iron_ingots_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticHand = {
        ItemScript = "scripts/items/misc/legend_prosthetic_hand_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_iron_ingots_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticLeg = {
        ItemScript = "scripts/items/misc/legend_prosthetic_leg_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 2
            },
            {
                Script = "scripts/items/trade/legend_iron_ingots_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendProstheticNose = {
        ItemScript = "scripts/items/misc/legend_prosthetic_nose_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_wax_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendProsthetics,
        ProfessionRequired = true
    },
    LegendQuiverOfBroadArrows = {
        ItemScript = "scripts/items/ammo/legend_broad_head_arrows",
        Cost = 130,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendQuiverOfBroadBolts = {
        ItemScript = "scripts/items/ammo/legend_broad_head_bolts",
        Cost = 130,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendQuiverOfPiercingArrows = {
        ItemScript = "scripts/items/ammo/legend_armor_piercing_arrows",
        Cost = 130,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendQuiverOfPiercingBolts = {
        ItemScript = "scripts/items/ammo/legend_armor_piercing_bolts",
        Cost = 130,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendRecoveryPotion = {
        ItemScript = "scripts/items/accessory/recovery_potion_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 2
            },
            {
                Script = "scripts/items/accessory/legend_apothecary_mushrooms_item",
                Num = 1
            },
            {
                Script = "scripts/items/accessory/berserker_mushrooms_item",
                Num = 1
            },
            {
                Script = "scripts/items/accessory/antidote_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendRedbackCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_redback_cloak",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_redback_poison_gland_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 6
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendRedbackDagger = {
        ItemScript = "scripts/items/weapons/legend_redback_dagger",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_redback_poison_gland_item",
                Num = 3
            },
            {
                Script = "scripts/items/weapons/rondel_dagger",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTrophyCarving,
        ProfessionRequired = true
    },
    LegendRedbackHelmet = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_redback_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_redback_poison_gland_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_tools",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_metal",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendRedbackPoison = {
        ItemScript = "scripts/items/accessory/legend_redback_poison_item",
        Cost = 375,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_redback_poison_gland_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendRestoredAncientChest = {
        ItemScript = "scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest_restored",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendRestoredAncientHelm01 = {
        ItemScript = "scripts/items/legend_helmets/helm/legend_helmet_ancient_legionary_helm_restored",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_dome_tailed",
                Num = 1
            },
            {
                Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_face_plate",
                Num = 1
            },
            {
                Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_legionary_helm",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendRestoredAncientHelm02 = {
        ItemScript = "scripts/items/legend_helmets/helm/legend_helmet_ancient_legionary_helm_restored",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_dome",
                Num = 1
            },
            {
                Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_tailed_conic_helm",
                Num = 1
            },
            {
                Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_side_hawk",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSackHood = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_sack",
        Cost = 75,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true,
        AlternativeRequirements = [
            [::Legends.Perk.LegendDedication, ::Legends.Perks]
        ],
        Crafts = 3
    },
    LegendScroll = {
        ItemScript = "scripts/items/misc/legend_scroll_preview_item",
        Cost = 2000,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/dies_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendInterpretation,
        ProfessionRequired = true
    },
    LegendSerpentSkinCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_serpent_skin_cloak",
        Cost = 300,
        Ingredients = [
            {
                Script = "scripts/items/misc/serpent_skin_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/ghoul_horn_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendSilk = {
        ItemScript = "scripts/items/trade/silk_item",
        Cost = 180,
        Ingredients = [
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 6
            },
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendSilverIngot01 = {
        ItemScript = "scripts/items/trade/legend_silver_ingots_item",
        Cost = 900,
        Ingredients = [
            {
                Script = "scripts/items/loot/silverware_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSilverIngot02 = {
        ItemScript = "scripts/items/trade/legend_silver_ingots_item",
        Cost = 900,
        Ingredients = [
            {
                Script = "scripts/items/loot/silverware_item",
                Num = 1
            },
            {
                Script = "scripts/items/loot/silver_bowl_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSilverIngot03 = {
        ItemScript = "scripts/items/trade/legend_silver_ingots_item",
        Cost = 900,
        Ingredients = [
            {
                Script = "scripts/items/loot/silver_bowl_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSilverIngot04 = {
        ItemScript = "scripts/items/trade/legend_silver_ingots_item",
        Cost = 900,
        Ingredients = [
            {
                Script = "scripts/items/loot/goblin_minted_coins_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSilverIngot05 = {
        ItemScript = "scripts/items/trade/legend_silver_ingots_item",
        Cost = 900,
        Ingredients = [
            {
                Script = "scripts/items/loot/goblin_minted_coins_item",
                Num = 1
            },
            {
                Script = "scripts/items/loot/silver_bowl_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSilverIngot06 = {
        ItemScript = "scripts/items/trade/legend_silver_ingots_item",
        Cost = 900,
        Ingredients = [
            {
                Script = "scripts/items/loot/goblin_minted_coins_item",
                Num = 1
            },
            {
                Script = "scripts/items/loot/silverware_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSiparShield = {
        ItemScript = "scripts/items/shields/oriental/metal_round_shield",
        Cost = 250,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_iron_ingots_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendSkinArmor = {
        ItemScript = "scripts/items/legend_armor/legendary/legend_skin_armor",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
                Num = 5
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            },
            {
                Script = "scripts/items/misc/legend_masterwork_tools",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendSkinHelmet = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_nach_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendSkinGhoulBloodFlask = {
        ItemScript = "scripts/items/accessory/legend_skin_ghoul_blood_flask_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/ghoul_brain_item",
                Num = 6
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendSmallMedicine = {
        ItemScript = "scripts/items/supplies/legend_medicine_small_item",
        Cost = 10,
        Ingredients = [
            {
                Script = "scripts/items/accessory/bandage_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendHerbcraft,
        ProfessionRequired = true
    },
    LegendSnakeOil15 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/spider_silk_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/legend_demon_hound_bones_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    LegendSnakeOil16 = {
        ItemScript = "scripts/items/misc/snake_oil_item",
        Cost = 30,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 4
            },
            {
                Script = "scripts/items/accessory/poison_item",
                Num = 1
            },
            {
                Script = "scripts/items/accessory/antidote_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendCharlatan,
        ProfessionRequired = true
    },
    LegendStake = {
        ItemScript = "scripts/items/weapons/legend_wooden_stake",
        Cost = 10,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_raw_wood_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true,
        AlternativeRequirements = [
            [::Legends.Background.Witchhunter, ::Legends.Backgrounds],
            [::Legends.Background.LegendYoungblood, ::Legends.Backgrounds]
        ],
        Crafts = 2
    },
    LegendStollwurmBloodFlask = {
        ItemScript = "scripts/items/accessory/legend_stollwurm_blood_flask_item",
        Cost = 150,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_stollwurm_blood_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/lindwurm_blood_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlchemy,
        ProfessionRequired = true
    },
    LegendStollwurmHelmet = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_lindwurm_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_stollwurm_scales_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/legend_masterwork_tools",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendStollwurmScalesCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_stollwurm_scales_cloak",
        Cost = 3500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_stollwurm_scales_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/unhold_hide_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendTabard = {
        ItemScript = "scripts/items/legend_armor/tabard/legend_armor_tabard",
        Cost = 10,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/dies_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendTabardNoble = {
        ItemScript = "scripts/items/legend_armor/tabard/legend_armor_tabard_noble",
        Cost = 1000,
        Ingredients = [
            {
                Script = "scripts/items/trade/cloth_rolls_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/dies_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendTowerShield = {
        ItemScript = "scripts/items/shields/legend_tower_shield",
        Cost = 200,
        Ingredients = [
            {
                Script = "scripts/items/trade/quality_wood_item",
                Num = 2
            },
            {
                Script = "scripts/items/trade/legend_iron_ingots_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },
    LegendUncutGems = {
        ItemScript = "scripts/items/trade/uncut_gems_item",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_gem_shards_item",
                Num = 5
            }
        ],
        Category = ::Legends.Profession.LegendEnchantersAssistant,
        ProfessionRequired = true
    },
    LegendUnholdFurCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_unhold_fur_cloak",
        Cost = 500,
        Ingredients = [
            {
                Script = "scripts/items/misc/frost_unhold_fur_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendWardogArmorUpgrade = {
        ItemScript = "scripts/items/misc/wardog_armor_upgrade_item",
        Cost = 50,
        Ingredients = [
            {
                Script = "scripts/items/misc/hyena_fur_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    }
    LegendWarlockCloak = {
        ItemScript = "scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak",
        Cost = 2000,
        Ingredients = [
            {
                Script = "scripts/items/misc/witch_hair_item",
                Num = 4
            },
            {
                Script = "scripts/items/misc/parched_skin_item",
                Num = 4
            },
            {
                Script = "scripts/items/spawns/legend_zombie_item",
                Num = 1
            },
            {
                Script = "scripts/items/legend_armor/cloth/legend_armor_tunic",
                Num = 1,
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendWarlockHood = {
        ItemScript = "scripts/items/legend_helmets/named/legend_named_warlock_hood",
        Cost = 2000,
        Ingredients = [
            {
                Script = "scripts/items/misc/witch_hair_item",
                Num = 2
            },
            {
                Script = "scripts/items/spawns/legend_zombie_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendTailoring,
        ProfessionRequired = true
    },
    LegendWarlockSkull = {
        ItemScript = "scripts/items/legend_helmets/named/legend_named_warlock_skull",
        Cost = 2000,
        Ingredients = [
            {
                Script = "scripts/items/misc/petrified_scream_item",
                Num = 2
            },
            {
                Script = "scripts/items/misc/witch_hair_item",
                Num = 1
            },
            {
                Script = "scripts/items/spawns/legend_zombie_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMetalworking,
        ProfessionRequired = true
    },
    LegendWhiteWolfHelmet = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_white_wolf_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_white_wolf_pelt_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendWhiteWolfPeltCloak = {
        ItemScript = "scripts/items/legend_helmets/vanity/legend_helmet_white_wolf_helm",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_white_wolf_pelt_item",
                Num = 3
            },
            {
                Script = "scripts/items/misc/legend_masterwork_fabric",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendWhiteWolfPeltCloak = {
        ItemScript = "scripts/items/legend_armor/cloak/legend_armor_white_wolf_pelt_cloak",
        Cost = 2500,
        Ingredients = [
            {
                Script = "scripts/items/misc/legend_white_wolf_pelt_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendLeatherworking,
        ProfessionRequired = true
    },
    LegendWood = {
        ItemScript = "scripts/items/trade/quality_wood_item",
        Cost = 90,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_raw_wood_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendWoodworking,
        ProfessionRequired = true
    },

    // Cooking
    LegendBeer = {
        ItemScript = "scripts/items/supplies/beer_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/ground_grains_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlcoholPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendBread = {
        ItemScript = "scripts/items/supplies/bread_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/ground_grains_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendCheese = {
        ItemScript = "scripts/items/supplies/goat_cheese_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_milk_item",
                Num = 2
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendCookingSpices01 = {
        ItemScript = "scripts/items/trade/legend_cooking_spices_trade_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/salt_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendCookingSpices02 = {
        ItemScript = "scripts/items/trade/legend_cooking_spices_trade_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/spices_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendCuredRations = {
        ItemScript = "scripts/items/supplies/legend_cured_rations_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/dried_fruits_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/cured_venison_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendCuredVenison = {
        ItemScript = "scripts/items/supplies/cured_venison_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_fresh_meat_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendCurry = {
        ItemScript = "scripts/items/supplies/legend_curry_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/dried_lamb_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/rice_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendDates = {
        ItemScript = "scripts/items/supplies/dates_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_dates_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendDriedFish = {
        ItemScript = "scripts/items/supplies/dried_fish_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_fish_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendDriedFruits = {
        ItemScript = "scripts/items/supplies/dried_fruits_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_fresh_fruit_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendDriedLamb = {
        ItemScript = "scripts/items/supplies/dried_lamb_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_mutton_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendFermentedUnholdHeart = {
        ItemScript = "scripts/items/supplies/fermented_unhold_heart_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/wine_item",
                Num = 1
            },
            {
                Script = "scripts/items/misc/unhold_heart_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendPickledMushrooms = {
        ItemScript = "scripts/items/supplies/pickled_mushrooms_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_fresh_mushrooms_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendPie = {
        ItemScript = "scripts/items/supplies/legend_pie_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_fruit_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_fresh_meat_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/ground_grains_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendPorridge = {
        ItemScript = "scripts/items/supplies/legend_porridge_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/roots_and_berries_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/ground_grains_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendPudding = {
        ItemScript = "scripts/items/supplies/legend_pudding_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_fruit_item",
                Num = 1
            },
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/ground_grains_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendRootsAndBerries = {
        ItemScript = "scripts/items/supplies/roots_and_berries_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_roots_and_berries_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendSmokedHam01 = {
        ItemScript = "scripts/items/supplies/smoked_ham_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/strange_meat_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendSmokedHam02 = {
        ItemScript = "scripts/items/supplies/smoked_ham_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_boar_meat_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendWine = {
        ItemScript = "scripts/items/supplies/wine_item",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/supplies/legend_fresh_fruit_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendAlcoholPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendYummySausages01 = {
        ItemScript = "scripts/items/supplies/legend_yummy_sausages",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_dog_meat_item",
                Num = 1
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendYummySausages02 = {
        ItemScript = "scripts/items/supplies/legend_yummy_sausages",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/legend_bug_meat_item",
                Num = 2
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking"
    },
    LegendYummySausages03 = {
        ItemScript = "scripts/items/supplies/legend_yummy_sausages",
        Cost = 40,
        Ingredients = [
            {
                Script = "scripts/items/trade/legend_cooking_spices_trade_item",
                Num = 1
            },
            {
                Script = "scripts/items/supplies/strange_meat_item",
                Num = 3
            }
        ],
        Category = ::Legends.Profession.LegendMealPreparation,
        ProfessionRequired = true,
        BlueprintType = "Cooking",
        AlternativeRequirements = [
            [::Legends.Trait.LegendCannibalistic, ::Legends.Traits]
        ],
        RequireAll = true
    },

    // Enchanting
    LegendRsaEndurance = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRsaSafety = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRshBravery = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRshClarity = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRshLuck = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRshPatience = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRssDefense = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRssDurability = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },

    LegendRssRadiance = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRswAccuracy = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRswBlazing = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRswBleeding = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRswFeeding = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRswPoison = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    },
    LegendRswPower = {
        ItemScript = "scripts/items/rune_sigils/legend_vala_inscription_token",
        Cost = 1200,
        Ingredients = [
            {
                Script = "scripts/items/trade/uncut_gems_item",
                Num = 1
            }
        ],
        Category = 0,
        BlueprintType = "Enchanting",
        AlternativeRequirements = [
            [::Legends.Background.LegendVala, ::Legends.Backgrounds]
        ],
    }
};

::Legends.Blueprints.addBlueprintDefObjects(clone ::Legends.Blueprint);
