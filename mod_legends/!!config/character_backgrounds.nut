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
		Hitpoints = [60, 60],
		Bravery = [40, 40],
		Stamina = [100, 100],
		MeleeSkill = [50, 50],
		RangedSkill = [40, 40],
		MeleeDefense = [0, 0],
		RangedDefense = [0, 0],
		Initiative = [100, 100]
	},
	Skeleton = {
		Hitpoints = [50, 50],
		Bravery = [100, 100],
		Stamina = [40, 40],
		MeleeSkill = [50, 50],
		RangedSkill = [40, 40],
		MeleeDefense = [3, 3],
		RangedDefense = [5, 5],
		Initiative = [95, 95]
	},
	Zombie = {
		Hitpoints = [75, 75],
		Bravery = [100, 100],
		Stamina = [100, 100],
		MeleeSkill = [40, 40],
		RangedSkill = [20, 20],
		MeleeDefense = [-5, -5],
		RangedDefense = [-6, -6],
		Initiative = [65, 65]
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
	::Legends.Background.AdventurousNoble,
	::Legends.Background.RetiredSoldier,
	::Legends.Background.Swordmaster,
	::Legends.Background.Sellsword,
	::Legends.Background.HedgeKnight,
	::Legends.Background.Militia,
	::Legends.Background.Bastard,
	::Legends.Background.Hunter,
	::Legends.Background.BeastSlayer,
	::Legends.Background.LegendNobleRanged,
	::Legends.Background.LegendNoble2h,
	::Legends.Background.LegendNobleShield,
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
	::Legends.Background.LegendWitch,
];
::Const.SupposedWitchBackgrounds <- [
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.AdventurousNoble,
	::Legends.Background.DisownedNoble,
	::Legends.Background.Monk
];
::Const.CharacterPartyBackgrounds <- [
	::Legends.Background.LegendDiviner,
	::Legends.Background.LegendIllusionist,
	::Legends.Background.LegendSpiritualist,
	::Legends.Background.LegendEntrancer,
	::Legends.Background.LegendDeathSummoner,
	::Legends.Background.LegendEnchanter,
	::Legends.Background.LegendWarlock,
	::Legends.Background.LegendWitch,
	::Legends.Background.LegendRunesmith,
	::Legends.Background.LegendTransmuter,
	::Legends.Background.LegendNecromancer,
	//::Legends.Background.LegendAncientSummoner,
	::Legends.Background.LegendMasterArcher,
	::Legends.Background.LegendBerserker,
	::Legends.Background.LegendNecrosavant,
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.Assassin,
	::Legends.Background.LegendCrusader,
	::Legends.Background.LegendConjurer
];

::Const.CharacterMagicBackgrounds <- [
	//::Legends.Background.LegendAncientSummoner,
	::Legends.Background.LegendConjurer,
	::Legends.Background.LegendDeathSummoner,
	::Legends.Background.LegendDiviner,
	::Legends.Background.LegendEnchanter,
	::Legends.Background.LegendEntrancer,
	::Legends.Background.LegendIllusionist,
	::Legends.Background.LegendMasterArcher,
	::Legends.Background.LegendNecrosavant,
	::Legends.Background.LegendRunesmith,
	::Legends.Background.LegendSpiritualist,
	::Legends.Background.LegendTransmuter,
	// ::Legends.Background.LegendPhilosopher, //not using these from krolock's recommendation as to the original astro/philo intentions. will leave them as possible options should we ever decide to change it
	// ::Legends.Background.LegendAstrologist,
	::Legends.Background.LegendWarlock
];

::Const.CharacterBackgroundsRandom <- [
	::Legends.Background.AdventurousNoble,
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
	::Legends.Background.LegendCannibal,
	::Legends.Background.LegendCrusader,
	::Legends.Background.LegendBerserker,
	::Legends.Background.LegendBlacksmith,
	::Legends.Background.LegendDonkey,
	::Legends.Background.LegendNobleRanged,
	::Legends.Background.LegendNoble2h,
	::Legends.Background.LegendNobleShield,
	::Legends.Background.LegendRanger,
	::Legends.Background.LegendShieldmaiden,
	::Legends.Background.LegendVala,
	// ::Legends.Background.LegendWitch,
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
	// ::Legends.Background.LegendDiviner,
	// ::Legends.Background.LegendIllusionist,
	// ::Legends.Background.LegendSpiritualist,
	// ::Legends.Background.LegendEntrancer,
	// ::Legends.Background.LegendDeathSummoner,
	// ::Legends.Background.LegendEnchanter,
	// ::Legends.Background.LegendRunesmith,
	// ::Legends.Background.LegendTransmuter,
	// ::Legends.Background.LegendNecromancer,
	// ::Legends.Background.LegendAncientSummoner,
	::Legends.Background.LegendMasterArcher,
	// ::Legends.Background.LegendNecrosavant,
	// ::Legends.Background.LegendConjurer,
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
	::Legends.Background.LegendQiyan,
	::Legends.Background.ShepherdSouthern
];
::Const.HorseBackgrounds <- [
	::Legends.Background.LegendHorseDestrier,
	::Legends.Background.LegendHorseRouncey,
	::Legends.Background.LegendHorseCourser
];

