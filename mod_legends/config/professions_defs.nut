if (!("Professions" in ::Const)) {
    ::Const.Professions <- {};
}

if (!("Profession" in ::Legends)) {
    ::Legends.Profession <- {};
}

::Const.Professions.ProfessionDefObjects <- [];
::Const.Professions.ProfessionDefs <- {};

::Const.Professions.createProfessionDef <- function (_def) {
    ::Legends.Profession[_def.Const] <- null;
    local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
    if (!("ID" in _def)) {
        _def.ID <- "profession." + snakeCase;
    }

    if (!("Script" in _def)) {
        _def.Script <- "scripts/skills/professions/profession_" + snakeCase;
    }

    if (!("Name" in _def)) {
        _def.Name <- ::Legends.DefsHelpers.convertToDisplayName(_def.Const);

    }

    _def.Tooltip <- ::Const.Strings.ProfessionDescription[_def.Const];

    if (!("Icon" in _def)) {
        _def.Icon <- "ui/professions/" + snakeCase + ".png";
    }

    if (!("IconDisabled" in _def)) {
        _def.IconDisabled <- "ui/professions/" + snakeCase + "_bw.png";
    }

    return _def;
};

/**
 * @param _professionDefObjects is an array of profession definitions
 * @param _container is namespace where ids will reside, you can use your own in submods
 */

::Const.Professions.addProfessionDefObjects <- function (_professionDefObjects, _container = ::Legends.Profession) {
    local size = ::Const.Professions.ProfessionDefObjects.len();
    local i = 0;
    foreach (constName, def in _professionDefObjects) {
        def.Const <- constName;
        ::Const.Professions.ProfessionDefObjects.push(::Const.Professions.createProfessionDef(def));
        if (def.Const in _container) {
            _container[def.Const] = size + i;
        } else {
            _container[def.Const] <- size + i;
        }
        ::Const.Professions.ProfessionDefs[def.Const] <- size + i;
        ::Const.Professions.LookupMap[def.ID] <- def;
        i++;
    }
}

local professionDefObjects = {
    LegendAlchemy = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendAlcoholPreparation = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    }
    LegendAmmoScrounger = {
        ScalingArray = [0, 0.2], // ammo recovered after combat
        ScalingFactor = 0.1
    },
    LegendAncientKnowledge = {
        ScalingArray = [0, 0.5], // improves minimum quality of ancient runes
        ScalingFactor = 0.05
    },
    LegendAmusingOurselvesToDeath = {
        ScalingArray = [0, 0.1], // mood gain %
        ScalingFactor = 0.5
    },
    LegendBalladeInTheMaking = {
        ScalingArray = [0, 0.1], // renown gain %
        ScalingFactor = 0.5
    },
    LegendBandageBales = {
        ScalingArray = [0, 40], // medicine space
        ScalingFactor = 0.2
    },
    LegendBigGameHunter = {
        ScalingArray = [0, 5], // chance to get a legendary contract
        ScalingFactor = 0.5
    },
    LegendBlackBook = {
        ScalingArray = [0, 0.85, 1.1, 1.3], // gold for champion slain (based on xp gained)
        ScalingFactor = 0.1
    },
    LegendBountyHunter = {
        ScalingArray = [0, 2], // extra named enemy chance
        ScalingFactor = 0.5
    },
    LegendBraggart = {
        ScalingArray = [0, 1], // extra recruits (x1 min x2 max)
        ScalingFactor = 1
    },
    LegendBreadAndGames = {
        ScalingArray = [0, 1.5], // number of extra arena fights per day, fractions are a chance (1.15 = +1 and 15% chance of +2)
        ScalingFactor = 0.1
    },
    LegendButcherBarber = {
        ScalingArray = [0, 0.1], // chance to lower the magnitude of gained permanent injury
        ScalingFactor = 0.05
    },
    LegendCarouser = {
        ScalingArray = [0, 1], // extra tavern rumours
        ScalingFactor = 0.5
    },
    LegendCartographer = {
        ScalingArray = [0, 0.85, 1.1, 1.3], // gold for location discovered (scaling * 100-400 based on distance)
        ScalingFactor = 0.1
    },
    LegendCharlatan = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendConvincingProposals = {
        ScalingArray = [0, 0.02], // extra haggling
        ScalingFactor = 0.25
    },
    LegendCooking = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendCrafting = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendCutToTheChase = {
        ScalingArray = [0, 2], // items shown in a rumoured location's inventory
        ScalingFactor = 0.5
    },
    LegendDiplomacy = {
        ScalingArray = [0, 0.1], // relation gain %
        ScalingFactor = 0.5
    },
    LegendDogBreeder = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendDrillSergeant = {
        ScalingArray = [0, 0.15, 0.25, 0.33], // extra xp for non veterans
        ScalingFactor = 0.05
    },
    LegendEfficientPacking = {
        ScalingArray = [0, 2], // % extra slots
        ScalingFactor = 0.5
    },
    LegendEnchantersAssistant = {
        Name = "Enchanter's Assistant",
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendEyeForTalent = {
        ScalingArray = [0, 4], // stars visible
        ScalingFactor = 0.25
    },
    LegendFerretItOut = {
        ScalingArray = [0, 0.05], // extra loot chance
        ScalingFactor = 0.2
    },
    LegendFieldSurgery = {
        ScalingArray = [0, 0.15, 0.2], // extra injury survival chance mult (base 33% * (1+val))
        ScalingFactor = 0.05
    },
    LegendFletching = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendFoodPreservation = {
        ScalingArray = [0, 2], // extra time before food spoils
        ScalingFactor = 0.5
    },
    LegendForaging = {
        ScalingArray = [0, 0.3], // improves chances of successful foraging
        ScalingFactor = 0.1
    },
    LegendFriendsInRightPlaces = {
        ScalingArray = [0, 0.85], // extra trade goods in cities, fractions are a chance (1.15 = +1 and 15% chance of +2)
        ScalingFactor = 0.1
    },
    LegendGathering = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendGreasedPalms = {
        ScalingArray = [0, 2], // items shown in a caravan's inventory
        ScalingFactor = 0.5
    },
    LegendHammerThemOut = {
        ScalingArray = [0, 0.3], // repair speed bonus
        ScalingFactor = 0.2
    },
    LegendHealing = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendHerbcraft = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendHighwayman = {
        ScalingArray = [0, 0.85, 1.1, 1.3], // distance below which caravans are shown 70x
        ScalingFactor = 0.1
    },
    LegendHippology = {
        ScalingArray = [0, 0.2, 0.3, 0.35], // extra hp% and slots * 10
        ScalingFactor = 0.05
    },
    LegendHunting = {
        ScalingArray = [0, 0.3], // improves chances of successful hunts and allows more difficult hunts
        ScalingFactor = 0.1
    },
    LegendInterpretation = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendLayOfTheLand = {
        ScalingArray = [0, 5], // extra chance to draw maps after clearing locations
        ScalingFactor = 0.5
    },
    LegendLeatherworking = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendLookout = {
        ScalingArray = [0, 0.2], // vision radius
        ScalingFactor = 0.05
    },
    LegendMaterialist = {
        ScalingArray = [0, 0.1], // better state of repair of undamaged by player items looted
        ScalingFactor = 0.2
    },
    LegendMealPreparation = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendMetalworking = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendMining = {
        ScalingArray = [0, 0.3], // improves chances of successful gathering while mining
        ScalingFactor = 0.1
    },
    LegendNegotiator = {
        ScalingArray = [0, 1.2, 1.4, 1.6], // improves effect of asking for more money during negotiation
        ScalingFactor = 0.05
    },
    LegendOffBookDeal = {
        ScalingArray = [0, 1], // improves off book deal prices
        ScalingFactor = 0.03
    },
    LegendOnTheGrapevine = {
        ScalingArray = [0, 4], // reveals contracts, prices and situations in nearest settlements
        ScalingFactor = 0.25
    },
    LegendPaymaster = {
        ScalingArray = [0, 1.1], // lowers wages
        ScalingFactor = 0.05
    },
    LegendPersonalSeal = {
        ScalingArray = [0, 0.5], // renown for crafting 0.1 equals to 1 per 1k value
        ScalingFactor = 0.05
    },
    LegendPetardry = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendProsthetics = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendRationing = {
        ScalingArray = [0, 1.1], // lowers food consumption
        ScalingFactor = 0.05
    },
    LegendRepairing = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendReserveBundles = {
        ScalingArray = [0, 80], // ammo space
        ScalingFactor = 0.2
    },
    LegendScholar = {},
    LegendScouting = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendScrapping = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendShadyDeals = {
        ScalingArray = [0, 1.1], // lowers black market prices
        ScalingFactor = 0.05
    },
    LegendSilverTongued = {
        ScalingArray = [0, 1.1], // divide recruitment and tryout costs
        ScalingFactor = 0.05
    },
    LegendSizeThemUp = {
        ScalingArray = [0, 0.5], // attribute range clamping
        ScalingFactor = 0.05
    },
    LegendSkinning = {
        ScalingArray = [0, 0.2], // chance of extra loot from beasts
        ScalingFactor = 0.05
    },
    LegendSkillfulStacking = {
        ScalingArray = [0, 0.05], // extra inventory space percentage
        ScalingFactor = 0.5
    },
    LegendSpareParts = {
        ScalingArray = [0, 6], // tool efficiency
        ScalingFactor = 0.5
    },
    LegendSpotTheTells = {
        ScalingArray = [0, 0.5, 0.65], // chance to recognize traits
        ScalingFactor = 0.05
    },
    LegendTailoring = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendThrifty = {
        ScalingArray = [0, 20], // chance to save ingredients while crafting
        ScalingFactor = 0.05
    },
    LegendToolsDrawers = {
        ScalingArray = [0, 40], // tool space
        ScalingFactor = 0.2
    },
    LegendTradesman = {
        ScalingArray = [0, 0.5], // renown for selling trade goods 0.1 equals to 1 per 1k
        ScalingFactor = 0.05
    },
    LegendTrailblazer = {
        ScalingArray = [0, 0.1], // extra speed on difficult terrain
        ScalingFactor = 0.3
    },
    LegendTraining = {
        ScalingArray = [0, 1], // personal profession
        ScalingFactor = 0
    },
    LegendTrophyCarving = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    },
    LegendVulture = {
        ScalingArray = [0, 0.15], // tools recovered after combat
        ScalingFactor = 0.1
    },
    LegendWheelMaintenance = {
        ScalingArray = [0, 0.05], // extra speed on world map
        ScalingFactor = 0.5
    },
    LegendWhipThemIntoShape = {
        ScalingArray = [0, 0.75, 1.1, 1.3], // extra xp for non veterans on veteran kill
        ScalingFactor = 0.05
    },
    LegendWoodcutting = {
        ScalingArray = [0, 0.3], // improves chances of successful gathering while cutting wood
        ScalingFactor = 0.1
    },
    LegendWoodworking = {
        ScalingArray = [0, 2], // crafting modifier
        ScalingFactor = 0.5
    }
};

::Const.Professions.addProfessionDefObjects(professionDefObjects);
