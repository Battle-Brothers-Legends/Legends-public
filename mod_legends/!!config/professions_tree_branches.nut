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

	// chance in percent for a new bro to roll one of the FavouredEnemies his background does not give
	RandomFavouredEnemyChance = 2,

	// not part of any branch and always special
	// a bro only has one from the Special list of the background, from the roll above or from anything that adds to the stored tree
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
		monk = { Known = [P.LegendHealing], Roots = [P.LegendScholar], Special = [P.LegendFavouredEnemyUndead] },
		legend_herbalist = { Known = [P.LegendForaging, P.LegendHerbcraft], Special = [P.LegendFavouredEnemyOccult] },
		legend_alchemist = { Known = [P.LegendHerbcraft], Special = [P.LegendPetardry] },

		// smiths and craftsmen
		legend_blacksmith = { Known = [P.LegendRepairing, P.LegendMetalworking], Special = [P.LegendHammerThemOut] },
		legend_ironmonger = { Known = [P.LegendCrafting], Special = [P.LegendHammerThemOut] },
		legend_inventor = { Known = [P.LegendScholar], Special = [P.LegendPetardry] },
		legend_guild_master = { Known = [P.LegendThrifty], Roots = [P.LegendFriendsInRightPlaces], Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOccult] },
		legend_taxidermist = { Known = [P.LegendSkinning], Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOccult] },
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
		hunter = { Known = [P.LegendHunting], Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOccult] },
		poacher = { Known = [P.LegendHunting], Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyGreenskin] },
		beast_slayer = { Known = [P.LegendGathering, P.LegendHunting], Special = [P.LegendBigGameHunter, P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOccult] },
		lindwurm_slayer = { Known = [P.LegendHunting], Special = [P.LegendBigGameHunter, P.LegendFavouredEnemyBeast] },
		houndmaster = { Known = [P.LegendDogBreeder] },
		lumberjack = { Known = [P.LegendWoodcutting] },
		miner = { Known = [P.LegendMining], Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyGreenskin] },
		farmhand = { Known = [P.LegendForaging] },
		daytaler = { Known = [P.LegendGathering] },
		daytaler_southern = { Known = [P.LegendGathering] },
		shepherd = { Known = [P.LegendGathering], Special = [P.LegendFavouredEnemyBeast] },
		shepherd_southern = { Known = [P.LegendGathering] },
		vagabond = { Known = [P.LegendScouting] },
		messenger = { Known = [P.LegendScouting] },
		graverobber = { Known = [P.LegendScrapping], Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyUndead] },

		// soldiers
		retired_soldier = { Known = [P.LegendTraining], Special = [P.LegendFavouredEnemyOutlaw], FavouredEnemyChance = 20 },
		swordmaster = { Known = [P.LegendTraining], Special = [P.LegendFavouredEnemySwordmaster] },
		squire = { Known = [P.LegendTraining] },
		gladiator = { Known = [P.LegendTraining], Roots = [P.LegendBalladeInTheMaking] },
		old_gladiator = { Known = [P.LegendTraining], Roots = [P.LegendBalladeInTheMaking] },
		sellsword = { Roots = [P.LegendBraggart], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		witchhunter = { Known = [P.LegendBlackBook], Special = [P.LegendFavouredEnemyOccult, P.LegendFavouredEnemyUndead] },
		manhunter = { Known = [P.LegendBlackBook], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		legend_bounty_hunter = { Known = [P.LegendBlackBook], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw, P.LegendFavouredEnemySwordmaster] },

		// talkers and traders
		peddler = { Known = [P.LegendFriendsInRightPlaces], Roots = [P.LegendBraggart], Special = [P.LegendFavouredEnemyOutlaw] },
		peddler_southern = { Known = [P.LegendFriendsInRightPlaces], Roots = [P.LegendBraggart] },
		caravan_hand = { Roots = [P.LegendFriendsInRightPlaces], Special = [P.LegendFavouredEnemyOutlaw] },
		caravan_hand_southern = { Roots = [P.LegendFriendsInRightPlaces] },
		minstrel = { Known = [P.LegendBalladeInTheMaking], Special = [P.LegendFavouredEnemyCivilization] },
		juggler = { Roots = [P.LegendBalladeInTheMaking] },
		juggler_southern = { Roots = [P.LegendBalladeInTheMaking] },
		pimp = { Known = [P.LegendBraggart], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		gambler = { Roots = [P.LegendBraggart] },
		gambler_southern = { Roots = [P.LegendBraggart] },
		adventurous_noble = { Roots = [P.LegendBraggart], Special = [P.LegendFavouredEnemyCivilization] },
		disowned_noble = { Roots = [P.LegendBraggart], Special = [P.LegendFavouredEnemyCivilization] },

		// learned
		historian = { Known = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },
		historian_southern = { Known = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },
		legend_vala = { Roots = [P.LegendScholar], Special = [P.LegendAncientKnowledge] },
		legend_seer = { Roots = [P.LegendScholar], Special = [P.LegendAncientKnowledge, P.LegendFavouredEnemyOccult] },

		// underworld
		thief = { Known = [P.LegendShadyDeals], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		thief_southern = { Known = [P.LegendShadyDeals] },
		killer_on_the_run = { Roots = [P.LegendShadyDeals], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		assassin = { Roots = [P.LegendShadyDeals], Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw, P.LegendFavouredEnemySwordmaster] },
		assassin_southern = { Roots = [P.LegendShadyDeals], Special = [P.LegendFavouredEnemyCivilization] },

		// nothing but a favoured enemy
		barbarian = { Special = [P.LegendFavouredEnemyCivilization] },
		bastard = { Special = [P.LegendFavouredEnemyCivilization] },
		belly_dancer = { Special = [P.LegendFavouredEnemySwordmaster] },
		cripple = { Special = [P.LegendFavouredEnemyCivilization] },
		crucified = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		crusader = { Special = [P.LegendFavouredEnemyUndead] },
		cultist = { Special = [P.LegendFavouredEnemyCivilization] },
		deserter = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		executioner = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		fisherman = { Special = [P.LegendFavouredEnemyBeast] },
		gravedigger = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyUndead] },
		hedge_knight = { Special = [P.LegendFavouredEnemySwordmaster] },
		kings_guard = { Special = [P.LegendFavouredEnemySwordmaster] },
		legend_adventurous_noble_ranged = { Special = [P.LegendFavouredEnemyOutlaw] },
		legend_arbalester = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		legend_battle_sister = { Special = [P.LegendFavouredEnemyUndead] },
		legend_beggar_commander_op = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyGreenskin, P.LegendFavouredEnemyOccult, P.LegendFavouredEnemyOutlaw, P.LegendFavouredEnemySwordmaster, P.LegendFavouredEnemyUndead] },
		legend_berserker = { Special = [P.LegendFavouredEnemyGreenskin] },
		legend_bladedancer = { Special = [P.LegendFavouredEnemyOutlaw, P.LegendFavouredEnemySwordmaster] },
		legend_commander_assassin = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		legend_commander_berserker = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyGreenskin] },
		legend_commander_crusader = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOccult, P.LegendFavouredEnemyUndead] },
		legend_commander_necro = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOccult] },
		legend_commander_noble = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		legend_commander_peddler = { Special = [P.LegendFavouredEnemyOutlaw] },
		legend_commander_ranger = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyGreenskin, P.LegendFavouredEnemyOccult] },
		legend_disowned_noble_ranged = { Special = [P.LegendFavouredEnemyOutlaw] },
		legend_husk = { Special = [P.LegendFavouredEnemyCivilization] },
		legend_illusionist = { Special = [P.LegendFavouredEnemyOccult] },
		legend_leech_peddler = { Special = [P.LegendFavouredEnemyBeast] },
		legend_lone_wolf = { Special = [P.LegendFavouredEnemySwordmaster] },
		legend_lurker = { Special = [P.LegendFavouredEnemyCivilization] },
		legend_magister = { Special = [P.LegendFavouredEnemyCivilization] },
		legend_man_at_arms = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOutlaw] },
		legend_muladi = { Special = [P.LegendFavouredEnemyCivilization] },
		legend_nightwatch = { Special = [P.LegendFavouredEnemyOccult] },
		legend_pilgrim = { Special = [P.LegendFavouredEnemyUndead] },
		legend_preserver = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOccult] },
		legend_puppet_master = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOccult] },
		legend_reanimator = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOccult] },
		legend_shieldmaiden = { Special = [P.LegendFavouredEnemyOutlaw] },
		legend_warden = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyOccult] },
		legend_youngblood = { Special = [P.LegendFavouredEnemyOccult, P.LegendFavouredEnemyUndead] },
		militia = { Special = [P.LegendFavouredEnemyOutlaw] },
		nomad = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyCivilization] },
		orc_slayer = { Special = [P.LegendFavouredEnemyBeast, P.LegendFavouredEnemyGreenskin] },
		paladin = { Special = [P.LegendFavouredEnemyUndead] },
		raider = { Special = [P.LegendFavouredEnemyCivilization, P.LegendFavouredEnemyOutlaw] },
		slave = { Special = [P.LegendFavouredEnemyCivilization] },
		wildman = { Special = [P.LegendFavouredEnemyGreenskin] }
	},

	// the four tables below are filled at the end of this file from the lists above
	Requires = {}, // profession -> professions, any one of them has to be learned first
	LeadsTo = {},  // profession -> professions it reveals once learned or planned
	Depth = {},    // profession -> row it is drawn in, a root is 0
	Special = {}   // profession -> true if only the backgrounds listing it can learn it, or a bro who has it in his stored tree
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

foreach (profession in B.FavouredEnemies)
{
	B.Special[profession] <- true;
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
