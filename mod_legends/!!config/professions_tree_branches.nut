if (!("Professions" in ::Legends))
{
	::Legends.Professions <- {};
}

local P = ::Legends.Profession;

::Legends.Professions.Branches <- {
	// how many of the ExtraRoots a new bro rolls on top of what the background gives
	RandomRoots = 1,

	// roots that are not part of the default tree
	// a bro only has them from the background, from the roll above or from anything that adds to the stored tree like a book
	ExtraRoots = [
		P.LegendBalladeInTheMaking,
		P.LegendBlackBook,
		P.LegendBraggart,
		P.LegendFriendsInRightPlaces,
		P.LegendScholar,
		P.LegendShadyDeals
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
		[P.LegendBigGameHunter, [P.LegendFavouredEnemyBeast]],
		[P.LegendDogBreeder, [P.LegendHippology]],

		// healing
		[P.LegendHealing, [P.LegendBandageBales, P.LegendButcherBarber]],
		[P.LegendBandageBales, [P.LegendEfficientPacking]],
		[P.LegendButcherBarber, [P.LegendFieldSurgery]],
		[P.LegendFieldSurgery, [P.LegendProsthetics]],

		// repairing
		[P.LegendRepairing, [P.LegendToolsDrawers, P.LegendNetRepair]],
		[P.LegendToolsDrawers, [P.LegendSpareParts, P.LegendEfficientPacking]],
		[P.LegendSpareParts, [P.LegendHammerThemOut, P.LegendMaterialist]],
		[P.LegendEfficientPacking, [P.LegendSkillfulStacking]],

		// scrapping
		[P.LegendScrapping, [P.LegendAmmoScrounger]],
		[P.LegendAmmoScrounger, [P.LegendVulture, P.LegendFerretItOut]],
		[P.LegendVulture, [P.LegendMaterialist]],

		// scouting
		[P.LegendScouting, [P.LegendLookout, P.LegendTrailblazer]],
		[P.LegendLookout, [P.LegendCartographer]],
		[P.LegendCartographer, [P.LegendLayOfTheLand]],
		[P.LegendTrailblazer, [P.LegendWheelMaintenance, P.LegendLayOfTheLand]],
		[P.LegendWheelMaintenance, [P.LegendHippology]],

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

	// by background ID
	Backgrounds = {
		// healers
		anatomist = { Known = [P.LegendHealing], Special = [P.LegendFieldSurgery] },
		legend_surgeon = { Known = [P.LegendHealing], Special = [P.LegendFieldSurgery] },
		monk = { Known = [P.LegendHealing], Roots = [P.LegendScholar] },
		legend_herbalist = { Known = [P.LegendForaging, P.LegendHerbcraft] },
		legend_alchemist = { Known = [P.LegendHerbcraft], Special = [P.LegendPetardry] },

		// smiths and craftsmen
		legend_blacksmith = { Known = [P.LegendRepairing, P.LegendMetalworking], Special = [P.LegendHammerThemOut] },
		legend_ironmonger = { Known = [P.LegendCrafting], Special = [P.LegendHammerThemOut] },
		legend_inventor = { Known = [P.LegendScholar], Special = [P.LegendPetardry] },
		legend_guild_master = { Known = [P.LegendThrifty], Roots = [P.LegendFriendsInRightPlaces] },
		legend_taxidermist = { Known = [P.LegendSkinning] },
		apprentice = { Known = [P.LegendCrafting] },
		mason = { Known = [P.LegendCrafting] },
		bowyer = { Known = [P.LegendFletching] },
		tailor = { Known = [P.LegendTailoring] },
		tailor_southern = { Known = [P.LegendTailoring] },

		// food
		butcher = { Known = [P.LegendCooking] },
		butcher_southern = { Known = [P.LegendCooking] },
		miller = { Known = [P.LegendCooking] },
		servant = { Known = [P.LegendCooking] },
		servant_southern = { Known = [P.LegendCooking] },

		// outdoors
		hunter = { Known = [P.LegendHunting] },
		poacher = { Known = [P.LegendHunting] },
		beast_hunter = { Known = [P.LegendGathering, P.LegendHunting], Special = [P.LegendBigGameHunter] },
		lindwurm_slayer = { Known = [P.LegendHunting], Special = [P.LegendBigGameHunter] },
		houndmaster = { Known = [P.LegendDogBreeder] },
		lumberjack = { Known = [P.LegendWoodcutting] },
		miner = { Known = [P.LegendMining] },
		farmhand = { Known = [P.LegendForaging] },
		daytaler = { Known = [P.LegendGathering] },
		daytaler_southern = { Known = [P.LegendGathering] },
		shepherd = { Known = [P.LegendGathering] },
		shepherd_southern = { Known = [P.LegendGathering] },
		vagabond = { Known = [P.LegendScouting] },
		messenger = { Known = [P.LegendScouting] },
		graverobber = { Known = [P.LegendScrapping] },

		// soldiers
		retired_soldier = { Known = [P.LegendTraining] },
		swordmaster = { Known = [P.LegendTraining] },
		squire = { Known = [P.LegendTraining] },
		gladiator = { Known = [P.LegendTraining], Roots = [P.LegendBalladeInTheMaking] },
		old_gladiator = { Known = [P.LegendTraining], Roots = [P.LegendBalladeInTheMaking] },
		sellsword = { Roots = [P.LegendBraggart] },
		witchhunter = { Known = [P.LegendBlackBook] },
		manhunter = { Known = [P.LegendBlackBook] },
		legend_bounty_hunter = { Known = [P.LegendBlackBook] },

		// talkers and traders
		peddler = { Known = [P.LegendFriendsInRightPlaces], Roots = [P.LegendBraggart] },
		peddler_southern = { Known = [P.LegendFriendsInRightPlaces], Roots = [P.LegendBraggart] },
		caravan_hand = { Roots = [P.LegendFriendsInRightPlaces] },
		caravan_hand_southern = { Roots = [P.LegendFriendsInRightPlaces] },
		minstrel = { Known = [P.LegendBalladeInTheMaking] },
		juggler = { Roots = [P.LegendBalladeInTheMaking] },
		juggler_southern = { Roots = [P.LegendBalladeInTheMaking] },
		pimp = { Known = [P.LegendBraggart] },
		gambler = { Roots = [P.LegendBraggart] },
		gambler_southern = { Roots = [P.LegendBraggart] },
		adventurous_noble = { Roots = [P.LegendBraggart] },
		disowned_noble = { Roots = [P.LegendBraggart] },

		// learned
		historian = { Known = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },
		historian_southern = { Known = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },
		legend_vala = { Roots = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },
		legend_seer = { Roots = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },

		// underworld
		thief = { Known = [P.LegendShadyDeals] },
		thief_southern = { Known = [P.LegendShadyDeals] },
		killer_on_the_run = { Roots = [P.LegendShadyDeals] },
		assassin = { Roots = [P.LegendShadyDeals] },
		assassin_southern = { Roots = [P.LegendShadyDeals] }
	},

	// the four tables below are filled at the end of this file from the lists above
	Requires = {}, // profession -> professions, any one of them has to be learned first
	LeadsTo = {},  // profession -> professions it reveals once learned or planned
	Depth = {},    // profession -> row it is drawn in, a root is 0
	Special = {}   // profession -> true if only the backgrounds listing it can learn it
};

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

foreach (background in B.Backgrounds)
{
	if (!("Special" in background))
	{
		continue;
	}

	foreach (profession in background.Special)
	{
		B.Special[profession] <- true;
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
