if (!("BackgroundProfessionTrees" in ::Legends)) {
	::Legends.BackgroundProfessionTrees <- {};
}

::Legends.BackgroundProfessionTrees.AdventurousNoble <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Anatomist <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHealing],
		Special = [::Legends.Profession.LegendFieldSurgery]	
	}
};

::Legends.BackgroundProfessionTrees.Apprentice <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCrafting]
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Assassin <- {
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw, ::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.AssassinSouthern <- {
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals]
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Barbarian <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Bastard <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.BeastSlayer <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendGathering, ::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendBigGameHunter, ::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.Beggar <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.BeggarSouthern <- clone ::Legends.BackgroundProfessionTrees.Beggar;

::Legends.BackgroundProfessionTrees.BellyDancer <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.Bowyer <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendFletching]
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Brawler <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Butcher <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCooking],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.ButcherSouthern <- clone ::Legends.BackgroundProfessionTrees.Butcher;

::Legends.BackgroundProfessionTrees.CaravanHand <- {
	Profession = {
		Roots = [::Legends.Profession.LegendFriendsInRightPlaces],
		Known = [::Legends.Profession.LegendScouting],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.CaravanHandSouthern <- clone ::Legends.BackgroundProfessionTrees.CaravanHand;

::Legends.BackgroundProfessionTrees.Companion <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.CompanionSouthern <- clone ::Legends.BackgroundProfessionTrees.Companion;

::Legends.BackgroundProfessionTrees.Companion2h <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.CompanionSouthern2h <- clone ::Legends.BackgroundProfessionTrees.Companion2h;

::Legends.BackgroundProfessionTrees.CompanionRanged <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.CompanionSouthernRanged <- clone ::Legends.BackgroundProfessionTrees.CompanionRanged;

::Legends.BackgroundProfessionTrees.Cripple <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.CrippleSouthern <- clone ::Legends.BackgroundProfessionTrees.Cripple;

::Legends.BackgroundProfessionTrees.Crucified <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Crusader <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.Cultist <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.ConvertedCultist <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Daytaler <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendGathering],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.DaytalerSouthern <- clone ::Legends.BackgroundProfessionTrees.Daytaler;

::Legends.BackgroundProfessionTrees.Deserter <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScrapping],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.DisownedNoble <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.Eunuch <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendFriendsInRightPlaces],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.EunuchSouthern <- clone ::Legends.BackgroundProfessionTrees.Eunuch;

::Legends.BackgroundProfessionTrees.Executioner <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.ExecutionerSouthern <- clone ::Legends.BackgroundProfessionTrees.Executioner;

::Legends.BackgroundProfessionTrees.Farmhand <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendForaging],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Fisherman <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]
	}
};

::Legends.BackgroundProfessionTrees.FishermanSouthern <- clone ::Legends.BackgroundProfessionTrees.Fisherman;

::Legends.BackgroundProfessionTrees.Flagellant <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Gambler <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.GamblerSouthern <- clone ::Legends.BackgroundProfessionTrees.Gambler;

::Legends.BackgroundProfessionTrees.Gladiator <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBalladeInTheMaking],
		Known = [::Legends.Profession.LegendTraining],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.GladiatorOrigin <- clone ::Legends.BackgroundProfessionTrees.Gladiator;

::Legends.BackgroundProfessionTrees.Gravedigger <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.Graverobber <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScrapping],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyUndead]	
	}
};

::Legends.BackgroundProfessionTrees.HedgeKnight <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.Historian <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendAncientKnowledge]
	}
};

::Legends.BackgroundProfessionTrees.HistorianSouthern <- clone ::Legends.BackgroundProfessionTrees.Historian;

::Legends.BackgroundProfessionTrees.Houndmaster <- {
	
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendDogBreeder],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Hunter <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.Juggler <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.JugglerSouthern <- clone ::Legends.BackgroundProfessionTrees.Juggler;

::Legends.BackgroundProfessionTrees.KillerOnTheRun <- {
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.KingsGuard <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.LindwurmSlayer <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendBigGameHunter, ::Legends.Profession.LegendFavouredEnemyBeast]	
	}
};

::Legends.BackgroundProfessionTrees.Lumberjack <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendWoodcutting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Manhunter <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBlackBook],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Mason <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCrafting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Messenger <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScouting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Militia <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Miller <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCooking],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Miner <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendMining],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.Minstrel <- {
	Profession = {
		Known = [::Legends.Profession.LegendBalladeInTheMaking],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.Monk <- {
	Profession = {
		Known = [::Legends.Profession.LegendHealing],
		Roots = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]	
	}
};

::Legends.BackgroundProfessionTrees.MonkTurnedFlagellant <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Nomad <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.NomadRanged <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.OrcSlayer <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.PacifiedFlagellant <- {
	
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Paladin <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.PaladinOld <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.Peddler <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [::Legends.Profession.LegendFriendsInRightPlaces],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.PeddlerSouthern <- clone ::Legends.BackgroundProfessionTrees.Peddler;

::Legends.BackgroundProfessionTrees.Pimp <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBraggart],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Poacher <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHunting],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.Raider <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Ratcatcher <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Refugee <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.RegentInAbsentia <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	},
};

::Legends.BackgroundProfessionTrees.RetiredSoldier <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTraining],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Sellsword <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.Servant <- {
	Profession = {
		Roots = [::Legends.Profession.LegendCooking],
		Known = [],
		Special = []
	}
};

::Legends.BackgroundProfessionTrees.ServantSouthern <- clone ::Legends.BackgroundProfessionTrees.Servant;

::Legends.BackgroundProfessionTrees.Shepherd <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendGathering],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]	
	}
};

::Legends.BackgroundProfessionTrees.ShepherdSouthern <- clone ::Legends.BackgroundProfessionTrees.Shepherd;

::Legends.BackgroundProfessionTrees.Slave <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.SlaveBarbarian <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.SlaveSouthern <- clone ::Legends.BackgroundProfessionTrees.Slave;

::Legends.BackgroundProfessionTrees.Squire <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTraining],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Swordmaster <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTraining],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]	
	}
};

::Legends.BackgroundProfessionTrees.Tailor <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendTailoring],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.TailorSouthern <- clone ::Legends.BackgroundProfessionTrees.Tailor;

::Legends.BackgroundProfessionTrees.Thief <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendShadyDeals],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.ThiefSouthern <- clone ::Legends.BackgroundProfessionTrees.Thief;

::Legends.BackgroundProfessionTrees.Vagabond <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScouting],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.Wildman <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.Witchhunter <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBlackBook],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult, ::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.LegendAdventurousNobleRanged <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.LegendAlchemist <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.LegendArbalester <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendBattleSister <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendBellyDancer <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendBerserker <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.LegendBlacksmith <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendRepairing, ::Legends.Profession.LegendMetalworking],
		Special = [::Legends.Profession.LegendHammerThemOut]
	}
};

::Legends.BackgroundProfessionTrees.LegendBladedancer <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw, ::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.LegendBountyHunter <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendBlackBook],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw, ::Legends.Profession.LegendFavouredEnemySwordmaster]	
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderAssassin <- {
	Profession = {
		Roots = [::Legends.Profession.LegendShadyDeals],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderBeggar <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderBeggarScaling <- clone ::Legends.BackgroundProfessionTrees.LegendCommanderBeggar;

::Legends.BackgroundProfessionTrees.LegendCommanderBerserker <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderCrusader <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult, ::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderNecro <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderNoble <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderPeddler <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [::Legends.Profession.LegendFriendsInRightPlaces],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendCommanderRanger <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyGreenskin, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendCompanionMelee <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendCompanionRanged <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendConscript <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendConscriptRanged <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendDervish <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendDisownedNobleRanged <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBraggart],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]	
	}
};

::Legends.BackgroundProfessionTrees.LegendDonkey <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendDruid <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHerbcraft],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendFootSoldier <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendGladiatorPrizefighter <- {
	Profession = {
		Roots = [::Legends.Profession.LegendBalladeInTheMaking],
		Known = [::Legends.Profession.LegendTraining],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendGuildMaster <- {
	Profession = {
		Roots = [::Legends.Profession.LegendFriendsInRightPlaces],
		Known = [::Legends.Profession.LegendThrifty],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendHerbalist <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendForaging, ::Legends.Profession.LegendHerbcraft],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.LegendHouseGuard <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendHusk <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendIllusionist <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendInventor <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendScholar],
		Special = [::Legends.Profession.LegendPetardry]
	}
};

::Legends.BackgroundProfessionTrees.LegendIronmonger <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendCrafting],
		Special = [::Legends.Profession.LegendHammerThemOut]
	}
};

::Legends.BackgroundProfessionTrees.LegendLeechPeddler <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast]
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionAuxiliary <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionCenturion <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionGladiator <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendLegionHonourGuard <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendLegionLegate <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionLegionary <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionPrefect <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLegionSlave <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendLoneWolf <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemySwordmaster]
	}
};

::Legends.BackgroundProfessionTrees.LegendLurker <- {
	
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendMagister <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendManAtArms <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendMasterArcher <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendMuladi <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyCivilization]
	}
};

::Legends.BackgroundProfessionTrees.LegendNecromancer <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendNecrosavant <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendNightwatch <- {
	
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendPilgrim <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyUndead]
	}
};

::Legends.BackgroundProfessionTrees.LegendPreserver <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendPuppet <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []
	}
};

::Legends.BackgroundProfessionTrees.LegendPuppetMaster <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendReanimator <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyCivilization, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendSeer <- {
	Profession = {
		Roots = [::Legends.Profession.LegendScholar],
		Known = [],
		Special = [::Legends.Profession.LegendAncientKnowledge, ::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.LegendShieldmaiden <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOutlaw]
	}
};

::Legends.BackgroundProfessionTrees.LegendSurgeon <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendHealing],
		Special = [::Legends.Profession.LegendFieldSurgery]
	}
};

::Legends.BackgroundProfessionTrees.LegendTaxidermist <- {
	Profession = {
		Roots = [],
		Known = [::Legends.Profession.LegendSkinning],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]	
	}
};

::Legends.BackgroundProfessionTrees.LegendVala <- {
	Profession = {
		Roots = [::Legends.Profession.LegendScholar],
		Known = [],
		Special = [::Legends.Profession.LegendAncientKnowledge]
	}
};

::Legends.BackgroundProfessionTrees.LegendWarden <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyBeast, ::Legends.Profession.LegendFavouredEnemyOccult]
	}
};

::Legends.BackgroundProfessionTrees.LegendWarlock <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
};

::Legends.BackgroundProfessionTrees.LegendYoungblood <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = [::Legends.Profession.LegendFavouredEnemyOccult, ::Legends.Profession.LegendFavouredEnemyUndead]	
	}
};

// Horses

::Legends.BackgroundProfessionTrees.LegendHorse <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorseCourser <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorseDestrier <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorseRouncey <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}

::Legends.BackgroundProfessionTrees.LegendHorserider <- {
	Profession = {
		Roots = [],
		Known = [],
		Special = []	
	}
}
