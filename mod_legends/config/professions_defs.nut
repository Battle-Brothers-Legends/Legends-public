if (!("Professions" in ::Const)) {
	::Const.Professions <- {};
}

if (!("Profession" in ::Legends)) {
	::Legends.Profession <- {};
}

::Const.Professions.ProfessionDefObjects <- [];
::Const.Professions.ProfessionDefs <- {};

/**
 * @param _professionDefObjects is an array of profession definitions
 * @param _container is namespace where ids will reside, you can use your own in submods
 */

::Const.Professions.addProfessionDefObjects <- function (_professionDefObjects, _container = ::Legends.Profession) {
	local size = ::Const.Professions.ProfessionDefObjects.len();
	::Const.Professions.ProfessionDefObjects.extend(_professionDefObjects);
	foreach (i, professionDefObject in _professionDefObjects) {
		if (professionDefObject.Const in _container) {
			_container[professionDefObject.Const] = size + i;
		} else {
			_container[professionDefObject.Const] <- size + i;
		}
		::Const.Professions.ProfessionDefs[professionDefObject.Const] <- size + i;
		::Const.Professions.LookupMap[professionDefObject.ID] <- professionDefObject;
	}
}

local professionDefObjects = [];

// Professions go here
::Legends.Profession.LegendAlchemy <- null;
professionDefObjects.push({
    ID = "profession.legend_alchemy",
    Script = "scripts/skills/professions/profession_legend_alchemy",
    Name = ::Const.Strings.ProfessionName.LegendAlchemy,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendAlchemy,
    Icon = "ui/professions/alchemy.png",
    IconDisabled = "ui/professions/alchemy_bw.png",
    Const = "LegendAlchemy",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendAlcoholPreparation <- null;
professionDefObjects.push({
    ID = "profession.legend_alcohol_preparation",
    Script = "scripts/skills/professions/profession_legend_alcohol_preparation",
    Name = ::Const.Strings.ProfessionName.LegendAlcoholPreparation,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendAlcoholPreparation,
    Icon = "ui/professions/alcohol_preparation.png",
    IconDisabled = "ui/professions/alcohol_preparation_bw.png",
    Const = "LegendAlcoholPreparation",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendAmmoScrounger <- null;
professionDefObjects.push({
    ID = "profession.legend_ammo_scrounger",
    Script = "scripts/skills/professions/profession_legend_ammo_scrounger",
    Name = ::Const.Strings.ProfessionName.LegendAmmoScrounger,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendAmmoScrounger,
    Icon = "ui/professions/ammo_scrounger.png",
    IconDisabled = "ui/professions/ammo_scrounger_bw.png",
    Const = "LegendAmmoScrounger",
    ScalingArray = [0, 0.2], // ammo recovered after combat
    ScalingFactor = 0.1
});

::Legends.Profession.LegendAncientKnowledge <- null;
professionDefObjects.push({
    ID = "profession.legend_ancient_knowledge",
    Script = "scripts/skills/professions/profession_legend_ancient_knowledge",
    Name = ::Const.Strings.ProfessionName.LegendAncientKnowledge,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendAncientKnowledge,
    Icon = "ui/professions/ancient_knowledge.png",
    IconDisabled = "ui/professions/ancient_knowledge_bw.png",
    Const = "LegendAncientKnowledge",
    ScalingArray = [0, 0.5], // improves minimum quality of ancient runes
    ScalingFactor = 0.05
    
});

::Legends.Profession.LegendAmusingOurselvesToDeath <- null;
professionDefObjects.push({
    ID = "profession.legend_amusing_ourselves_to_death",
    Script = "scripts/skills/professions/profession_legend_amusing_ourselves_to_death",
    Name = ::Const.Strings.ProfessionName.LegendAmusingOurselvesToDeath,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendAmusingOurselvesToDeath,
    Icon = "ui/professions/amusing_ourselves_to_death.png",
    IconDisabled = "ui/professions/amusing_ourselves_to_death_bw.png",
    Const = "LegendAmusingOurselvesToDeath",
    ScalingArray = [0, 0.1], // mood gain %
    ScalingFactor = 0.5
});

::Legends.Profession.LegendBalladeInTheMaking <- null;
professionDefObjects.push({
    ID = "profession.legend_ballade_in_the_making",
    Script = "scripts/skills/professions/profession_legend_ballade_in_the_making",
    Name = ::Const.Strings.ProfessionName.LegendBalladeInTheMaking,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBalladeInTheMaking,
    Icon = "ui/professions/ballade_in_the_making.png",
    IconDisabled = "ui/professions/ballade_in_the_making_bw.png",
    Const = "LegendBalladeInTheMaking",
    ScalingArray = [0, 0.1], // renown gain %
    ScalingFactor = 0.5
});

::Legends.Profession.LegendBandageBales <- null;
professionDefObjects.push({
    ID = "profession.legend_bandage_bales",
    Script = "scripts/skills/professions/profession_legend_bandage_bales",
    Name = ::Const.Strings.ProfessionName.LegendBandageBales,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBandageBales,
    Icon = "ui/professions/bandage_bales.png",
    IconDisabled = "ui/professions/bandage_bales_bw.png",
    Const = "LegendBandageBales",
    ScalingArray = [0, 40], // medicine space
    ScalingFactor = 0.2
});

::Legends.Profession.LegendBigGameHunter <- null;
professionDefObjects.push({
    ID = "profession.legend_big_game_hunter",
    Script = "scripts/skills/professions/profession_legend_big_game_hunter",
    Name = ::Const.Strings.ProfessionName.LegendBigGameHunter,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBigGameHunter,
    Icon = "ui/professions/big_game_hunter.png",
    IconDisabled = "ui/professions/big_game_hunter_bw.png",
    Const = "LegendBigGameHunter",
    ScalingArray = [0, 5], // chance to get a legendary contract
    ScalingFactor = 0.5
});

::Legends.Profession.LegendBlackBook <- null;
professionDefObjects.push({
    ID = "profession.legend_black_book",
    Script = "scripts/skills/professions/profession_legend_black_book",
    Name = ::Const.Strings.ProfessionName.LegendBlackBook,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBlackBook,
    Icon = "ui/professions/black_book.png",
    IconDisabled = "ui/professions/black_book_bw.png",
    Const = "LegendBlackBook",
    ScalingArray = [0, 0.85, 1.1, 1.3], // gold for champion slain (based on xp gained)
    ScalingFactor = 0.1
});

::Legends.Profession.LegendBountyHunter <- null;
professionDefObjects.push({
    ID = "profession.legend_bounty_hunter",
    Script = "scripts/skills/professions/profession_legend_bounty_hunter",
    Name = ::Const.Strings.ProfessionName.LegendBountyHunter,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBountyHunter,
    Icon = "ui/professions/bounty_hunter.png",
    IconDisabled = "ui/professions/bounty_hunter_bw.png",
    Const = "LegendBountyHunter",
    ScalingArray = [0, 2], // extra named enemy chance
    ScalingFactor = 0.5
});

::Legends.Profession.LegendBraggart <- null;
professionDefObjects.push({
    ID = "profession.legend_braggart",
    Script = "scripts/skills/professions/profession_legend_braggart",
    Name = ::Const.Strings.ProfessionName.LegendBraggart,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBraggart,
    Icon = "ui/professions/braggart.png",
    IconDisabled = "ui/professions/braggart_bw.png",
    Const = "LegendBraggart",
    ScalingArray = [0, 1], // extra recruits (x1 min x2 max)
    ScalingFactor = 1
});

::Legends.Profession.LegendBreadAndGames <- null;
professionDefObjects.push({
    ID = "profession.legend_bread_and_games",
    Script = "scripts/skills/professions/profession_legend_bread_and_games",
    Name = ::Const.Strings.ProfessionName.LegendBreadAndGames,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendBreadAndGames,
    Icon = "ui/professions/bread_and_games.png",
    IconDisabled = "ui/professions/bread_and_games_bw.png",
    Const = "LegendBreadAndGames",
    ScalingArray = [0, 1.5], // number of extra arena fights per day, fractions are a chance (1.15 = +1 and 15% chance of +2)
    ScalingFactor = 0.1
});

::Legends.Profession.LegendButcherBarber <- null;
professionDefObjects.push({
    ID = "profession.legend_butcher_barber",
    Script = "scripts/skills/professions/profession_legend_butcher_barber",
    Name = ::Const.Strings.ProfessionName.LegendButcherBarber,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendButcherBarber,
    Icon = "ui/professions/butcher_barber.png",
    IconDisabled = "ui/professions/butcher_barber_bw.png",
    Const = "LegendButcherBarber",
    ScalingArray = [0, 1], // NEEDS A SECONDARY SCALING EFFECT
    ScalingFactor = 0
});

::Legends.Profession.LegendCarouser <- null;
professionDefObjects.push({
    ID = "profession.legend_carouser",
    Script = "scripts/skills/professions/profession_legend_carouser",
    Name = ::Const.Strings.ProfessionName.LegendCarouser,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendCarouser,
    Icon = "ui/professions/carouser.png",
    IconDisabled = "ui/professions/carouser_bw.png",
    Const = "LegendCarouser",
    ScalingArray = [0, 1], // extra tavern rumours
    ScalingFactor = 0.5
});

::Legends.Profession.LegendCartographer <- null;
professionDefObjects.push({
    ID = "profession.legend_cartographer",
    Script = "scripts/skills/professions/profession_legend_cartographer",
    Name = ::Const.Strings.ProfessionName.LegendCartographer,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendCartographer,
    Icon = "ui/professions/cartographer.png",
    IconDisabled = "ui/professions/cartographer_bw.png",
    Const = "LegendCartographer",
    ScalingArray = [0, 0.85, 1.1, 1.3], // gold for location discovered (scaling * 100-400 based on distance)
    ScalingFactor = 0.1
});

::Legends.Profession.LegendCharlatan <- null;
professionDefObjects.push({
    ID = "profession.legend_charlatan",
    Script = "scripts/skills/professions/profession_legend_charlatan",
    Name = ::Const.Strings.ProfessionName.LegendCharlatan,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendCharlatan,
    Icon = "ui/professions/charlatan.png",
    IconDisabled = "ui/professions/charlatan_bw.png",
    Const = "LegendCharlatan",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendConvincingProposals <- null;
professionDefObjects.push({
    ID = "profession.legend_convincing_proposals",
    Script = "scripts/skills/professions/profession_legend_convincing_proposals",
    Name = ::Const.Strings.ProfessionName.LegendConvincingProposals,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendConvincingProposals,
    Icon = "ui/professions/convincing_proposals.png",
    IconDisabled = "ui/professions/convincing_proposals_bw.png",
    Const = "LegendConvincingProposals",
    ScalingArray = [0, 0.02], // extra haggling
    ScalingFactor = 0.25
});

::Legends.Profession.LegendCooking <- null;
professionDefObjects.push({
    ID = "profession.legend_cooking",
    Script = "scripts/skills/professions/profession_legend_cooking",
    Name = ::Const.Strings.ProfessionName.LegendCooking,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendCooking,
    Icon = "ui/professions/cooking.png",
    IconDisabled = "ui/professions/cooking_bw.png",
    Const = "LegendCooking",
    ScalingArray = [0, 1], // core profession
    ScalingFactor = 0
});

::Legends.Profession.LegendCutToTheChase <- null;
professionDefObjects.push({
    ID = "profession.legend_cut_to_the_chase",
    Script = "scripts/skills/professions/profession_legend_cut_to_the_chase",
    Name = ::Const.Strings.ProfessionName.LegendCutToTheChase,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendCutToTheChase,
    Icon = "ui/professions/cut_to_the_chase.png",
    IconDisabled = "ui/professions/cut_to_the_chase_bw.png",
    Const = "LegendCutToTheChase"
});

::Legends.Profession.LegendDiplomacy <- null;
professionDefObjects.push({
    ID = "profession.legend_diplomacy",
    Script = "scripts/skills/professions/profession_legend_diplomacy",
    Name = ::Const.Strings.ProfessionName.LegendDiplomacy,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendDiplomacy,
    Icon = "ui/professions/diplomacy.png",
    IconDisabled = "ui/professions/diplomacy_bw.png",
    Const = "LegendDiplomacy",
    ScalingArray = [0, 0.1], // relation gain %
    ScalingFactor = 0.5
});

::Legends.Profession.LegendDogBreeder <- null;
professionDefObjects.push({
    ID = "profession.legend_dog_breeder",
    Script = "scripts/skills/professions/profession_legend_dog_breeder",
    Name = ::Const.Strings.ProfessionName.LegendDogBreeder,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendDogBreeder,
    Icon = "ui/professions/dog_breeder.png",
    IconDisabled = "ui/professions/dog_breeder_bw.png",
    Const = "LegendDogBreeder",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendDrillSergeant <- null;
professionDefObjects.push({
    ID = "profession.legend_drill_sergeant",
    Script = "scripts/skills/professions/profession_legend_drill_sergeant",
    Name = ::Const.Strings.ProfessionName.LegendDrillSergeant,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendDrillSergeant,
    Icon = "ui/professions/drill_sergeant.png",
    IconDisabled = "ui/professions/drill_sergeant_bw.png",
    Const = "LegendDrillSergeant",
    ScalingArray = [0, 0.15, 0.25, 0.33], // extra xp for non veterans
    ScalingFactor = 0.05
});

::Legends.Profession.LegendEfficientPacking <- null;
professionDefObjects.push({
    ID = "profession.legend_efficient_packing",
    Script = "scripts/skills/professions/profession_legend_efficient_packing",
    Name = ::Const.Strings.ProfessionName.LegendEfficientPacking,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendEfficientPacking,
    Icon = "ui/professions/efficient_packing.png",
    IconDisabled = "ui/professions/efficient_packing_bw.png",
    Const = "LegendEfficientPacking",
    ScalingArray = [0, 2], // % extra slots
    ScalingFactor = 0.5
});

::Legends.Profession.LegendEnchantersAssistant <- null;
professionDefObjects.push({
    ID = "profession.legend_enchanters_assistant",
    Script = "scripts/skills/professions/profession_legend_enchanters_assistant",
    Name = ::Const.Strings.ProfessionName.LegendEnchantersAssistant,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendEnchantersAssistant,
    Icon = "ui/professions/enchanters_assistant.png",
    IconDisabled = "ui/professions/enchanters_assistant_bw.png",
    Const = "LegendEnchantersAssistant",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendEyeForTalent <- null;
professionDefObjects.push({
    ID = "profession.legend_eye_for_talent",
    Script = "scripts/skills/professions/profession_legend_eye_for_talent",
    Name = ::Const.Strings.ProfessionName.LegendEyeForTalent,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendEyeForTalent,
    Icon = "ui/professions/eye_for_talent.png",
    IconDisabled = "ui/professions/eye_for_talent_bw.png",
    Const = "LegendEyeForTalent",
    ScalingArray = [0, 4], // stars visible
    ScalingFactor = 0.25
});

::Legends.Profession.LegendFerretItOut <- null;
professionDefObjects.push({
    ID = "profession.legend_ferret_it_out",
    Script = "scripts/skills/professions/profession_legend_ferret_it_out",
    Name = ::Const.Strings.ProfessionName.LegendFerretItOut,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendFerretItOut,
    Icon = "ui/professions/ferret_it_out.png",
    IconDisabled = "ui/professions/ferret_it_out_bw.png",
    Const = "LegendFerretItOut",
    ScalingArray = [0, 0.05], // extra loot chance
    ScalingFactor = 0.2
});

::Legends.Profession.LegendFieldSurgery <- null;
professionDefObjects.push({
    ID = "profession.legend_field_surgery",
    Script = "scripts/skills/professions/profession_legend_field_surgery",
    Name = ::Const.Strings.ProfessionName.LegendFieldSurgery,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendFieldSurgery,
    Icon = "ui/professions/field_surgery.png",
    IconDisabled = "ui/professions/field_surgery_bw.png",
    Const = "LegendFieldSurgery",
    ScalingArray = [0, 0.15, 0.2], // extra injury survival chance mult (base 33% * (1+val))
    ScalingFactor = 0.05
});

::Legends.Profession.LegendFoodPreservation <- null;
professionDefObjects.push({
    ID = "profession.legend_food_preservation",
    Script = "scripts/skills/professions/profession_legend_food_preservation",
    Name = ::Const.Strings.ProfessionName.LegendFoodPreservation,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendFoodPreservation,
    Icon = "ui/professions/food_preservation.png",
    IconDisabled = "ui/professions/food_preservation_bw.png",
    Const = "LegendFoodPreservation",
    ScalingArray = [0, 2], // extra time before food spoils
    ScalingFactor = 0.5
});

::Legends.Profession.LegendFriendsInRightPlaces <- null;
professionDefObjects.push({
    ID = "profession.legend_friends_in_right_places",
    Script = "scripts/skills/professions/profession_legend_friends_in_right_places",
    Name = ::Const.Strings.ProfessionName.LegendFriendsInRightPlaces,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendFriendsInRightPlaces,
    Icon = "ui/professions/friends_in_right_places.png",
    IconDisabled = "ui/professions/friends_in_right_places_bw.png",
    Const = "LegendFriendsInRightPlaces",
    ScalingArray = [0, 0.85], // extra trade goods in cities, fractions are a chance (1.15 = +1 and 15% chance of +2)
    ScalingFactor = 0.1
});

::Legends.Profession.LegendGathering <- null;
professionDefObjects.push({
    ID = "profession.legend_gathering",
    Script = "scripts/skills/professions/profession_legend_gathering",
    Name = ::Const.Strings.ProfessionName.LegendGathering,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendGathering,
    Icon = "ui/professions/gathering.png",
    IconDisabled = "ui/professions/gathering_bw.png",
    Const = "LegendGathering"
});

::Legends.Profession.LegendGreasedPalms <- null;
professionDefObjects.push({
    ID = "profession.legend_greased_palms",
    Script = "scripts/skills/professions/profession_legend_greased_palms",
    Name = ::Const.Strings.ProfessionName.LegendGreasedPalms,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendGreasedPalms,
    Icon = "ui/professions/greased_palms.png",
    IconDisabled = "ui/professions/greased_palms_bw.png",
    Const = "LegendGreasedPalms",
    ScalingArray = [0, 2], // items shown in a caravan's inventory
    ScalingFactor = 0.5
});

::Legends.Profession.LegendHammerThemOut <- null;
professionDefObjects.push({
    ID = "profession.legend_hammer_them_out",
    Script = "scripts/skills/professions/profession_legend_hammer_them_out",
    Name = ::Const.Strings.ProfessionName.LegendHammerThemOut,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendHammerThemOut,
    Icon = "ui/professions/hammer_them_out.png",
    IconDisabled = "ui/professions/hammer_them_out_bw.png",
    Const = "LegendHammerThemOut",
    ScalingArray = [0, 0.3], // repair speed bonus
    ScalingFactor = 0.2
});

::Legends.Profession.LegendHerbcraft <- null;
professionDefObjects.push({
    ID = "profession.legend_herbcraft",
    Script = "scripts/skills/professions/profession_legend_herbcraft",
    Name = ::Const.Strings.ProfessionName.LegendHerbcraft,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendHerbcraft,
    Icon = "ui/professions/herbcraft.png",
    IconDisabled = "ui/professions/herbcraft_bw.png",
    Const = "LegendHerbcraft",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendHighwayman <- null;
professionDefObjects.push({
    ID = "profession.legend_highwayman",
    Script = "scripts/skills/professions/profession_legend_highwayman",
    Name = ::Const.Strings.ProfessionName.LegendHighwayman,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendHighwayman,
    Icon = "ui/professions/highwayman.png",
    IconDisabled = "ui/professions/highwayman_bw.png",
    Const = "LegendHighwayman",
    ScalingArray = [0, 0.85, 1.1, 1.3], // distance below which caravans are shown 70x
    ScalingFactor = 0.1
});

::Legends.Profession.LegendHippology <- null;
professionDefObjects.push({
    ID = "profession.legend_hippology",
    Script = "scripts/skills/professions/profession_legend_hippology",
    Name = ::Const.Strings.ProfessionName.LegendHippology,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendHippology,
    Icon = "ui/professions/hippology.png",
    IconDisabled = "ui/professions/hippology_bw.png",
    Const = "LegendHippology",
    ScalingArray = [0, 0.2, 0.3, 0.35], // extra hp% and slots * 10
    ScalingFactor = 0.05
});

::Legends.Profession.LegendHunting <- null;
professionDefObjects.push({
	ID = "profession.legend_hunting",
	Script = "scripts/skills/professions/profession_legend_hunting",
	Name = ::Const.Strings.ProfessionName.LegendHunting,
	Tooltip = ::Const.Strings.ProfessionDescription.LegendHunting,
	Icon = "ui/professions/hunting.png",
	IconDisabled = "ui/professions/hunting_bw.png",
	Const = "LegendHunting",
    ScalingArray = [0, 1], // core profession
    ScalingFactor = 0
});

::Legends.Profession.LegendInterpretation <- null;
professionDefObjects.push({
    ID = "profession.legend_interpretation",
    Script = "scripts/skills/professions/profession_legend_interpretation",
    Name = ::Const.Strings.ProfessionName.LegendInterpretation,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendInterpretation,
    Icon = "ui/professions/interpretation.png",
    IconDisabled = "ui/professions/interpretation_bw.png",
    Const = "LegendInterpretation",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendLayOfTheLand <- null;
professionDefObjects.push({
    ID = "profession.legend_lay_of_the_land",
    Script = "scripts/skills/professions/profession_legend_lay_of_the_land",
    Name = ::Const.Strings.ProfessionName.LegendLayOfTheLand,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendLayOfTheLand,
    Icon = "ui/professions/lay_of_the_land.png",
    IconDisabled = "ui/professions/lay_of_the_land_bw.png",
    Const = "LegendLayOfTheLand",
    ScalingArray = [0, 2], // items shown in a rumoured location's inventory
    ScalingFactor = 0.5
});

::Legends.Profession.LegendLeatherworking <- null;
professionDefObjects.push({
    ID = "profession.legend_leatherworking",
    Script = "scripts/skills/professions/profession_legend_leatherworking",
    Name = ::Const.Strings.ProfessionName.LegendLeatherworking,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendLeatherworking,
    Icon = "ui/professions/leatherworking.png",
    IconDisabled = "ui/professions/leatherworking_bw.png",
    Const = "LegendLeatherworking",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendLookout <- null;
professionDefObjects.push({
    ID = "profession.legend_lookout",
    Script = "scripts/skills/professions/profession_legend_lookout",
    Name = ::Const.Strings.ProfessionName.LegendLookout,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendLookout,
    Icon = "ui/professions/lookout.png",
    IconDisabled = "ui/professions/lookout_bw.png",
    Const = "LegendLookout",
    ScalingArray = [0, 0.2], // vision radius
    ScalingFactor = 0.05
});

::Legends.Profession.LegendMaterialist <- null;
professionDefObjects.push({
    ID = "profession.legend_materialist",
    Script = "scripts/skills/professions/profession_legend_materialist",
    Name = ::Const.Strings.ProfessionName.LegendMaterialist,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendMaterialist,
    Icon = "ui/professions/materialist.png",
    IconDisabled = "ui/professions/materialist_bw.png",
    Const = "LegendMaterialist"
});


::Legends.Profession.LegendMealPreparation <- null;
professionDefObjects.push({
    ID = "profession.legend_meal_preparation",
    Script = "scripts/skills/professions/profession_legend_meal_preparation",
    Name = ::Const.Strings.ProfessionName.LegendMealPreparation,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendMealPreparation,
    Icon = "ui/professions/meal_preparation.png",
    IconDisabled = "ui/professions/meal_preparation_bw.png",
    Const = "LegendMealPreparation",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendMetalworking <- null;
professionDefObjects.push({
    ID = "profession.legend_metalworking",
    Script = "scripts/skills/professions/profession_legend_metalworking",
    Name = ::Const.Strings.ProfessionName.LegendMetalworking,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendMetalworking,
    Icon = "ui/professions/metalworking.png",
    IconDisabled = "ui/professions/metalworking_bw.png",
    Const = "LegendMetalworking",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendNegotiator <- null;
professionDefObjects.push({
    ID = "profession.legend_negotiator",
    Script = "scripts/skills/professions/profession_legend_negotiator",
    Name = ::Const.Strings.ProfessionName.LegendNegotiator,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendNegotiator,
    Icon = "ui/professions/negotiator.png",
    IconDisabled = "ui/professions/negotiator_bw.png",
    Const = "LegendNegotiator",
    ScalingArray = [0, 1.2, 1.4, 1.6], // improves effect of asking for more money during negotiation
    ScalingFactor = 0.05
});

::Legends.Profession.LegendOffBookDeal <- null;
professionDefObjects.push({
    ID = "profession.legend_off_book_deal",
    Script = "scripts/skills/professions/profession_legend_off_book_deal",
    Name = ::Const.Strings.ProfessionName.LegendOffBookDeal,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendOffBookDeal,
    Icon = "ui/professions/off_book_deal.png",
    IconDisabled = "ui/professions/off_book_deal_bw.png",
    Const = "LegendOffBookDeal"
});

::Legends.Profession.LegendOnTheGrapevine <- null;
professionDefObjects.push({
    ID = "profession.legend_on_the_grapevine",
    Script = "scripts/skills/professions/profession_legend_on_the_grapevine",
    Name = ::Const.Strings.ProfessionName.LegendOnTheGrapevine,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendOnTheGrapevine,
    Icon = "ui/professions/on_the_grapevine.png",
    IconDisabled = "ui/professions/on_the_grapevine_bw.png",
    Const = "LegendOnTheGrapevine"
});

::Legends.Profession.LegendPaymaster <- null;
professionDefObjects.push({
    ID = "profession.legend_paymaster",
    Script = "scripts/skills/professions/profession_legend_paymaster",
    Name = ::Const.Strings.ProfessionName.LegendPaymaster,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendPaymaster,
    Icon = "ui/professions/paymaster.png",
    IconDisabled = "ui/professions/paymaster_bw.png",
    Const = "LegendPaymaster",
    ScalingArray = [0, 1.1], // lowers wages
    ScalingFactor = 0.05
});

::Legends.Profession.LegendPetardry <- null;
professionDefObjects.push({
    ID = "profession.legend_petardry",
    Script = "scripts/skills/professions/profession_legend_petardry",
    Name = ::Const.Strings.ProfessionName.LegendPetardry,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendPetardry,
    Icon = "ui/professions/petardry.png",
    IconDisabled = "ui/professions/petardry_bw.png",
    Const = "LegendPetardry",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendProsthetics <- null;
professionDefObjects.push({
    ID = "profession.legend_prosthetics",
    Script = "scripts/skills/professions/profession_legend_prosthetics",
    Name = ::Const.Strings.ProfessionName.LegendProsthetics,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendProsthetics,
    Icon = "ui/professions/prosthetics.png",
    IconDisabled = "ui/professions/prosthetics_bw.png",
    Const = "LegendProsthetics",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendRationing <- null;
professionDefObjects.push({
    ID = "profession.legend_rationing",
    Script = "scripts/skills/professions/profession_legend_rationing",
    Name = ::Const.Strings.ProfessionName.LegendRationing,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendRationing,
    Icon = "ui/professions/rationing.png",
    IconDisabled = "ui/professions/rationing_bw.png",
    Const = "LegendRationing",
    ScalingArray = [0, 1.1], // lowers food consumption
    ScalingFactor = 0.05
});

::Legends.Profession.LegendScholar <- null;
professionDefObjects.push({
    ID = "profession.legend_scholar",
    Script = "scripts/skills/professions/profession_legend_scholar",
    Name = ::Const.Strings.ProfessionName.LegendScholar,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendScholar,
    Icon = "ui/professions/scholar.png",
    IconDisabled = "ui/professions/scholar_bw.png",
    Const = "LegendScholar"
});

::Legends.Profession.LegendShadyDeals <- null;
professionDefObjects.push({
    ID = "profession.legend_shady_deals",
    Script = "scripts/skills/professions/profession_legend_shady_deals",
    Name = ::Const.Strings.ProfessionName.LegendShadyDeals,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendShadyDeals,
    Icon = "ui/professions/shady_deals.png",
    IconDisabled = "ui/professions/shady_deals_bw.png",
    Const = "LegendShadyDeals"
    ScalingArray = [0, 1.1], // lowers black market prices
    ScalingFactor = 0.05
});

::Legends.Profession.LegendSilverTongued <- null;
professionDefObjects.push({
    ID = "profession.legend_silver_tongued",
    Script = "scripts/skills/professions/profession_legend_silver_tongued",
    Name = ::Const.Strings.ProfessionName.LegendSilverTongued,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendSilverTongued,
    Icon = "ui/professions/silver_tongued.png",
    IconDisabled = "ui/professions/silver_tongued_bw.png",
    Const = "LegendSilverTongued",
    ScalingArray = [0, 1.1], // divide recruitment and tryout costs
    ScalingFactor = 0.05
});

::Legends.Profession.LegendSizeThemUp <- null;
professionDefObjects.push({
    ID = "profession.legend_size_them_up",
    Script = "scripts/skills/professions/profession_legend_size_them_up",
    Name = ::Const.Strings.ProfessionName.LegendSizeThemUp,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendSizeThemUp,
    Icon = "ui/professions/size_them_up.png",
    IconDisabled = "ui/professions/size_them_up_bw.png",
    Const = "LegendSizeThemUp",
    ScalingArray = [0, 0.5], // attribute range clamping
    ScalingFactor = 0.05
});

::Legends.Profession.LegendSkillfulStacking <- null;
professionDefObjects.push({
    ID = "profession.legend_skillful_stacking",
    Script = "scripts/skills/professions/profession_legend_skillful_stacking",
    Name = ::Const.Strings.ProfessionName.LegendSkillfulStacking,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendSkillfulStacking,
    Icon = "ui/professions/skillful_stacking.png",
    IconDisabled = "ui/professions/skillful_stacking_bw.png",
    Const = "LegendSkillfulStacking",
    ScalingArray = [0, 0.05], // extra inventory space percentage
    ScalingFactor = 0.5
});

::Legends.Profession.LegendSpareParts <- null;
professionDefObjects.push({
    ID = "profession.legend_spare_parts",
    Script = "scripts/skills/professions/profession_legend_spare_parts",
    Name = ::Const.Strings.ProfessionName.LegendSpareParts,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendSpareParts,
    Icon = "ui/professions/spare_parts.png",
    IconDisabled = "ui/professions/spare_parts_bw.png",
    Const = "LegendSpareParts",
    ScalingArray = [0, 6], // tool efficiency
    ScalingFactor = 0.5
});

::Legends.Profession.LegendSpotTheTells <- null;
professionDefObjects.push({
    ID = "profession.legend_spot_the_tells",
    Script = "scripts/skills/professions/profession_legend_spot_the_tells",
    Name = ::Const.Strings.ProfessionName.LegendSpotTheTells,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendSpotTheTells,
    Icon = "ui/professions/spot_the_tells.png",
    IconDisabled = "ui/professions/spot_the_tells_bw.png",
    Const = "LegendSpotTheTells",
    ScalingArray = [0, 0.5, 0.65], // chance to recognize traits
    ScalingFactor = 0.05
});

::Legends.Profession.LegendReserveBundles <- null;
professionDefObjects.push({
    ID = "profession.legend_reserve_bundles",
    Script = "scripts/skills/professions/profession_legend_reserve_bundles",
    Name = ::Const.Strings.ProfessionName.LegendReserveBundles,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendReserveBundles,
    Icon = "ui/professions/reserve_bundles.png",
    IconDisabled = "ui/professions/reserve_bundles_bw.png",
    Const = "LegendReserveBundles",
    ScalingArray = [0, 80], // ammo space
    ScalingFactor = 0.2
});

::Legends.Profession.LegendTailoring <- null;
professionDefObjects.push({
    ID = "profession.legend_tailoring",
    Script = "scripts/skills/professions/profession_legend_tailoring",
    Name = ::Const.Strings.ProfessionName.LegendTailoring,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendTailoring,
    Icon = "ui/professions/tailoring.png",
    IconDisabled = "ui/professions/tailoring_bw.png",
    Const = "LegendTailoring",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendThrifty <- null;
professionDefObjects.push({
    ID = "profession.legend_thrifty",
    Script = "scripts/skills/professions/profession_legend_thrifty",
    Name = ::Const.Strings.ProfessionName.LegendThrifty,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendThrifty,
    Icon = "ui/professions/thrifty.png",
    IconDisabled = "ui/professions/thrifty_bw.png",
    Const = "LegendThrifty",
    ScalingArray = [0, 20], // chance to save ingredients while crafting
    ScalingFactor = 0.05
});

::Legends.Profession.LegendToolsDrawers <- null;
professionDefObjects.push({
    ID = "profession.legend_tools_drawers",
    Script = "scripts/skills/professions/profession_legend_tools_drawers",
    Name = ::Const.Strings.ProfessionName.LegendToolsDrawers,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendToolsDrawers,
    Icon = "ui/professions/tools_drawers.png",
    IconDisabled = "ui/professions/tools_drawers_bw.png",
    Const = "LegendToolsDrawers",
    ScalingArray = [0, 40], // tool space
    ScalingFactor = 0.2
});

::Legends.Profession.LegendTradesman <- null;
professionDefObjects.push({
    ID = "profession.legend_tradesman",
    Script = "scripts/skills/professions/profession_legend_tradesman",
    Name = ::Const.Strings.ProfessionName.LegendTradesman,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendTradesman,
    Icon = "ui/professions/tradesman.png",
    IconDisabled = "ui/professions/tradesman_bw.png",
    Const = "LegendTradesman",
    ScalingArray = [0, 0.5], // renown for selling trade goods 0.1 equals to 1 per 1k
    ScalingFactor = 0.05
});

::Legends.Profession.LegendTrailblazer <- null;
professionDefObjects.push({
    ID = "profession.legend_trailblazer",
    Script = "scripts/skills/professions/profession_legend_trailblazer",
    Name = ::Const.Strings.ProfessionName.LegendTrailblazer,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendTrailblazer,
    Icon = "ui/professions/trailblazer.png",
    IconDisabled = "ui/professions/trailblazer_bw.png",
    Const = "LegendTrailblazer",
    ScalingArray = [0, 0.1], // extra speed on difficult terrain
    ScalingFactor = 0.3
});

::Legends.Profession.LegendTraining <- null;
professionDefObjects.push({
    ID = "profession.legend_training",
    Script = "scripts/skills/professions/profession_legend_training",
    Name = ::Const.Strings.ProfessionName.LegendTraining,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendTraining,
    Icon = "ui/professions/training.png",
    IconDisabled = "ui/professions/training_bw.png",
    Const = "LegendTraining",
    ScalingArray = [0, 1], // core profession
    ScalingFactor = 0
});

::Legends.Profession.LegendTrophyCarving <- null;
professionDefObjects.push({
    ID = "profession.legend_trophy_carving",
    Script = "scripts/skills/professions/profession_legend_trophy_carving",
    Name = ::Const.Strings.ProfessionName.LegendTrophyCarving,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendTrophyCarving,
    Icon = "ui/professions/trophy_carving.png",
    IconDisabled = "ui/professions/trophy_carving_bw.png",
    Const = "LegendTrophyCarving",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Legends.Profession.LegendVulture <- null;
professionDefObjects.push({
    ID = "profession.legend_vulture",
    Script = "scripts/skills/professions/profession_legend_vulture",
    Name = ::Const.Strings.ProfessionName.LegendVulture,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendVulture,
    Icon = "ui/professions/vulture.png",
    IconDisabled = "ui/professions/vulture_bw.png",
    Const = "LegendVulture",
    ScalingArray = [0, 0.15], // tools recovered after combat
    ScalingFactor = 0.1
});

::Legends.Profession.LegendWheelMaintenance <- null;
professionDefObjects.push({
    ID = "profession.legend_wheel_maintenance",
    Script = "scripts/skills/professions/profession_legend_wheel_maintenance",
    Name = ::Const.Strings.ProfessionName.LegendWheelMaintenance,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendWheelMaintenance,
    Icon = "ui/professions/wheel_maintenance.png",
    IconDisabled = "ui/professions/wheel_maintenance_bw.png",
    Const = "LegendWheelMaintenance",
    ScalingArray = [0, 0.05], // extra speed on world map
    ScalingFactor = 0.5
});

::Legends.Profession.LegendWhipThemIntoShape <- null;
professionDefObjects.push({
    ID = "profession.legend_whip_them_into_shape",
    Script = "scripts/skills/professions/profession_legend_whip_them_into_shape",
    Name = ::Const.Strings.ProfessionName.LegendWhipThemIntoShape,
    Tooltip = ::Const.Strings.ProfessionDescription.LegendWhipThemIntoShape,
    Icon = "ui/professions/whip_them_into_shape.png",
    IconDisabled = "ui/professions/whip_them_into_shape_bw.png",
    Const = "LegendWhipThemIntoShape",
    ScalingArray = [0, 0.75, 1.1, 1.3], // extra xp for non veterans on veteran kill
    ScalingFactor = 0.05
});

::Legends.Profession.LegendWoodworking <- null;
professionDefObjects.push({
	ID = "profession.legend_woodworking",
	Script = "scripts/skills/professions/profession_legend_woodworking",
	Name = ::Const.Strings.ProfessionName.LegendWoodworking,
	Tooltip = ::Const.Strings.ProfessionDescription.LegendWoodworking,
	Icon = "ui/professions/woodworking.png",
	IconDisabled = "ui/professions/woodworking_bw.png",
	Const = "LegendWoodworking",
    ScalingArray = [0, 2], // crafting modifier
    ScalingFactor = 0.5
});

::Const.Professions.addProfessionDefObjects(professionDefObjects);
