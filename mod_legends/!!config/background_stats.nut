if (!("BackgroundsStats" in ::Legends)) {
	::Legends.BackgroundsStats <- {};
}

::Legends.BackgroundsStats.AdventurousNoble <- {
	Hitpoints = [-1, 4],
	Bravery = [15, 20],
	Stamina = [0, 5],
	MeleeSkill = [10, 15],
	RangedSkill = [0, 10],
	MeleeDefense = [3, 8],
	RangedDefense = [-5, -10],
	Initiative = [-2, -7]
}

::Legends.BackgroundsStats.Anatomist <- {
	Hitpoints = [-2, 0],
	Bravery = [12, 14],
	Stamina = [-5, 0],
	MeleeSkill = [5, 7],
	RangedSkill = [5, 9],
	MeleeDefense = [0, 1],
	RangedDefense = [0, 1],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Apprentice <- {
	Hitpoints = [0, 0],
	Bravery = [0, 0],
	Stamina = [0, 0],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Assassin <- {
	Hitpoints = [-3, -0],
	Bravery = [10, 10],
	Stamina = [-5, -5],
	MeleeSkill = [10, 12],
	RangedSkill = [5, 5],
	MeleeDefense = [5, 8],
	RangedDefense = [0, 0],
	Initiative = [20, 30]
}

::Legends.BackgroundsStats.AssassinSouthern <- {
	Hitpoints = [-5, -5],
	Bravery = [10, 10],
	Stamina = [-5, -5],
	MeleeSkill = [6, 8],
	RangedSkill = [10, 14],
	MeleeDefense = [3, 5],
	RangedDefense = [2, 5],
	Initiative = [20, 30]
}

::Legends.BackgroundsStats.Barbarian <- {
	Hitpoints = [5, 10],
	Bravery = [5, 10],
	Stamina = [5, 10],
	MeleeSkill = [5, 10],
	RangedSkill = [0, 3],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [5, 10]
}

::Legends.BackgroundsStats.Bastard <- {
	Hitpoints = [0, 0],
	Bravery = [-5, -5],
	Stamina = [0, 0],
	MeleeSkill = [5, 10],
	RangedSkill = [0, 0],
	MeleeDefense = [-5, 5],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.BeastSlayer <- {
	Hitpoints = [3, 5],
	Bravery = [10, 10],
	Stamina = [7, 12],
	MeleeSkill = [5, 7],
	RangedSkill = [6, 12],
	MeleeDefense = [1, 4],
	RangedDefense = [1, 2],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.Beggar <- {
	Hitpoints = [-4, -2],
	Bravery = [-10, -5],
	Stamina = [-10, -10],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [1, 4]
}

::Legends.BackgroundsStats.BeggarSouthern <- clone ::Legends.BackgroundsStats.Beggar;

::Legends.BackgroundsStats.BellyDancer <- {
	Hitpoints = [-5, -5],
	Bravery = [-5, -5],
	Stamina = [-5, -5],
	MeleeSkill = [7, 14],
	RangedSkill = [5, 10],
	MeleeDefense = [5, 10],
	RangedDefense = [5, 10],
	Initiative = [10, 20]
}

::Legends.BackgroundsStats.Bowyer <- {
	Hitpoints = [0, 0],
	Bravery = [0, 4],
	Stamina = [3, 5],
	MeleeSkill = [-5, 0],
	RangedSkill = [10, 10],
	MeleeDefense = [-2, 0],
	RangedDefense = [2, 3],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Brawler <- {
	Hitpoints = [6, 10],
	Bravery = [2, 5],
	Stamina = [7, 10],
	MeleeSkill = [3, 5],
	RangedSkill = [-6, -6],
	MeleeDefense = [1, 2],
	RangedDefense = [-3, 0],
	Initiative = [5, 15]
}

::Legends.BackgroundsStats.Butcher <- {
	Hitpoints = [0, 4],
	Bravery = [3, 5],
	Stamina = [0, 4],
	MeleeSkill = [4, 7],
	RangedSkill = [-3, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.ButcherSouthern <- clone ::Legends.BackgroundsStats.Butcher;

::Legends.BackgroundsStats.CaravanHand <- {
	Hitpoints = [3, 5],
	Bravery = [3, 3],
	Stamina = [5, 10],
	MeleeSkill = [0, 4],
	RangedSkill = [2, 5],
	MeleeDefense = [1, 3],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.CaravanHandSouthern <- clone ::Legends.BackgroundsStats.CaravanHand;

::Legends.BackgroundsStats.Companion <- {
	Hitpoints = [2, 7],
	Bravery = [10, 14],
	Stamina = [5, 5],
	MeleeSkill = [5, 8],
	RangedSkill = [5, 5],
	MeleeDefense = [5, 5],
	RangedDefense = [5, 5],
	Initiative = [-5, 0]
}

::Legends.BackgroundsStats.CompanionSouthern <- clone ::Legends.BackgroundsStats.Companion;

::Legends.BackgroundsStats.Companion2h <- {
	Hitpoints = [5, 10],
	Bravery = [10, 14],
	Stamina = [5, 5],
	MeleeSkill = [7, 12],
	RangedSkill = [0, 0],
	MeleeDefense = [5, 5],
	RangedDefense = [0, 2],
	Initiative = [-5, 0]
}

::Legends.BackgroundsStats.CompanionSouthern2h <- clone ::Legends.BackgroundsStats.Companion2h;

::Legends.BackgroundsStats.CompanionRanged <- {
	Hitpoints = [0, 0],
	Bravery = [8, 10],
	Stamina = [0, 0],
	MeleeSkill = [0, 5],
	RangedSkill = [10, 16],
	MeleeDefense = [1, 2],
	RangedDefense = [3, 6],
	Initiative = [12, 15]
}

::Legends.BackgroundsStats.CompanionSouthernRanged <- clone ::Legends.BackgroundsStats.CompanionRanged;

::Legends.BackgroundsStats.Cripple <- {
	Hitpoints = [-10, -7],
	Bravery = [0, 0],
	Stamina = [-5, 0],
	MeleeSkill = [-5, 0],
	RangedSkill = [-5, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-15, -10]
}

::Legends.BackgroundsStats.CrippleSouthern <- clone ::Legends.BackgroundsStats.Cripple;

::Legends.BackgroundsStats.Crucified <- {
	Hitpoints = [5, 5],
	Bravery = [5, 5],
	Stamina = [5, 5],
	MeleeSkill = [5, 7],
	RangedSkill = [12, 10],
	MeleeDefense = [5, 5],
	RangedDefense = [5, 5],
	Initiative = [5, 5]
}

::Legends.BackgroundsStats.Crusader <- {
	Hitpoints = [10, 10],
	Bravery = [15, 20],
	Stamina = [10, 10],
	MeleeSkill = [10, 10],
	RangedSkill = [-5, -10],
	MeleeDefense = [2, 4],
	RangedDefense = [-5, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Cultist <- {
	Hitpoints = [-3, 5],
	Bravery = [15, 20],
	Stamina = [-2, 8],
	MeleeSkill = [-5, 5],
	RangedSkill = [-5, 5],
	MeleeDefense = [-5, 5],
	RangedDefense = [-5, 5],
	Initiative = [0, 5]
}

::Legends.BackgroundsStats.ConvertedCultist <- clone ::Legends.BackgroundsStats.Cultist;

::Legends.BackgroundsStats.Daytaler <- {
	Hitpoints = [4, 8],
	Bravery = [-2, -3],
	Stamina = [10, 15],
	MeleeSkill = [1, 3],
	RangedSkill = [1, 4],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.DaytalerSouthern <- clone ::Legends.BackgroundsStats.Daytaler;

::Legends.BackgroundsStats.Deserter <- {
	Hitpoints = [0, 0],
	Bravery = [-15, -10],
	Stamina = [0, 0],
	MeleeSkill = [5, 5],
	RangedSkill = [0, 7],
	MeleeDefense = [3, 5],
	RangedDefense = [3, 5],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.DisownedNoble <- {
	Hitpoints = [-2, 3],
	Bravery = [-6, -1],
	Stamina = [-10, -5],
	MeleeSkill = [5, 15],
	RangedSkill = [0, 10],
	MeleeDefense = [-1, 4],
	RangedDefense = [-2, 3],
	Initiative = [-5, 5]
}

::Legends.BackgroundsStats.Eunuch <- {
	Hitpoints = [0, 0],
	Bravery = [5, 7],
	Stamina = [0, 0],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.EunuchSouthern <- clone ::Legends.BackgroundsStats.Eunuch;

::Legends.BackgroundsStats.Executioner <- {
	Hitpoints = [10, 7],
	Bravery = [12, 10],
	Stamina = [9, 14],
	MeleeSkill = [6, 8],
	RangedSkill = [-5, 0],
	MeleeDefense = [-5, 0],
	RangedDefense = [-5, -5],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.ExecutionerSouthern <- clone ::Legends.BackgroundsStats.Executioner;

::Legends.BackgroundsStats.Farmhand <- {
	Hitpoints = [7, 10],
	Bravery = [-3, -2],
	Stamina = [10, 20],
	MeleeSkill = [0, 4],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 4]
}

::Legends.BackgroundsStats.Fisherman <- {
	Hitpoints = [3, 5],
	Bravery = [-2, 2],
	Stamina = [2, 4],
	MeleeSkill = [3, 6],
	RangedSkill = [4, 9],
	MeleeDefense = [0, 2],
	RangedDefense = [0, 1],
	Initiative = [5, 10]
}

::Legends.BackgroundsStats.FishermanSouthern <- clone ::Legends.BackgroundsStats.Fisherman;

::Legends.BackgroundsStats.Flagellant <- {
	Hitpoints = [-10, -5],
	Bravery = [12, 12],
	Stamina = [5, 10],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Gambler <- {
	Hitpoints = [-2, -2],
	Bravery = [12, 12],
	Stamina = [-6, -5],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 2],
	RangedDefense = [2, 8],
	Initiative = [10, 12]
}

::Legends.BackgroundsStats.GamblerSouthern <- clone ::Legends.BackgroundsStats.Gambler;

::Legends.BackgroundsStats.Gladiator <- {
	Hitpoints = [3, 6],
	Bravery = [5, 5],
	Stamina = [7, 9],
	MeleeSkill = [10, 13],
	RangedSkill = [6, 8],
	MeleeDefense = [5, 8],
	RangedDefense = [5, 8],
	Initiative = [3, 8]
}

::Legends.BackgroundsStats.GladiatorOrigin <- clone ::Legends.BackgroundsStats.Gladiator;

::Legends.BackgroundsStats.Gravedigger <- {
	Hitpoints = [0, 4],
	Bravery = [5, 7],
	Stamina = [5, 7],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-5, 0]
}

::Legends.BackgroundsStats.Graverobber <- {
	Hitpoints = [0, 0],
	Bravery = [5, 8],
	Stamina = [5, 5],
	MeleeSkill = [0, 3],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 1],
	RangedDefense = [0, 1],
	Initiative = [0, 4]
}

::Legends.BackgroundsStats.HedgeKnight <- {
	Hitpoints = [12, 13],
	Bravery = [4, 9],
	Stamina = [10, 15],
	MeleeSkill = [10, 11],
	RangedSkill = [0, 0],
	MeleeDefense = [9, 12],
	RangedDefense = [0, 0],
	Initiative = [-14, -7]
}

::Legends.BackgroundsStats.Historian <- {
	Hitpoints = [-5, -2],
	Bravery = [15, 20],
	Stamina = [-5, -5],
	MeleeSkill = [-3, 1],
	RangedSkill = [-3, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [5, 8]
}

::Legends.BackgroundsStats.HistorianSouthern <- clone ::Legends.BackgroundsStats.Historian;

::Legends.BackgroundsStats.Houndmaster <- {
	Hitpoints = [0, 5],
	Bravery = [5, 5],
	Stamina = [0, 5],
	MeleeSkill = [0, 0],
	RangedSkill = [3, 6],
	MeleeDefense = [3, 3],
	RangedDefense = [1, 2],
	Initiative = [12, 18]
}

::Legends.BackgroundsStats.Hunter <- {
	Hitpoints = [0, 0],
	Bravery = [0, 5],
	Stamina = [5, 7],
	MeleeSkill = [0, 0],
	RangedSkill = [17, 20],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 3],
	Initiative = [0, 5]
}

::Legends.BackgroundsStats.Juggler <- {
	Hitpoints = [-6, 3],
	Bravery = [0, -3],
	Stamina = [5, 10],
	MeleeSkill = [2, 4],
	RangedSkill = [8, 3],
	MeleeDefense = [-3, 1],
	RangedDefense = [3, 5],
	Initiative = [10, 12]
}

::Legends.BackgroundsStats.JugglerSouthern <- clone ::Legends.BackgroundsStats.Juggler;

::Legends.BackgroundsStats.KillerOnTheRun <- {
	Hitpoints = [0, 0],
	Bravery = [-5, -5],
	Stamina = [0, 0],
	MeleeSkill = [3, 6],
	RangedSkill = [3, 5],
	MeleeDefense = [1, 3],
	RangedDefense = [-3, 0],
	Initiative = [0, 5]
}

::Legends.BackgroundsStats.KingsGuard <- clone ::Legends.BackgroundsStats.Beggar;

::Legends.BackgroundsStats.LindwurmSlayer <- {
	Hitpoints = [16, 20],
	Bravery = [15, 17],
	Stamina = [6, 12],
	MeleeSkill = [14, 18],
	RangedSkill = [8, 10],
	MeleeDefense = [5, 7],
	RangedDefense = [-6, -4],
	Initiative = [11, 15]
}

::Legends.BackgroundsStats.Lumberjack <- {
	Hitpoints = [10, 10],
	Bravery = [0, 5],
	Stamina = [10, 15],
	MeleeSkill = [6, 8],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Manhunter <- {
	Hitpoints = [3, 6],
	Bravery = [7, 9],
	Stamina = [3, 5],
	MeleeSkill = [8, 12],
	RangedSkill = [7, 14],
	MeleeDefense = [4, 8],
	RangedDefense = [-1, -1],
	Initiative = [5, 12]
}

::Legends.BackgroundsStats.Mason <- {
	Hitpoints = [0, 0],
	Bravery = [5, 7],
	Stamina = [5, 5],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Messenger <- {
	Hitpoints = [0, 0],
	Bravery = [0, 5],
	Stamina = [10, 15],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 2],
	RangedDefense = [3, 3],
	Initiative = [15, 21]
}

::Legends.BackgroundsStats.Militia <- {
	Hitpoints = [4, 8],
	Bravery = [3, 5],
	Stamina = [3, 5],
	MeleeSkill = [5, 9],
	RangedSkill = [5, 6],
	MeleeDefense = [2, 2],
	RangedDefense = [2, 2],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.Miller <- {
	Hitpoints = [-1, 4],
	Bravery = [0, 0],
	Stamina = [5, 8],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Miner <- {
	Hitpoints = [10, 10],
	Bravery = [2, 5],
	Stamina = [-14, -8],
	MeleeSkill = [3, 7],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Minstrel <- {
	Hitpoints = [-5, -5],
	Bravery = [10, 15],
	Stamina = [0, 6],
	MeleeSkill = [5, 5],
	RangedSkill = [0, 0],
	MeleeDefense = [3, 6],
	RangedDefense = [0, 3],
	Initiative = [5, 5]
}

::Legends.BackgroundsStats.Monk <- {
	Hitpoints = [0, 0],
	Bravery = [11, 11],
	Stamina = [-10, 0],
	MeleeSkill = [-5, -5],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.MonkTurnedFlagellant <- clone ::Legends.BackgroundsStats.Monk;

::Legends.BackgroundsStats.Nomad <- {
	Hitpoints = [0, 0],
	Bravery = [-3, 0],
	Stamina = [0, 2],
	MeleeSkill = [10, 12],
	RangedSkill = [0, 5],
	MeleeDefense = [5, 6],
	RangedDefense = [5, 6],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.NomadRanged <- {
	Hitpoints = [0, 0],
	Bravery = [-3, 0],
	Stamina = [0, 2],
	MeleeSkill = [3, 5],
	RangedSkill = [14, 15],
	MeleeDefense = [3, 5],
	RangedDefense = [5, 6],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.OrcSlayer <- {
	Hitpoints = [10, 10],
	Bravery = [15, 20],
	Stamina = [10, 10],
	MeleeSkill = [10, 10],
	RangedSkill = [-10, -5],
	MeleeDefense = [0, 0],
	RangedDefense = [-5, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.PacifiedFlagellant <- clone ::Legends.BackgroundsStats.Flagellant;

::Legends.BackgroundsStats.Paladin <- {
	Hitpoints = [8, 10],
	Bravery = [14, 18],
	Stamina = [9, 16],
	MeleeSkill = [9, 13],
	RangedSkill = [0, 0],
	MeleeDefense = [8, 12],
	RangedDefense = [-4, 1],
	Initiative = [-15, -6]
};

::Legends.BackgroundsStats.PaladinOld <- clone ::Legends.BackgroundsStats.Paladin;

::Legends.BackgroundsStats.Peddler <- {
	Hitpoints = [0, 0],
	Bravery = [0, 0],
	Stamina = [0, 0],
	MeleeSkill = [-10, -9],
	RangedSkill = [0, 0],
	MeleeDefense = [2, 7],
	RangedDefense = [2, 7],
	Initiative = [0, 7]
}

::Legends.BackgroundsStats.PeddlerSouthern <- clone ::Legends.BackgroundsStats.Peddler;

::Legends.BackgroundsStats.Pimp <- {
	Hitpoints = [0, 0],
	Bravery = [5, 5],
	Stamina = [0, 0],
	MeleeSkill = [-5, -5],
	RangedSkill = [0, 0],
	MeleeDefense = [2, 7],
	RangedDefense = [2, 7],
	Initiative = [0, 7]
}

::Legends.BackgroundsStats.Poacher <- {
	Hitpoints = [0, 0],
	Bravery = [0, 5],
	Stamina = [0, 3],
	MeleeSkill = [0, 2],
	RangedSkill = [7, 15],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 4]
}

::Legends.BackgroundsStats.Raider <- {
	Hitpoints = [0, 0],
	Bravery = [-3, 0],
	Stamina = [0, 2],
	MeleeSkill = [10, 12],
	RangedSkill = [0, 5],
	MeleeDefense = [5, 6],
	RangedDefense = [5, 6],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Ratcatcher <- {
	Hitpoints = [-5, -5],
	Bravery = [0, 0],
	Stamina = [0, 0],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [3, 8],
	Initiative = [15, 18]
}

::Legends.BackgroundsStats.Refugee <- {
	Hitpoints = [-8, 8],
	Bravery = [-5, -5],
	Stamina = [5, 7],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 1],
	RangedDefense = [0, 1],
	Initiative = [-5, 12]
}

::Legends.BackgroundsStats.RegentInAbsentia <- {
	Hitpoints = [3, -2],
	Bravery = [4, 14],
	Stamina = [-10, -5],
	MeleeSkill = [5, 15],
	RangedSkill = [0, 10],
	MeleeDefense = [1, 8],
	RangedDefense = [1, 8],
	Initiative = [1, 15]
}

::Legends.BackgroundsStats.RetiredSoldier <- {
	Hitpoints = [-15, -10],
	Bravery = [10, 13],
	Stamina = [-10, -10],
	MeleeSkill = [10, 13],
	RangedSkill = [5, 0],
	MeleeDefense = [5, 8],
	RangedDefense = [5, 8],
	Initiative = [-10, -5]
}

::Legends.BackgroundsStats.Sellsword <- {
	Hitpoints = [0, 0],
	Bravery = [5, 5],
	Stamina = [0, 0],
	MeleeSkill = [10, 13],
	RangedSkill = [10, 12],
	MeleeDefense = [5, 8],
	RangedDefense = [5, 8],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Servant <- {
	Hitpoints = [-7, -2],
	Bravery = [-5, -5],
	Stamina = [-7, -2],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [2, 0],
	Initiative = [5, 0]
}

::Legends.BackgroundsStats.Shepherd <- {
	Hitpoints = [0, 0],
	Bravery = [0, 5],
	Stamina = [3, 8],
	MeleeSkill = [0, 0],
	RangedSkill = [5, 7],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [2, 5]
}

::Legends.BackgroundsStats.ShepherdSouthern <- clone ::Legends.BackgroundsStats.Shepherd;

::Legends.BackgroundsStats.Slave <- {
	Hitpoints = [5, 10],
	Bravery = [-5, 0],
	Stamina = [5, 10],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.SlaveBarbarian <- {
	Hitpoints = [8, 12],
	Bravery = [-5, 0],
	Stamina = [8, 12],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.SlaveSouthern <- {
	Hitpoints = [5, 10],
	Bravery = [-5, 0],
	Stamina = [5, 10],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.Squire <- {
	Hitpoints = [2, 5],
	Bravery = [12, 12],
	Stamina = [5, 7],
	MeleeSkill = [5, 7],
	RangedSkill = [7, 8],
	MeleeDefense = [1, 3],
	RangedDefense = [1, 3],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.Swordmaster <- {
	Hitpoints = [-12, -12],
	Bravery = [10, 12],
	Stamina = [-15, -10],
	MeleeSkill = [25, 20],
	RangedSkill = [-5, -5],
	MeleeDefense = [10, 15],
	RangedDefense = [0, 0],
	Initiative = [-10, -10]
}

::Legends.BackgroundsStats.Tailor <- {
	Hitpoints = [-2, 2],
	Bravery = [0, 0],
	Stamina = [-5, 0],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 5]
}

::Legends.BackgroundsStats.TailorSouthern <- clone ::Legends.BackgroundsStats.Tailor;

::Legends.BackgroundsStats.Thief <- {
	Hitpoints = [0, 0],
	Bravery = [0, 5],
	Stamina = [0, 0],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [5, 8],
	RangedDefense = [5, 8],
	Initiative = [10, 12]
}

::Legends.BackgroundsStats.ThiefSouthern <- clone ::Legends.BackgroundsStats.Thief;

::Legends.BackgroundsStats.Vagabond <- {
	Hitpoints = [-5, 10],
	Bravery = [-7, -5],
	Stamina = [10, 15],
	MeleeSkill = [-5, 5],
	RangedSkill = [-3, 8],
	MeleeDefense = [-5, 5],
	RangedDefense = [-5, 8],
	Initiative = [0, 20]
}

::Legends.BackgroundsStats.Wildman <- {
	Hitpoints = [10, 12],
	Bravery = [10, 12],
	Stamina = [18, 23],
	MeleeSkill = [0, 6],
	RangedSkill = [-5, 0],
	MeleeDefense = [-5, 0],
	RangedDefense = [-5, -5],
	Initiative = [-5, 8]
}

::Legends.BackgroundsStats.Witchhunter <- {
	Hitpoints = [0, 0],
	Bravery = [12, 16],
	Stamina = [0, 0],
	MeleeSkill = [6, 10],
	RangedSkill = [8, 15],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [5, 12]
}

::Legends.BackgroundsStats.LegendAdventurousNobleRanged <- {
	Hitpoints = [-1, 4],
	Bravery = [15, 20],
	Stamina = [0, 5],
	MeleeSkill = [0, 5],
	RangedSkill = [15, 25],
	MeleeDefense = [-5, 3],
	RangedDefense = [2, 5],
	Initiative = [-2, 3]
}

::Legends.BackgroundsStats.LegendAlchemist <- {
	Hitpoints = [-5, -5],
	Bravery = [8, 12],
	Stamina = [-5, -5],
	MeleeSkill = [-5, 2],
	RangedSkill = [6, 8],
	MeleeDefense = [0, 0],
	RangedDefense = [1, 3],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendCommanderAssassin <- {
	Hitpoints = [5, 10],
	Bravery = [0, 0],
	Stamina = [0, 0],
	MeleeSkill = [15, 15],
	RangedSkill = [4, 8],
	MeleeDefense = [8, 12],
	RangedDefense = [8, 12],
	Initiative = [15, 15]
}

::Legends.BackgroundsStats.LegendBattleSister <- {
	Hitpoints = [5, 7],
	Bravery = [14, 18],
	Stamina = [5, 10],
	MeleeSkill = [6, 10],
	RangedSkill = [-10, -5],
	MeleeDefense = [3, 5],
	RangedDefense = [-5, 0],
	Initiative = [5, 10]
}

::Legends.BackgroundsStats.LegendCommanderBeggar <- {
	Hitpoints = [-20, -20],
	Bravery = [-20, -15],
	Stamina = [-20, -20],
	MeleeSkill = [-5, -5],
	RangedSkill = [-5, -5],
	MeleeDefense = [-5, -5],
	RangedDefense = [-5, -5],
	Initiative = [20, 20]
}

::Legends.BackgroundsStats.LegendCommanderBeggarScaling <- clone ::Legends.BackgroundsStats.LegendCommanderBeggar;

::Legends.BackgroundsStats.LegendBellyDancer <- {
	Hitpoints = [-5, -5],
	Bravery = [-5, -5],
	Stamina = [-5, -5],
	MeleeSkill = [2, 5],
	RangedSkill = [5, 5],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendBerserker <- {
	Hitpoints = [15, 15],
	Bravery = [5, 5],
	Stamina = [15, 15],
	MeleeSkill = [20, 20],
	RangedSkill = [-5, -5],
	MeleeDefense = [10, 10],
	RangedDefense = [-5, -5],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.LegendCommanderBerserker <- {
	Hitpoints = [20, 25],
	Bravery = [5, 10],
	Stamina = [15, 20],
	MeleeSkill = [20, 25],
	RangedSkill = [0, 0],
	MeleeDefense = [10, 10],
	RangedDefense = [-5, -5],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.LegendBlacksmith <- {
	Hitpoints = [5, 9],
	Bravery = [0, 0],
	Stamina = [15, 20],
	MeleeSkill = [5, 8],
	RangedSkill = [-10, -10],
	MeleeDefense = [0, 3],
	RangedDefense = [-5, -5],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendBladedancer <- {
	Hitpoints = [3, 7],
	Bravery = [7, 10],
	Stamina = [10, 15],
	MeleeSkill = [15, 20],
	RangedSkill = [-10, -10],
	MeleeDefense = [4, 6],
	RangedDefense = [0, 1],
	Initiative = [15, 25]
}

::Legends.BackgroundsStats.LegendBountyHunter <- {
	Hitpoints = [5, 7],
	Bravery = [8, 10],
	Stamina = [10, 14],
	MeleeSkill = [5, 8],
	RangedSkill = [10, 14],
	MeleeDefense = [5, 9],
	RangedDefense = [5, 5],
	Initiative = [20, 20]
}

::Legends.BackgroundsStats.LegendCompanionMelee <- {
	Hitpoints = [5, 5],
	Bravery = [5, 7],
	Stamina = [8, 4],
	MeleeSkill = [4, 6],
	RangedSkill = [-5, -3],
	MeleeDefense = [5, 3],
	RangedDefense = [-4, 0],
	Initiative = [-5, 0]
}

::Legends.BackgroundsStats.LegendCompanionRanged <- {
	Hitpoints = [3, 0],
	Bravery = [5, 7],
	Stamina = [9, 5],
	MeleeSkill = [0, 0],
	RangedSkill = [6, 9],
	MeleeDefense = [-3, 0],
	RangedDefense = [4, 5],
	Initiative = [9, 5]
}

::Legends.BackgroundsStats.LegendConscript <- {
	Hitpoints = [8, 8],
	Bravery = [10, 5],
	Stamina = [4, 0],
	MeleeSkill = [7, 10],
	RangedSkill = [0, 5],
	MeleeDefense = [5, 10],
	RangedDefense = [5, 2],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendConscriptRanged <- {
	Hitpoints = [8, 8],
	Bravery = [6, 2],
	Stamina = [5, 5],
	MeleeSkill = [5, 3],
	RangedSkill = [15, 12],
	MeleeDefense = [2, 0],
	RangedDefense = [6, 8],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendCrusader <- {
	Hitpoints = [10, 10],
	Bravery = [10, 10],
	Stamina = [10, 10],
	MeleeSkill = [10, 10],
	RangedSkill = [-5, -5],
	MeleeDefense = [15, 15],
	RangedDefense = [0, 0],
	Initiative = [-20, -20]
}

::Legends.BackgroundsStats.LegendDisownedNobleRanged <- {
	Hitpoints = [-2, 3],
	Bravery = [-6, -1],
	Stamina = [-10, -5],
	MeleeSkill = [0, 10],
	RangedSkill = [5, 15],
	MeleeDefense = [-3, 2],
	RangedDefense = [0, 5],
	Initiative = [5, 10]
}

::Legends.BackgroundsStats.LegendDervish <- {
	Hitpoints = [15, 25],
	Bravery = [15, 20],
	Stamina = [10, 14],
	MeleeSkill = [6, 10],
	RangedSkill = [0, 3],
	MeleeDefense = [-3, 2],
	RangedDefense = [-2, -2],
	Initiative = [10, 16]
}

::Legends.BackgroundsStats.LegendDonkey <- {
	Hitpoints = [95, 125],
	Bravery = [-5, 0],
	Stamina = [50, 75],
	MeleeSkill = [-10, 4],
	RangedSkill = [-50, -50],
	MeleeDefense = [-7, -2],
	RangedDefense = [-5, -1],
	Initiative = [-15, -5]
}

::Legends.BackgroundsStats.LegendDruid <- {
	Hitpoints = [0, 0],
	Bravery = [0, 0],
	Stamina = [5, 10],
	MeleeSkill = [-10, 0],
	RangedSkill = [-10, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendGladiatorPrizefighter <- {
	Hitpoints = [14, 15],
	Bravery = [5, 5],
	Stamina = [10, 15],
	MeleeSkill = [9, 11],
	RangedSkill = [3, 6],
	MeleeDefense = [5, 8],
	RangedDefense = [0, 3],
	Initiative = [5, 8]
}

::Legends.BackgroundsStats.LegendGuildmaster <- {
	Hitpoints = [-5, 0],
	Bravery = [13, 17],
	Stamina = [0, 5],
	MeleeSkill = [10, 14],
	RangedSkill = [9, 13],
	MeleeDefense = [3, 4],
	RangedDefense = [2, 4],
	Initiative = [5, 10]
}

::Legends.BackgroundsStats.LegendHerbalist <- {
	Hitpoints = [-5, -5],
	Bravery = [0, 0],
	Stamina = [5, 0],
	MeleeSkill = [5, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendHorse <- {
	Hitpoints = [100, 120],
	Bravery = [0, 0],
	Stamina = [40, 50],
	MeleeSkill = [0, 0],
	RangedSkill = [-20, -20],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendHorseCourser <- {
	Hitpoints = [100, 120],
	Bravery = [0, 0],
	Stamina = [40, 50],
	MeleeSkill = [0, 0],
	RangedSkill = [-20, -20],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendHorseDestrier <- {
	Hitpoints = [125, 145],
	Bravery = [10, 15],
	Stamina = [55, 65],
	MeleeSkill = [10, 10],
	RangedSkill = [-20, -20],
	MeleeDefense = [10, 10],
	RangedDefense = [0, 0],
	Initiative = [-5, -10]
}

::Legends.BackgroundsStats.LegendHorseRouncey <- {
	Hitpoints = [100, 120],
	Bravery = [-10, -10],
	Stamina = [40, 50],
	MeleeSkill = [0, 0],
	RangedSkill = [-20, -20],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [-10, -10]
}

::Legends.BackgroundsStats.LegendHorserider <- {
	Hitpoints = [100, 120],
	Bravery = [0, 0],
	Stamina = [40, 50],
	MeleeSkill = [0, 0],
	RangedSkill = [-20, -20],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendHusk <- {
	Hitpoints = [10, 14],
	Bravery = [-8, -5],
	Stamina = [10, 15],
	MeleeSkill = [10, 14],
	RangedSkill = [-10, 0],
	MeleeDefense = [0, 3],
	RangedDefense = [0, 1],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendIllusionist <- {
	Hitpoints = [-15, -20],
	Bravery = [15, 10],
	Stamina = [0, 5],
	MeleeSkill = [-10, -10],
	RangedSkill = [20, 15],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendInventor <- {
	Hitpoints = [0, 0],
	Bravery = [0, 0],
	Stamina = [0, 0],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 5],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendIronmonger <- {
	Hitpoints = [3, 5],
	Bravery = [0, 0],
	Stamina = [5, 10],
	MeleeSkill = [2, 3],
	RangedSkill = [-5, -5],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendLeechPeddler <- {
	Hitpoints = [0, 5],
	Bravery = [-3, -1],
	Stamina = [0, 6],
	MeleeSkill = [0, 5],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 5]
}

::Legends.BackgroundsStats.LegendLegionAuxiliary <- {
	Hitpoints = [-1, 4],
	Bravery = [0, 5], //not needed except for resisting charm and sleep
	Stamina = [10, 10], //not needed except for equipment weight
	MeleeSkill = [1, 3],
	RangedSkill = [9, 14],
	MeleeDefense = [0, 2],
	RangedDefense = [1, 4],
	Initiative = [20, 30]
}

::Legends.BackgroundsStats.LegendLegionCenturion <- {
	Hitpoints = [10, 12],
	Bravery = [20, 25], //not needed except for resisting charm and sleep
	Stamina = [20, 25], //not needed except for equipment weight
	MeleeSkill = [8, 10],
	RangedSkill = [4, 7],
	MeleeDefense = [5, 8],
	RangedDefense = [3, 6],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendLegionGladiator <- {
	Hitpoints = [20, 30],
	Bravery = [5, 10], //not needed except for resisting charm and sleep
	Stamina = [10, 15], //not needed except for equipment weight
	MeleeSkill = [12, 16],
	RangedSkill = [10, 18],
	MeleeDefense = [5, 8],
	RangedDefense = [4, 7],
	Initiative = [20, 30]
}

::Legends.BackgroundsStats.LegendLegionHonourGuard <- {
	Hitpoints = [3, 6],
	Bravery = [10, 15], //not needed except for resisting charm and sleep
	Stamina = [20, 20], //not needed except for equipment weight
	MeleeSkill = [5, 8],
	RangedSkill = [2, 4],
	MeleeDefense = [4, 7],
	RangedDefense = [1, 2],
	Initiative = [-2, 1]
}

::Legends.BackgroundsStats.LegendLegionLegate <- {
	Hitpoints = [12, 16],
	Bravery = [20, 25], //not needed except for resisting charm and sleep
	Stamina = [20, 25], //not needed except for equipment weight
	MeleeSkill = [15, 20],
	RangedSkill = [5, 9],
	MeleeDefense = [9, 15],
	RangedDefense = [3, 6],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendLegionLegionary <- {
	Hitpoints = [1, 3],
	Bravery = [5, 10], //not needed except for resisting charm and sleep
	Stamina = [15, 15], //not needed except for equipment weight
	MeleeSkill = [2, 5],
	RangedSkill = [5, 9],
	MeleeDefense = [2, 4],
	RangedDefense = [3, 6],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendLegionPrefect <- {
	Hitpoints = [5, 10],
	Bravery = [20, 25], //not needed except for resisting charm and sleep
	Stamina = [20, 25], //not needed except for equipment weight
	MeleeSkill = [8, 10],
	RangedSkill = [4, 7],
	MeleeDefense = [5, 8],
	RangedDefense = [3, 6],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendLegionSlave <- {
	Hitpoints = [-3, 7],
	Bravery = [0, 0], //not needed except for resisting charm and sleep
	Stamina = [0, 5], //not needed except for equipment weight
	MeleeSkill = [-2, 1],
	RangedSkill = [4, 8],
	MeleeDefense = [-1, 2],
	RangedDefense = [0, 2],
	Initiative = [-4, 3]
}

::Legends.BackgroundsStats.LegendLonewolf <- {
	Hitpoints = [12, 16],
	Bravery = [8, 12],
	Stamina = [12, 18],
	MeleeSkill = [10, 14],
	RangedSkill = [10, 16],
	MeleeDefense = [6, 9], // nice
	RangedDefense = [6, 7],
	Initiative = [5, 15]
}

::Legends.BackgroundsStats.LegendLurker <- {
	Hitpoints = [-5, -3],
	Bravery = [5, 10],
	Stamina = [0, 10],
	MeleeSkill = [2, 5],
	RangedSkill = [7, 12],
	MeleeDefense = [-5, 2],
	RangedDefense = [1, 3],
	Initiative = [8, 16]
}

::Legends.BackgroundsStats.LegendMagister <- {
	Hitpoints = [-5, 5],
	Bravery = [15, 25],
	Stamina = [-4, 6],
	MeleeSkill = [5, 10],
	RangedSkill = [5, 8],
	MeleeDefense = [-2, 5],
	RangedDefense = [2, 5],
	Initiative = [-5, 5]
}

::Legends.BackgroundsStats.LegendManAtArms <- {
	Hitpoints = [0, 0],
	Bravery = [8, 15],
	Stamina = [5, 10],
	MeleeSkill = [7, 11],
	RangedSkill = [7, 7],
	MeleeDefense = [5, 8],
	RangedDefense = [2, 4],
	Initiative = [-10, -5]
}

::Legends.BackgroundsStats.LegendMasterArcher <- {
	Hitpoints = [0, 0],
	Bravery = [0, 5],
	Stamina = [5, 7],
	MeleeSkill = [-5, -5],
	RangedSkill = [23, 27],
	MeleeDefense = [-6, -3],
	RangedDefense = [6, 10],
	Initiative = [8, 14]
}

::Legends.BackgroundsStats.LegendMuladi <- {
	Hitpoints = [0, 0],
	Bravery = [5, 5],
	Stamina = [2, 5],
	MeleeSkill = [-3, 0],
	RangedSkill = [12, 16],
	MeleeDefense = [0, 0],
	RangedDefense = [2, 5],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendNecro <- {
	Hitpoints = [15, 20],
	Bravery = [-10, -5],
	Stamina = [5, 5],
	MeleeSkill = [5, 10],
	RangedSkill = [-5, -5],
	MeleeDefense = [-5, -5],
	RangedDefense = [-10, -5],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendCommanderNecro <- {
	Hitpoints = [20, 25],
	Bravery = [15, 20],
	Stamina = [5, 8],
	MeleeSkill = [2, 6],
	RangedSkill = [10, 18],
	MeleeDefense = [2, 5],
	RangedDefense = [3, 6],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendNecromancer <- {
	Hitpoints = [15, 20],
	Bravery = [-10, -5],
	Stamina = [5, 5],
	MeleeSkill = [5, 10],
	RangedSkill = [-5, -5],
	MeleeDefense = [-5, -5],
	RangedDefense = [-10, -5],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendNecrosavant <- {
	Hitpoints = [15, 20],
	Bravery = [-10, -5],
	Stamina = [5, 5],
	MeleeSkill = [5, 10],
	RangedSkill = [-5, -5],
	MeleeDefense = [-5, -5],
	RangedDefense = [-10, -5],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendNightwatch <- {
	Hitpoints = [4, 8],
	Bravery = [6, 8],
	Stamina = [8, 12],
	MeleeSkill = [0, 4],
	RangedSkill = [0, 8],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendCommanderNoble <- {
	Hitpoints = [-15, -15],
	Bravery = [25, 25],
	Stamina = [-10, -10],
	MeleeSkill = [10, 10],
	RangedSkill = [0, 0],
	MeleeDefense = [5, 5],
	RangedDefense = [15, 15],
	Initiative = [-20, -20]
}

::Legends.BackgroundsStats.LegendHouseGuard <- {
	Hitpoints = [5, 10],
	Bravery = [5, 5],
	Stamina = [5, 5],
	MeleeSkill = [12, 17],
	RangedSkill = [-5, -5],
	MeleeDefense = [3, 6],
	RangedDefense = [2, 4],
	Initiative = [-5, -10]
}

::Legends.BackgroundsStats.LegendArbalester <- {
	Hitpoints = [-5, 0],
	Bravery = [5, 5],
	Stamina = [0, 0],
	MeleeSkill = [3, 6],
	RangedSkill = [23, 20],
	MeleeDefense = [3, 6],
	RangedDefense = [8, 12],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.LegendFootSoldier <- {
	Hitpoints = [5, 5],
	Bravery = [10, 5],
	Stamina = [3, 3],
	MeleeSkill = [10, 10],
	RangedSkill = [-5, 0],
	MeleeDefense = [5, 10],
	RangedDefense = [5, 5],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.LegendCommanderPeddler <- {
	Hitpoints = [-8, -5],
	Bravery = [-5, -5],
	Stamina = [-5, -5],
	MeleeSkill = [-5, 0],
	RangedSkill = [-5, 0],
	MeleeDefense = [4, 8],
	RangedDefense = [3, 9],
	Initiative = [0, 7]
}

::Legends.BackgroundsStats.LegendPilgrim <- {
	Hitpoints = [-8, 8],
	Bravery = [10, 20],
	Stamina = [-8, 8],
	MeleeSkill = [-8, 8],
	RangedSkill = [-8, 8],
	MeleeDefense = [-5, 5],
	RangedDefense = [-5, 5],
	Initiative = [-6, 12]
}

::Legends.BackgroundsStats.LegendPreserver <- {
	Hitpoints = [-5, -5],
	Bravery = [7, 13],
	Stamina = [0, 5],
	MeleeSkill = [0, 0],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [10, 20]
}

::Legends.BackgroundsStats.LegendPuppet <- {
	Hitpoints = [5, 15],
	Bravery = [0, 0],
	Stamina = [5, 8],
	MeleeSkill = [-4, 0],
	RangedSkill = [-15, 0],
	MeleeDefense = [-5, 2],
	RangedDefense = [-5, -5],
	Initiative = [-10, 0]
}

::Legends.BackgroundsStats.LegendPuppetMaster <- {
	Hitpoints = [5, 5],
	Bravery = [-15, -10],
	Stamina = [10, 10],
	MeleeSkill = [5, 5],
	RangedSkill = [10, 10],
	MeleeDefense = [-5, 0],
	RangedDefense = [-5, 0],
	Initiative = [5, 5]
}

::Legends.BackgroundsStats.LegendRanger <- {
	Hitpoints = [-5, -5],
	Bravery = [0, 0],
	Stamina = [5, 10],
	MeleeSkill = [5, 5],
	RangedSkill = [15, 23],
	MeleeDefense = [-5, 0],
	RangedDefense = [3, 6],
	Initiative = [15, 20]
}

::Legends.BackgroundsStats.LegendCommanderRanger <- {
	Hitpoints = [-5, -5],
	Bravery = [0, 0],
	Stamina = [15, 15],
	MeleeSkill = [0, 5],
	RangedSkill = [20, 25],
	MeleeDefense = [-5, 0],
	RangedDefense = [5, 5],
	Initiative = [-5, -5]
}

::Legends.BackgroundsStats.LegendShieldmaiden <- {
	Hitpoints = [7, 10],
	Bravery = [6, 8],
	Stamina = [8, 12],
	MeleeSkill = [4, 6],
	RangedSkill = [6, 10],
	MeleeDefense = [8, 12],
	RangedDefense = [4, 7],
	Initiative = [-15, -7]
}

::Legends.BackgroundsStats.LegendSurgeon <- {
	Hitpoints = [-5, 0],
	Bravery = [10, 10],
	Stamina = [-5, -5],
	MeleeSkill = [5, 5],
	RangedSkill = [-5, 0],
	MeleeDefense = [-3, -3],
	RangedDefense = [0, 0],
	Initiative = [0, 0]
}

::Legends.BackgroundsStats.LegendTaxidermist <- {
	Hitpoints = [-3, 0],
	Bravery = [5, 5],
	Stamina = [0, 0],
	MeleeSkill = [5, 10],
	RangedSkill = [0, 0],
	MeleeDefense = [0, 0],
	RangedDefense = [0, 0],
	Initiative = [0, 5]
}

::Legends.BackgroundsStats.LegendVala <- {
	Hitpoints = [-1, 2],
	Bravery = [10, 15],
	Stamina = [8, 12],
	MeleeSkill = [0, 3],
	RangedSkill = [0, 0],
	MeleeDefense = [-1, 3],
	RangedDefense = [-2, 4],
	Initiative = [10, 15]
}

::Legends.BackgroundsStats.LegendWarlock <- {
	Hitpoints = [15, 20],
	Bravery = [-10, -5],
	Stamina = [5, 5],
	MeleeSkill = [5, 10],
	RangedSkill = [-5, -5],
	MeleeDefense = [-5, -5],
	RangedDefense = [-10, -5],
	Initiative = [10, 10]
}

::Legends.BackgroundsStats.LegendWarlockSummoner <- {
	Hitpoints = [-10, -5],
	Bravery = [5, 10],
	Stamina = [-10, -5],
	MeleeSkill = [-2, 0],
	RangedSkill = [-4, -2],
	MeleeDefense = [4, 6],
	RangedDefense = [5, 7],
	Initiative = [-15, -5]
}

::Legends.BackgroundsStats.LegendSeer <- {
	Hitpoints = [-10, -10],
	Bravery = [5, 5],
	Stamina = [15, 20],
	MeleeSkill = [-5, -5],
	RangedSkill = [15, 20],
	MeleeDefense = [-10, -10],
	RangedDefense = [-5, -5],
	Initiative = [20, 25]
}

::Legends.BackgroundsStats.LegendYoungblood <- {
	Hitpoints = [4, 4],
	Bravery = [10, 15],
	Stamina = [5, 5],
	MeleeSkill = [3, 3],
	RangedSkill = [5, 10],
	MeleeDefense = [0, 4],
	RangedDefense = [0, 4],
	Initiative = [5, 8]
}
