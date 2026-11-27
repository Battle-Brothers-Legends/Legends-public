if (!("Professions" in ::Legends))
{
	::Legends.Professions <- {};
}

local P = ::Legends.Profession;

::Legends.Professions.Branches <- {
	// how many of the ExtraRoots a new bro rolls on top of what the background gives
	RandomRoots = 1,

	// roots that are not part of the default tree
	// a bro only has them from the Roots and Known lists of his background, from the roll above, or from anything that adds to the stored tree like a book
	ExtraRoots = [
		P.LegendBalladeInTheMaking,
		P.LegendBlackBook,
		P.LegendBraggart,
		P.LegendFriendsInRightPlaces,
		P.LegendScholar,
		P.LegendShadyDeals
	],

	// not part of any branch and always special
	// a bro only has one from the Special list of his background, from the FavouredEnemyChance roll of his background, or from anything that adds to the stored tree
	FavouredEnemies = [
		P.LegendFavouredEnemyBeast,
		P.LegendFavouredEnemyCivilization,
		P.LegendFavouredEnemyGreenskin,
		P.LegendFavouredEnemyOccult,
		P.LegendFavouredEnemyOutlaw,
		P.LegendFavouredEnemySwordmaster,
		P.LegendFavouredEnemyUndead
	],

	// [profession, [what it leads to]]
	// a profession that is listed under several others needs any one of them
	Unlocks = [
		// cooking
		[P.LegendCooking, [P.LegendMealPreparation, P.LegendAlcoholPreparation]],
		[P.LegendMealPreparation, [P.LegendFoodPreservation]],
		[P.LegendFoodPreservation, [P.LegendRationing]],

		// crafting
		[P.LegendCrafting, [P.LegendWoodworking, P.LegendLeatherworking, P.LegendMetalworking, P.LegendHerbcraft, P.LegendThrifty]],
		[P.LegendWoodworking, [P.LegendProsthetics]],
		[P.LegendLeatherworking, [P.LegendTailoring]],
		[P.LegendMetalworking, [P.LegendHammerThemOut]],
		[P.LegendHerbcraft, [P.LegendCharlatan]],
		[P.LegendCharlatan, [P.LegendAlchemy]],
		[P.LegendAlchemy, [P.LegendPetardry]],
		[P.LegendThrifty, [P.LegendPersonalSeal]],

		// fletching
		[P.LegendFletching, [P.LegendReserveBundles]],
		[P.LegendReserveBundles, [P.LegendAmmoScrounger, P.LegendEfficientPacking]],

		// gathering
		[P.LegendGathering, [P.LegendForaging, P.LegendHunting, P.LegendWoodcutting, P.LegendMining]],
		[P.LegendForaging, [P.LegendHerbcraft]],
		[P.LegendWoodcutting, [P.LegendWoodworking]],
		[P.LegendHunting, [P.LegendSkinning, P.LegendDogBreeder]],
		[P.LegendSkinning, [P.LegendTrophyCarving, P.LegendLeatherworking]],
		[P.LegendTrophyCarving, [P.LegendBigGameHunter]],

		// healing
		[P.LegendHealing, [P.LegendBandageBales]],
		[P.LegendBandageBales, [P.LegendEfficientPacking, P.LegendButcherBarber]],
		[P.LegendButcherBarber, [P.LegendFieldSurgery]],
		[P.LegendFieldSurgery, [P.LegendProsthetics]],

		// repairing
		[P.LegendRepairing, [P.LegendToolsDrawers, P.LegendNetRepair]],
		[P.LegendToolsDrawers, [P.LegendSpareParts, P.LegendEfficientPacking]],
		[P.LegendSpareParts, [P.LegendHammerThemOut, P.LegendMaterialist]],
		[P.LegendEfficientPacking, [P.LegendSkillfulStacking]],

		// scrapping
		[P.LegendScrapping, [P.LegendAmmoScrounger, P.LegendScrapEfficiency]],
		[P.LegendAmmoScrounger, [P.LegendVulture, P.LegendFerretItOut]],
		[P.LegendVulture, [P.LegendMaterialist]],

		// scouting
		[P.LegendScouting, [P.LegendLookout, P.LegendTrailblazer]],
		[P.LegendLookout, [P.LegendCartographer]],
		[P.LegendCartographer, [P.LegendLayOfTheLand]],
		[P.LegendTrailblazer, [P.LegendWheelMaintenance, P.LegendLayOfTheLand]],

		// training
		[P.LegendTraining, [P.LegendDrillSergeant, P.LegendSpotTheTells]],
		[P.LegendDrillSergeant, [P.LegendWhipThemIntoShape, P.LegendBreadAndGames]],
		[P.LegendSpotTheTells, [P.LegendSizeThemUp]],
		[P.LegendSizeThemUp, [P.LegendEyeForTalent]],

		// extra root: performing
		[P.LegendBalladeInTheMaking, [P.LegendAmusingOurselvesToDeath]],
		[P.LegendAmusingOurselvesToDeath, [P.LegendBreadAndGames]],

		// extra root: bounties
		[P.LegendBlackBook, [P.LegendBountyHunter]],

		// extra root: talking
		[P.LegendBraggart, [P.LegendCarouser, P.LegendSilverTongued]],
		[P.LegendCarouser, [P.LegendCutToTheChase, P.LegendOnTheGrapevine]],
		[P.LegendSilverTongued, [P.LegendDiplomacy, P.LegendPaymaster]],
		[P.LegendDiplomacy, [P.LegendNegotiator]],

		// extra root: trading
		[P.LegendFriendsInRightPlaces, [P.LegendConvincingProposals]],
		[P.LegendConvincingProposals, [P.LegendOffBookDeal, P.LegendTradesman]],

		// extra root: learning
		[P.LegendScholar, [P.LegendInterpretation, P.LegendEnchantersAssistant, P.LegendCartographer, P.LegendProsthetics]],
		[P.LegendEnchantersAssistant, [P.LegendAncientKnowledge]],

		// extra root: underworld
		[P.LegendShadyDeals, [P.LegendGreasedPalms, P.LegendOnTheGrapevine]],
		[P.LegendGreasedPalms, [P.LegendHighwayman]]
	],

	// the three tables below are filled at the end of this file from Unlocks
	Requires = {}, // profession -> professions, any one of them has to be learned first
	LeadsTo = {},  // profession -> professions it reveals once learned or planned
	Depth = {}     // profession -> row it is drawn in, a root is 0
};

// What a background brings to the tree is in ::Legends.BackgroundProfessionTrees, config/zz_background_profession_trees.nut:
// Known are learned from the start
// Roots are extra roots it can learn
// Special are the special professions it can learn
// FavouredEnemyChance is the chance in percent to roll one of the FavouredEnemies it does not have

local B = ::Legends.Professions.Branches;

foreach (entry in B.Unlocks) {
	local from = entry[0];
	if (!(from in B.LeadsTo)) {
		B.LeadsTo[from] <- [];
	}

	foreach (to in entry[1]) {
		B.LeadsTo[from].push(to);
		if (!(to in B.Requires)) {
			B.Requires[to] <- [];
		}
		B.Requires[to].push(from);
	}
}

// a root is drawn in row 0, everything else one row below the nearest profession that leads to it
foreach (profession, _ in ::Legends.Professions.ProfessionDefObjects)
{
	if (!(profession in B.Requires))
	{
		B.Depth[profession] <- 0;
	}
}

local changed = true;
while (changed) {
	changed = false;

	foreach (profession, requires in B.Requires)
	{
		foreach (required in requires)
		{
			if (!(required in B.Depth))
			{
				continue;
			}

			if (!(profession in B.Depth) || B.Depth[profession] > B.Depth[required] + 1)
			{
				B.Depth[profession] <- B.Depth[required] + 1;
				changed = true;
			}
		}
	}
}

// logging shit I was using to catch any strays
// foreach (profession, _ in B.Requires)
// {
// 	if (!(profession in B.Depth))
// 	{
// 		::logError("Profession branches: '" + ::Legends.Professions.ProfessionDefObjects[profession].ID + "' can not be reached from any root");
// 	}
// }
