if (!("Professions" in ::Legends)) {
	::Legends.Professions <- {};
}

::Legends.Professions.Trees <- {};

::Legends.Professions.Trees.DefaultProfessionTree <- [
	[
		::Legends.Profession.LegendCooking,
		::Legends.Profession.LegendCrafting,
		::Legends.Profession.LegendFletching,
		::Legends.Profession.LegendGathering,
		::Legends.Profession.LegendHealing,
		::Legends.Profession.LegendRepairing,
		::Legends.Profession.LegendScrapping,
		::Legends.Profession.LegendScouting,
		::Legends.Profession.LegendTraining
	],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.ScavengerProfessionTree <- [
	[],
	[::Legends.Profession.LegendScrapping],
	[::Legends.Profession.LegendAmmoScrounger],
	[::Legends.Profession.LegendVulture, ::Legends.Profession.LegendFerretItOut],
	[::Legends.Profession.LegendMaterialist],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.BardProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendBalladeInTheMaking],
	[::Legends.Profession.LegendAmusingOurselvesToDeath],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.ScavengerProfessionTree <- [
	[],
	[::Legends.Profession.LegendScrapping],
	[::Legends.Profession.LegendAmmoScrounger],
	[::Legends.Profession.LegendVulture],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.ChirurgeonProfessionTree <- [
	[::Legends.Profession.LegendHealing],
	[::Legends.Profession.LegendBandageBales],
	[],
	[::Legends.Profession.LegendFieldSurgery],
	[::Legends.Profession.LegendButcherBarber],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.FletcherProfessionTree <- [
	[::Legends.Profession.LegendEfficientPacking],
	[::Legends.Profession.LegendReserveBundles],
	[::Legends.Profession.LegendAmmoScrounger],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.OrganizedProfessionTree <- [
	[],
	[
		::Legends.Profession.LegendEfficientPacking,
		::Legends.Profession.LegendReserveBundles,
		::Legends.Profession.LegendToolsDrawers,
		::Legends.Profession.LegendBandageBales
	],
	[::Legends.Profession.LegendSkillfulStacking],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.TrapperProfessionTree <- [
	[::Legends.Profession.LegendHunting],
	[],
	[],
	[::Legends.Profession.LegendSkinning],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.TannerProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendLeatherworking],
	[::Legends.Profession.LegendSkinning],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.CaravaneeringProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendWheelMaintenance],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.TrainerProfessionTree <- [
	[::Legends.Profession.LegendTraining],
	[],
	[::Legends.Profession.LegendDrillSergeant],
	[],
	[::Legends.Profession.LegendWhipThemIntoShape],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.WoodworkingProfessionTree <- [
	[],
	[::Legends.Profession.LegendWoodcutting],
	[::Legends.Profession.LegendWoodworking],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.WoodsmanProfessionTree <- [
	[::Legends.Profession.LegendForaging, ::Legends.Profession.LegendHunting],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.PennypincherProfessionTree <- [
	[],
	[],
	[],
	[::Legends.Profession.LegendPaymaster],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.InventorProfessionTree <- [
	[::Legends.Profession.LegendScholar],
	[],
	[::Legends.Profession.LegendProsthetics],
	[::Legends.Profession.LegendFieldSurgery],
	[::Legends.Profession.LegendSpareParts],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.BlacksmithProfessionTree <- [
	[::Legends.Profession.LegendCrafting, ::Legends.Profession.LegendRepairing],
	[::Legends.Profession.LegendToolsDrawers, ::Legends.Profession.LegendMetalworking],
	[::Legends.Profession.LegendSpareParts, ::Legends.Profession.LegendMaterialist],
	[::Legends.Profession.LegendHammerThemOut],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.HighwaymanProfessionTree <- [
	[],
	[],
	[],
	[::Legends.Profession.LegendGreasedPalms],
	[::Legends.Profession.LegendHighwayman],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.SweetTalkerProfessionTree <- [
	[],
	[::Legends.Profession.LegendBraggart],
	[::Legends.Profession.LegendCarouser, ::Legends.Profession.LegendSilverTongued],
	[::Legends.Profession.LegendCutToTheChase],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.NegotiatorProfessionTree <- [
	[],
	[],
	[],
	[::Legends.Profession.LegendOnTheGrapevine],
	[::Legends.Profession.LegendDiplomacy, ::Legends.Profession.LegendNegotiator],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.TradesmanProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendFriendsInRightPlaces],
	[::Legends.Profession.LegendConvincingProposals],
	[::Legends.Profession.LegendOffBookDeal, ::Legends.Profession.LegendTradesman],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.BeastSlayerProfessionTree <- [
	[::Legends.Profession.LegendHunting],
	[::Legends.Profession.LegendTrophyCarving],
	[],
	[::Legends.Profession.LegendBigGameHunter, ::Legends.Profession.LegendSkinning],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.EnchanterProfessionTree <- [
	[],
	[::Legends.Profession.LegendEnchantersAssistant],
	[],
	[::Legends.Profession.LegendAncientKnowledge],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.SpyProfessionTree <- [
	[],
	[::Legends.Profession.LegendShadyDeals, ::Legends.Profession.LegendLookout],
	[],
	[::Legends.Profession.LegendOnTheGrapevine],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.RecruiterProfessionTree <- [
	[::Legends.Profession.LegendSpotTheTells],
	[::Legends.Profession.LegendSizeThemUp],
	[::Legends.Profession.LegendEyeForTalent],
	[::Legends.Profession.LegendConvincingProposals],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.GladiatorProfessionTree <- [
	[],
	[],
	[],
	[::Legends.Profession.LegendBreadAndGames],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.ScribeProfessionTree <- [
	[::Legends.Profession.LegendScholar],
	[],
	[],
	[::Legends.Profession.LegendInterpretation],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.AlchemistProfessionTree <- [
	[],
	[::Legends.Profession.LegendHerbcraft],
	[::Legends.Profession.LegendCharlatan],
	[::Legends.Profession.LegendAlchemy],
	[::Legends.Profession.LegendPetardry],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.CartographyProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendCartographer],
	[::Legends.Profession.LegendLayOfTheLand],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.MiningProfessionTree <- [
	[],
	[::Legends.Profession.LegendMining],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.PathfinderProfessionTree <- [
	[::Legends.Profession.LegendScouting],
	[::Legends.Profession.LegendLookout, ::Legends.Profession.LegendTrailblazer],
	[],
	[::Legends.Profession.LegendLayOfTheLand],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.CookingProfessionTree <- [
	[],
	[::Legends.Profession.LegendMealPreparation],
	[::Legends.Profession.LegendFoodPreservation],
	[::Legends.Profession.LegendAlcoholPreparation],
	[::Legends.Profession.LegendRationing],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.DogBreedingProfessionTree <- [
	[],
	[],//[::Legends.Profession.LegendDogBreeder],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.BountyHunterProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendBlackBook],
	[::Legends.Profession.LegendBountyHunter],
	[::Legends.Profession.LegendThrifty],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.TailorProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendLeatherworking, ::Legends.Profession.LegendTailoring],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.Trees.GuildsmanProfessionTree <- [
	[],
	[::Legends.Profession.LegendToolsDrawers],
	[],
	[],
	[::Legends.Profession.LegendPersonalSeal],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Legends.Professions.BuildCustomProfessionTree <- function (_custom) {
	local pT = {
		Tree = [],
		Map = {}
	};
	pT.addProfession <- function (_profession, _row = 0) {
		local profession = clone ::Legends.Professions.ProfessionDefObjects[_profession];

		if (profession.ID in this.Map) {
			return;
		}

		profession.Row <- _row;
		profession.Unlocks <- _row;

		for (local i = this.Tree.len(); i < _row + 1; i = ++i) {
			this.Tree.push([]);
		}
		this.Tree[_row].push(profession);
		this.Map[profession.ID] <- profession;
	}

	pT.addTree <- function (_tree) {
		foreach (i, row in _tree) {
			foreach (p in row) {
				this.addProfession(p, i);
			}
		}
	}

	pT.addTree(_custom);

	return pT;
};

::Legends.Professions.ProfessionsTreeTemplate <- ::Legends.Professions.BuildCustomProfessionTree(::Legends.Professions.Trees.DefaultProfessionTree);

/**
 * Take a profession tree like character_background.m.ProfessionTree
 * convert it to something like character_background.m.CustomProfessionTree
 *
 * @param _tree An array of arrays; the latter contains profession objects
 *
 * @return An array of arrays; the latter contains integers (profession defs)
 */
::Legends.Professions.getCustomProfessionTree <- function (_tree) {
	local result = [];
    foreach (row in _tree) {
    	local arr = [];
    	foreach (profession in row) {
    		arr.push(::Legends.Professions.ProfessionDefs[profession.Const]);
    	}
    	result.push(arr);
    }
    return result;
};
