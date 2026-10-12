if (!("Professions" in ::Const)) {
	::Const.Professions <- {};
}

::Const.Professions.DefaultProfessionTree <- [
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

::Const.Professions.ScavengerProfessionTree <- [
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

::Const.Professions.BardProfessionTree <- [
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

::Const.Professions.ScavengerProfessionTree <- [
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

::Const.Professions.ChiurgeonProfessionTree <- [
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

::Const.Professions.FletcherProfessionTree <- [
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

::Const.Professions.OrganizedProfessionTree <- [
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

::Const.Professions.TannerProfessionTree <- [
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

::Const.Professions.CaravaneeringProfessionTree <- [
	[],
	[],
	[::Legends.Profession.LegendWheelMaintenance, ::Legends.Profession.LegendHippology],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Const.Professions.TrainerProfessionTree <- [
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

::Const.Professions.WoodworkingProfessionTree <- [
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

::Const.Professions.BlacksmithProfessionTree <- [
	[::Legends.Profession.LegendCrafting],
	[::Legends.Profession.LegendToolsDrawers],
	[::Legends.Profession.LegendSpareParts],
	[::Legends.Profession.LegendHammerThemOut],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Const.Professions.HighwaymanProfessionTree <- [
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

::Const.Professions.SweetTalkerProfessionTree <- [
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

::Const.Professions.NegotiatorProfessionTree <- [
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

::Const.Professions.GladiatorProfessionTree <- [
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

::Const.Professions.AlchemistProfessionTree <- [
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

::Const.Professions.CartographyProfessionTree <- [
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

::Const.Professions.MiningProfessionTree <- [
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

::Const.Professions.PathfinderProfessionTree <- [
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

::Const.Professions.RecruiterProfessionTree <- [
	[::Legends.Profession.LegendScouting],
	[::Legends.Profession.LegendLookout],
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

::Const.Professions.PathfinderProfessionTree <- [
	[::Legends.Profession.LegendScouting],
	[::Legends.Profession.LegendLookout],
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

::Const.Professions.CookingProfessionTree <- [
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

::Const.Professions.DogBreedingProfessionTree <- [
	[],
	[::Legends.Profession.LegendDogBreeder],
	[::Legends.Profession.LegendHippology],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Const.Professions.BountyHunterProfessionTree <- [
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

::Const.Professions.TailorProfessionTree <- [
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

::Const.Professions.GuildsmanProfessionTree <- [
	[],
	[::Legends.Profession.LegendToolsDrawers],
	[],
	[],
	[::Const.Strings.ProfessionDescription.LegendPersonalSeal],
	[],
	[],
	[],
	[],
	[],
	[]
];

::Const.Professions.BuildCustomProfessionTree <- function (_custom) {
	local pT = {
		Tree = [],
		Map = {}
	};
	pT.addProfession <- function (_profession, _row = 0) {
		local profession = clone ::Const.Professions.ProfessionDefObjects[_profession];

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

::Const.Professions.ProfessionsTreeTemplate <- ::Const.Professions.BuildCustomProfessionTree(::Const.Professions.DefaultProfessionTree);

/**
 * Take a profession tree like character_background.m.ProfessionTree
 * convert it to something like character_background.m.CustomProfessionTree
 * 
 * @param _tree An array of arrays; the latter contains profession objects
 * 
 * @return An array of arrays; the latter contains integers (profession defs)
 */
::Const.Professions.getCustomProfessionTree <- function (_tree) {
	local result = [];
    foreach (row in _tree) {
    	local arr = [];
    	foreach (profession in row) {
    		arr.push(::Const.Professions.ProfessionDefs[profession.Const]);
    	}
    	result.push(arr);
    }
    return result;
};
