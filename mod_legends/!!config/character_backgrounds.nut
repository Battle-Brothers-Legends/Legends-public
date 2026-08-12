if (!("Backgrounds" in ::Legends)) {
	::Legends.Backgrounds <- {};
}
::Legends.Backgrounds.Tag <- {
	Skeleton = "skeleton",
	Zombie = "zombie"
}
::Legends.Backgrounds.BaseAttr <- {
	Female = { // Female characters trade HP for Fatigue compared to male characters
		Hitpoints = [-10, -10],
		Stamina = [10, 10]
	},
	Default = {
		Hitpoints = [50, 60],
		Bravery = [30, 40],
		Stamina = [90, 100],
		MeleeSkill = [47, 57],
		RangedSkill = [32, 42],
		MeleeDefense = [0, 5],
		RangedDefense = [0, 5],
		Initiative = [100, 110]
	},
	Skeleton = {
		Hitpoints = [40, 50],
		Bravery = [90, 100],
		Stamina = [30, 40],
		MeleeSkill = [47, 57],
		RangedSkill = [32, 42],
		MeleeDefense = [3, 8],
		RangedDefense = [5, 10],
		Initiative = [95, 105]
	},
	Zombie = {
		Hitpoints = [65, 75],
		Bravery = [90, 100],
		Stamina = [90, 100],
		MeleeSkill = [47, 57],
		RangedSkill = [20, 30],
		MeleeDefense = [-5, 0],
		RangedDefense = [-6, -1],
		Initiative = [65, 75]
	},

	resolve = function (_tag) {
		if (_tag == ::Legends.Backgrounds.Tag.Zombie)
			return ::Legends.Backgrounds.BaseAttr.Zombie;
		if (_tag == ::Legends.Backgrounds.Tag.Skeleton)
			return ::Legends.Backgrounds.BaseAttr.Skeleton;
		return ::Legends.Backgrounds.BaseAttr.Default;
	},
};

::Const.CharacterCombatBackgrounds <- [
	::Legends.Background.DisownedNoble,
	::Legends.Background.LegendDisownedLady,
	::Legends.Background.AdventurousNoble,
	::Legends.Background.LegendAdventurousLady,
	::Legends.Background.RetiredSoldier,
	::Legends.Background.Swordmaster,
	::Legends.Background.Sellsword,
	::Legends.Background.HedgeKnight,
	::Legends.Background.Militia,
	::Legends.Background.Bastard,
	::Legends.Background.Hunter,
	::Legends.Background.BeastSlayer,
	::Legends.Background.LegendArbalester,
	::Legends.Background.LegendHouseGuard,
	::Legends.Background.LegendFootSoldier,
	::Legends.Background.Assassin,
	::Legends.Background.Brawler,
	::Legends.Background.LegendBlacksmith,
	::Legends.Background.Raider
];
::Const.CharacterLegionBackgrounds <- [ //all
	::Legends.Background.LegendLegionSlave,
	::Legends.Background.LegendLegionAuxiliary,
	::Legends.Background.LegendLegionLegionary,
	::Legends.Background.LegendLegionGladiator,
	::Legends.Background.LegendLegionHonourGuard,
	::Legends.Background.LegendLegionCenturion,
	::Legends.Background.LegendLegionPrefect,
	::Legends.Background.LegendLegionLegate
];
::Const.CharacterLegionBackgroundsLOW <- [
	::Legends.Background.LegendLegionSlave,
	::Legends.Background.LegendLegionAuxiliary,
	::Legends.Background.LegendLegionLegionary
];
::Const.CharacterLegionBackgroundsHIGH <- [
	::Legends.Background.LegendLegionLegionary,
	::Legends.Background.LegendLegionGladiator,
	::Legends.Background.LegendLegionHonourGuard,
	::Legends.Background.LegendLegionCenturion,
	::Legends.Background.LegendLegionPrefect,
	::Legends.Background.LegendLegionLegate
];
::Const.CharacterBackgroundsAnimated <- [
	::Legends.Background.AdventurousNoble,
	::Legends.Background.LegendAdventurousLady,
	::Legends.Background.Apprentice,
	::Legends.Background.Bastard,
	::Legends.Background.BeastSlayer,
	::Legends.Background.Beggar,
	::Legends.Background.Bowyer,
	::Legends.Background.Brawler,
	::Legends.Background.Butcher,
	::Legends.Background.CaravanHand,
	::Legends.Background.Cripple,
	::Legends.Background.Daytaler,
	::Legends.Background.Deserter,
	::Legends.Background.DisownedNoble,
	::Legends.Background.LegendDisownedLady,
	::Legends.Background.Eunuch,
	::Legends.Background.Farmhand,
	::Legends.Background.Fisherman,
	::Legends.Background.Flagellant,
	::Legends.Background.Gambler,
	::Legends.Background.Gravedigger,
	::Legends.Background.Graverobber,
	::Legends.Background.HedgeKnight,
	::Legends.Background.Historian,
	::Legends.Background.Houndmaster,
	::Legends.Background.Hunter,
	::Legends.Background.Juggler,
	::Legends.Background.KillerOnTheRun,
	::Legends.Background.LegendHerbalist,
	::Legends.Background.LegendInventor,
	::Legends.Background.LegendIronmonger,
	::Legends.Background.LegendTaxidermist,
	::Legends.Background.Lumberjack,
	::Legends.Background.Mason,
	::Legends.Background.Messenger,
	::Legends.Background.Militia,
	::Legends.Background.Miller,
	::Legends.Background.Miner,
	::Legends.Background.Minstrel,
	::Legends.Background.Monk,
	::Legends.Background.Peddler,
	::Legends.Background.Poacher,
	::Legends.Background.Raider,
	::Legends.Background.Ratcatcher,
	::Legends.Background.Refugee,
	::Legends.Background.RetiredSoldier,
	::Legends.Background.Sellsword,
	::Legends.Background.Servant,
	::Legends.Background.Shepherd,
	::Legends.Background.Squire,
	::Legends.Background.Swordmaster,
	::Legends.Background.Tailor,
	::Legends.Background.Thief,
	::Legends.Background.Vagabond,
	::Legends.Background.Wildman,
	::Legends.Background.Witchhunter
];
::Const.CharacterFemaleBackgrounds <- [
	::Legends.Background.LegendShieldmaiden,
];
::Const.SupposedWitchBackgrounds <- [
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.AdventurousNoble,
	::Legends.Background.LegendAdventurousLady,
	::Legends.Background.DisownedNoble,
	::Legends.Background.LegendDisownedLady,
	::Legends.Background.Monk
];
::Const.CharacterPartyBackgrounds <- [
	::Legends.Background.LegendIllusionist,
	::Legends.Background.LegendWarlock,
	::Legends.Background.LegendNecromancer,
	::Legends.Background.LegendMasterArcher,
	::Legends.Background.LegendBerserker,
	::Legends.Background.LegendNecrosavant,
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.Assassin,
	::Legends.Background.LegendCrusader
];

::Const.CharacterMagicBackgrounds <- [
	::Legends.Background.LegendIllusionist,
	::Legends.Background.LegendMasterArcher,
	::Legends.Background.LegendNecrosavant,
	::Legends.Background.LegendWarlock
];

::Const.CharacterBackgroundsRandom <- [
	::Legends.Background.AdventurousNoble,
	::Legends.Background.LegendAdventurousLady,
	::Legends.Background.Apprentice,
	::Legends.Background.Assassin,
	::Legends.Background.Barbarian,
	::Legends.Background.Bastard,
	::Legends.Background.BeastSlayer,
	::Legends.Background.Beggar,
	::Legends.Background.Bowyer,
	::Legends.Background.Brawler,
	::Legends.Background.Butcher,
	::Legends.Background.CaravanHand,
	::Legends.Background.Cripple,
	::Legends.Background.Daytaler,
	::Legends.Background.Deserter,
	::Legends.Background.DisownedNoble,
	::Legends.Background.LegendDisownedLady,
	::Legends.Background.Eunuch,
	::Legends.Background.Farmhand,
	::Legends.Background.Thief,
	::Legends.Background.Fisherman,
	::Legends.Background.FishermanSouthern,
	::Legends.Background.Flagellant,
	::Legends.Background.Gambler,
	::Legends.Background.Gravedigger,
	::Legends.Background.Graverobber,
	::Legends.Background.HedgeKnight,
	::Legends.Background.Historian,
	::Legends.Background.Houndmaster,
	::Legends.Background.Hunter,
	::Legends.Background.Juggler,
	::Legends.Background.KillerOnTheRun,
	::Legends.Background.LegendCrusader,
	::Legends.Background.LegendBerserker,
	::Legends.Background.LegendBlacksmith,
	::Legends.Background.LegendDonkey,
	::Legends.Background.LegendArbalester,
	::Legends.Background.LegendHouseGuard,
	::Legends.Background.LegendFootSoldier,
	::Legends.Background.LegendRanger,
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.LegendVala,
	::Legends.Background.LegendHerbalist,
	::Legends.Background.LegendInventor,
	::Legends.Background.LegendIronmonger,
	::Legends.Background.LegendTaxidermist,
	// ::Legends.Background.LegendNecro,
	::Legends.Background.Lumberjack,
	::Legends.Background.Mason,
	::Legends.Background.Messenger,
	::Legends.Background.Militia,
	::Legends.Background.Miller,
	::Legends.Background.Miner,
	::Legends.Background.Minstrel,
	::Legends.Background.Monk,
	::Legends.Background.Peddler,
	::Legends.Background.Poacher,
	::Legends.Background.Raider,
	::Legends.Background.Ratcatcher,
	::Legends.Background.Refugee,
	::Legends.Background.RetiredSoldier,
	::Legends.Background.Sellsword,
	::Legends.Background.Servant,
	::Legends.Background.Shepherd,
	::Legends.Background.Squire,
	::Legends.Background.Swordmaster,
	::Legends.Background.Tailor,
	::Legends.Background.Vagabond,
	::Legends.Background.Wildman,
	::Legends.Background.Witchhunter,
	::Legends.Background.LegendMasterArcher,
	::Legends.Background.Slave,
	::Legends.Background.SlaveSouthern,
	::Legends.Background.AssassinSouthern,
	::Legends.Background.LegendDervish,
	::Legends.Background.Nomad,
	::Legends.Background.LegendConscript,
	::Legends.Background.LegendConscriptRanged,
	::Legends.Background.Gladiator,
	::Legends.Background.LegendGladiatorPrizefighter,
	::Legends.Background.LegendMuladi,
	::Legends.Background.DaytalerSouthern,
	::Legends.Background.ShepherdSouthern,
	::Legends.Background.Executioner,
	::Legends.Background.ExecutionerSouthern
];

::Const.CharacterBackgroundsRandomForUndead <- [ //for necro origins only, added puppet & cultist, removed most of 'support' or lower tier backgrounds that could be exploited via camp.
	::Legends.Background.LegendPuppet,
	::Legends.Background.Cultist,
	::Legends.Background.AdventurousNoble,
	::Legends.Background.LegendAdventurousLady,
	::Legends.Background.Barbarian,
	::Legends.Background.Bastard,
	::Legends.Background.BeastSlayer,
	::Legends.Background.CaravanHand,
	::Legends.Background.Deserter,
	::Legends.Background.DisownedNoble,
	::Legends.Background.LegendDisownedLady,
	::Legends.Background.Farmhand,
	::Legends.Background.Thief,
	::Legends.Background.Fisherman,
	::Legends.Background.Flagellant,
	::Legends.Background.Gravedigger,
	::Legends.Background.Graverobber,
	::Legends.Background.HedgeKnight,
	::Legends.Background.KillerOnTheRun,
	::Legends.Background.LegendCrusader,
	::Legends.Background.LegendHouseGuard,
	::Legends.Background.LegendFootSoldier,
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.Lumberjack,
	::Legends.Background.Militia,
	::Legends.Background.Raider,
	::Legends.Background.Sellsword,
	::Legends.Background.Squire,
	::Legends.Background.Swordmaster,
	::Legends.Background.Wildman,
	::Legends.Background.Slave,
	::Legends.Background.SlaveSouthern,
	::Legends.Background.Nomad,
	::Legends.Background.LegendConscript,
];

::Const.HorseBackgrounds <- [
	::Legends.Background.LegendHorseDestrier,
	::Legends.Background.LegendHorseRouncey,
	::Legends.Background.LegendHorseCourser
];

