if (!("BackgroundProfessionTrees" in ::Legends)) {
	::Legends.BackgroundProfessionTrees <- {};
}

::Legends.BackgroundProfessionTrees.AdventurousNoble <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Anatomist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHealing],
		Special = [::Legends.Profession.LegendFieldSurgery]	
	}
};

::Legends.BackgroundProfessionTrees.Apprentice <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCrafting]
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Assassin <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw, ::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.AssassinSouthern <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals]
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Barbarian <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Bastard <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.BeastSlayer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendGathering, ::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendBigGameHunter, ::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.Beggar <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.BeggarSouthern <- clone ::Legends.BackgroundProfessionTrees.Beggar;

::Legends.BackgroundProfessionTrees.BellyDancer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.Bowyer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendFletching]
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Brawler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Butcher <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCooking],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.ButcherSouthern <- clone ::Legends.BackgroundProfessionTrees.Butcher;

::Legends.BackgroundProfessionTrees.CaravanHand <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendFriendsInRightPlaces],
		Known = [::Legends.Profession.LegendScouting],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.CaravanHandSouthern <- clone ::Legends.BackgroundProfessionTrees.CaravanHand;

::Legends.BackgroundProfessionTrees.Companion <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.CompanionSouthern <- clone ::Legends.BackgroundProfessionTrees.Companion;

::Legends.BackgroundProfessionTrees.Companion2h <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.CompanionSouthern2h <- clone ::Legends.BackgroundProfessionTrees.Companion2h;

::Legends.BackgroundProfessionTrees.CompanionRanged <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.CompanionSouthernRanged <- clone ::Legends.BackgroundProfessionTrees.CompanionRanged;

::Legends.BackgroundProfessionTrees.Cripple <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.CrippleSouthern <- clone ::Legends.BackgroundProfessionTrees.Cripple;

::Legends.BackgroundProfessionTrees.Crucified <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Crusader <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.Cultist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.ConvertedCultist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Daytaler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendGathering],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.DaytalerSouthern <- clone ::Legends.BackgroundProfessionTrees.Daytaler;

::Legends.BackgroundProfessionTrees.Deserter <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScrapping],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.DisownedNoble <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.Eunuch <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendFriendsInRightPlaces],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.EunuchSouthern <- clone ::Legends.BackgroundProfessionTrees.Eunuch;

::Legends.BackgroundProfessionTrees.Executioner <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.ExecutionerSouthern <- clone ::Legends.BackgroundProfessionTrees.Executioner;

::Legends.BackgroundProfessionTrees.Farmhand <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendForaging],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Fisherman <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]
	}
};

::Legends.BackgroundProfessionTrees.FishermanSouthern <- clone ::Legends.BackgroundProfessionTrees.Fisherman;

::Legends.BackgroundProfessionTrees.Flagellant <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Gambler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.GamblerSouthern <- clone ::Legends.BackgroundProfessionTrees.Gambler;

::Legends.BackgroundProfessionTrees.Gladiator <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBalladeInTheMaking],
		Known = [::Legends.Profession.LegendTraining],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.GladiatorOrigin <- clone ::Legends.BackgroundProfessionTrees.Gladiator;

::Legends.BackgroundProfessionTrees.Gravedigger <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.Graverobber <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScrapping],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyUndead]	
	}
};

::Legends.BackgroundProfessionTrees.HedgeKnight <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.Historian <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendAncientKnowledge]
	}
};

::Legends.BackgroundProfessionTrees.HistorianSouthern <- clone ::Legends.BackgroundProfessionTrees.Historian;

::Legends.BackgroundProfessionTrees.Houndmaster <- {
	CustomProfessionTree = null,
	
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendDogBreeder],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Hunter <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.Juggler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.JugglerSouthern <- clone ::Legends.BackgroundProfessionTrees.Juggler;

::Legends.BackgroundProfessionTrees.KillerOnTheRun <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.KingsGuard <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.LindwurmSlayer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendBigGameHunter, ::Legends.Profession.LegendFavouredEnemyBeast]	
	}
};

::Legends.BackgroundProfessionTrees.Lumberjack <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendWoodcutting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Manhunter <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBlackBook],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Mason <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCrafting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Messenger <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScouting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Militia <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Miller <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCooking],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Miner <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendMining],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.Minstrel <- {
	CustomProfessionTree = null,
	Profession = {
		Known = [::Legends.Profession.LegendBalladeInTheMaking],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Monk <- {
	CustomProfessionTree = null,
	Profession = {
		Known = [::Legends.Profession.LegendHealing],
		Roots = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]	
	}
};

::Legends.BackgroundProfessionTrees.MonkTurnedFlagellant <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Nomad <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.NomadRanged <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.OrcSlayer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.PacifiedFlagellant <- {
	CustomProfessionTree = null,
	
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Paladin <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.PaladinOld <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.Peddler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [::Legends.Profession.LegendFriendsInRightPlaces],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.PeddlerSouthern <- clone ::Legends.BackgroundProfessionTrees.Peddler;

::Legends.BackgroundProfessionTrees.Pimp <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBraggart],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Poacher <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.Raider <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Ratcatcher <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Refugee <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.RegentInAbsentia <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	},
};

::Legends.BackgroundProfessionTrees.RetiredSoldier <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTraining],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Sellsword <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Servant <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendCooking],
		Known = [],
		Special = []
	}
};

::Legends.BackgroundProfessionTrees.ServantSouthern <- clone ::Legends.BackgroundProfessionTrees.Servant;

::Legends.BackgroundProfessionTrees.Shepherd <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendGathering],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]	
	}
};

::Legends.BackgroundProfessionTrees.ShepherdSouthern <- clone ::Legends.BackgroundProfessionTrees.Shepherd;

::Legends.BackgroundProfessionTrees.Slave <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.SlaveBarbarian <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.SlaveSouthern <- clone ::Legends.BackgroundProfessionTrees.Slave;

::Legends.BackgroundProfessionTrees.Squire <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTraining],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Swordmaster <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTraining],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]	
	}
};

::Legends.BackgroundProfessionTrees.Tailor <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTailoring],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.TailorSouthern <- clone ::Legends.BackgroundProfessionTrees.Tailor;

::Legends.BackgroundProfessionTrees.Thief <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendShadyDeals],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.ThiefSouthern <- clone ::Legends.BackgroundProfessionTrees.Thief;

::Legends.BackgroundProfessionTrees.Vagabond <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScouting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Wildman <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.Witchhunter <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBlackBook],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult, ::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.LegendAdventurousNobleRanged <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.LegendAlchemist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.LegendArbalester <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendBattleSister <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendBellyDancer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendBerserker <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.LegendBlacksmith <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendRepairing, ::Legends.Profession.LegendMetalworking],
		Special = [::Legends.Profession.LegendHammerThemOut]
	}
};

::Legends.BackgroundProfessionTrees.LegendBladedancer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw, ::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.LegendBountyHunter <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBlackBook],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw, ::Legends.Profession.LegendFavouredEnemySwordmaster]	
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderAssassin <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderBeggar <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderBeggarScaling <- clone ::Legends.BackgroundProfessionTrees.LegendCommanderBeggar;

::Legends.BackgroundProfessionTrees.LegendCommanderBerserker <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderCrusader <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult, ::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderNecro <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderNoble <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderPeddler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [::Legends.Profession.LegendFriendsInRightPlaces],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderRanger <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendCompanionMelee <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendCompanionRanged <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendConscript <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendConscriptRanged <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendDervish <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendDisownedNobleRanged <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.LegendDonkey <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendDruid <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHerbcraft],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendFootSoldier <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendGladiatorPrizefighter <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendBalladeInTheMaking],
		Known = [::Legends.Profession.LegendTraining],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendGuildMaster <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendFriendsInRightPlaces],
		Known = [::Legends.Profession.LegendThrifty],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendHerbalist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendForaging, ::Legends.Profession.LegendHerbcraft],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.LegendHouseGuard <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendHusk <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendIllusionist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendInventor <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendPetardry]
	}
};

::Legends.BackgroundProfessionTrees.LegendIronmonger <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCrafting],
		Special = [::Legends.Profession.LegendHammerThemOut]
	}
};

::Legends.BackgroundProfessionTrees.LegendLeechPeddler <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionAuxiliary <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionCenturion <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionGladiator <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendLegionHonourGuard <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendLegionLegate <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionLegionary <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionPrefect <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionSlave <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLoneWolf <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.LegendLurker <- {
	CustomProfessionTree = null,
	
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendMagister <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendManAtArms <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendMasterArcher <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendMuladi <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendNecromancer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendNecrosavant <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendNightwatch <- {
	CustomProfessionTree = null,
	
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendPilgrim <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.LegendPreserver <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendPuppet <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []
	}
};

::Legends.BackgroundProfessionTrees.LegendPuppetMaster <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendReanimator <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendSeer <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendScholar],
		Known = [],
		Special = [::Legends.Profession.LegendAncientKnowledge, ::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.LegendShieldmaiden <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendSurgeon <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHealing],
		Special = [::Legends.Profession.LegendFieldSurgery]
	}
};

::Legends.BackgroundProfessionTrees.LegendTaxidermist <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendSkinning],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.LegendVala <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [::Legends.Profession.LegendScholar],
		Known = [],
		Special = [::Legends.Profession.LegendAncientKnowledge]
	}
};

::Legends.BackgroundProfessionTrees.LegendWarden <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendWarlock <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendYoungblood <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult, ::Legends.Profession.LegendFavouredEnemyUndead]	
	}
};

// Horses

::Legends.BackgroundProfessionTrees.LegendHorse <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorseCourser <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorseDestrier <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorseRouncey <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorserider <- {
	CustomProfessionTree = null,
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}
