if (!("BackgroundModifiers" in ::Legends)) {
	::Legends.BackgroundModifiers <- {};
}

::Legends.BackgroundModifiers.AdventurousNoble <- {
	ArmorParts = 13,
	Healing = 0.10,
	Injury = 0.03,
	Repair = 0.10,
	Training = 0.2,
};

::Legends.BackgroundModifiers.LegendAdventurousNobleRanged <- clone ::Legends.BackgroundModifiers.AdventurousNoble;

::Legends.BackgroundModifiers.Anatomist <- {
	Meds = 34,
	Healing = 0.30,
	Injury = 0.06,
	Gathering = 0.30,
	MedConsumption = 0.05,
	Terrain = {
		Swamp = 0.02,
		Hills = 0.03,
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Mountains = 0.01
	}
};

::Legends.BackgroundModifiers.Apprentice <- {
	Salvage = 0.10,
	Crafting = 0.50,
	Haggle = 0.0,
	ToolConsumption = 0.01,
	Repair = 0.30,
};

::Legends.BackgroundModifiers.Assassin <- {
	Scout = 0.3,
	Training = 0.1,
};

::Legends.BackgroundModifiers.AssassinSouthern <- {
	Scout = 0.3,
	Terrain = {
		Badlands = 0.02,
		Steppe = 0.04,
		Desert = 0.05,
		Oasis = 0.05
	}
};

::Legends.BackgroundModifiers.Barbarian <- {
	Training = 0.2,
	Scout = 0.2,
	Gathering = 0.50,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Snow = 0.05,
		Tundra = 0.05
	}
};

::Legends.BackgroundModifiers.Bastard <- {
	Repair = 0.10,
	Healing = 0.10,
	Training = 0.2,
};

::Legends.BackgroundModifiers.BeastSlayer <- {
	Gathering = 0.50,
	Crafting = 0.75,
	Scout = 0.2,
	Terrain = {
		Swamp = 0.025,
		Forest = 0.025,
		SnowyForest = 0.025,
		LeaveForest = 0.025,
		AutumnForest = 0.025,
		Mountains = 0.01,
		Snow = 0.015,
		Badlands = 0.015,
		Tundra = 0.015
	}
};

::Legends.BackgroundModifiers.Beggar <- {
	Gathering = 0.30,
	Haggle = 0.01,
};

::Legends.BackgroundModifiers.BeggarSouthern <- clone ::Legends.BackgroundModifiers.Beggar;

::Legends.BackgroundModifiers.BellyDancer <- {
	Haggle = 0.005,
	Scout = 0.3,
};

::Legends.BackgroundModifiers.Bowyer <- {
	Ammo = 34,
	Repair = 0.10,
	Haggle = 0.005,
	ToolConsumption = 0.01,
	Fletching = 0.2,
};

::Legends.BackgroundModifiers.Brawler <- {
	Training = 0.2,
	Stash = 21,
};

::Legends.BackgroundModifiers.Butcher <- {
	Healing = 0.10,
	Injury = 0.06,
	Meds = 13,
};

::Legends.BackgroundModifiers.ButcherSouthern <- clone ::Legends.BackgroundModifiers.Butcher;

::Legends.BackgroundModifiers.CaravanHand <- {
	Scout = 0.2,
	Stash = 8,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025,
		Desert = 0.01,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.CaravanHandSouthern <- clone ::Legends.BackgroundModifiers.CaravanHand;

::Legends.BackgroundModifiers.Companion <- {
	ArmorParts = 8,
	Stash = 8,
	Injury = 0.03,
	Training = 0.1,
};

::Legends.BackgroundModifiers.CompanionSouthern <- clone ::Legends.BackgroundModifiers.Companion;

::Legends.BackgroundModifiers.Companion2h <- {
	ArmorParts = 8,
	Stash = 8,
	Training = 0.1,
};

::Legends.BackgroundModifiers.CompanionSouthern2h <- clone ::Legends.BackgroundModifiers.Companion2h;

::Legends.BackgroundModifiers.CompanionRanged <- {
	Ammo = 21,
	Stash = 8,
	Training = 0.1,
};

::Legends.BackgroundModifiers.CompanionSouthernRanged <- clone ::Legends.BackgroundModifiers.CompanionRanged;

::Legends.BackgroundModifiers.Cripple <- {
	Gathering = 0.30,
	Healing = 0.30,
	Injury = 0.06,
	Meds = 13,
	MedConsumption = 0.05,
};

::Legends.BackgroundModifiers.CrippleSouthern <- clone ::Legends.BackgroundModifiers.Cripple;

::Legends.BackgroundModifiers.Crucified <- {
	Healing = 0.10,
	Salvage = 0.10,
	Repair = 0.10,
	ArmorParts = 8,
	Stash = 8,
	ToolConsumption = 0.01,
	Training = 0.1,
};

::Legends.BackgroundModifiers.Crusader <- {
	Healing = 0.10,
	Salvage = 0.10,
	Repair = 0.30,
	ArmorParts = 13,
	Stash = 8,
	ToolConsumption = 0.03,
	Training = 0.2,
};

::Legends.BackgroundModifiers.Cultist <- {
	Injury = 0.06,
	Meds = 13,
	MedConsumption = 0.05,
};

::Legends.BackgroundModifiers.ConvertedCultist <- clone ::Legends.BackgroundModifiers.Cultist;

::Legends.BackgroundModifiers.Daytaler <- {
	Gathering = 0.30,
	Salvage = 0.10,
	Repair = 0.10,
	Stash = 8,
	ToolConsumption = 0.01,
	Terrain = {
		Farmland = 0.025
	}
};

::Legends.BackgroundModifiers.DaytalerSouthern <- clone ::Legends.BackgroundModifiers.Daytaler;

::Legends.BackgroundModifiers.Deserter <- {
	Repair = 0.10,
	Training = 0.1,
};

::Legends.BackgroundModifiers.DisownedNoble <- {
	Training = 0.1,
	Healing = 0.10,
	Repair = 0.30,
	Fletching = 0.2,
};

::Legends.BackgroundModifiers.LegendDisownedNobleRanged <- clone ::Legends.BackgroundModifiers.DisownedNoble;

::Legends.BackgroundModifiers.Eunuch <- {
	Meds = 13,
	Stash = 5,
	Healing = 0.30,
	Injury = 0.06,
	Repair = 0.10,
	Salvage = 0.10,
	Crafting = 0.50,
	Haggle = 0.005,
	MedConsumption = 0.05,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.EunuchSouthern <- clone ::Legends.BackgroundModifiers.Eunuch;

::Legends.BackgroundModifiers.Executioner <- {
	Meds = 13,
	Injury = 0.03,
};

::Legends.BackgroundModifiers.ExecutionerSouthern <- clone ::Legends.BackgroundModifiers.Executioner;

::Legends.BackgroundModifiers.Farmhand <- {
	Gathering = 0.50,
	Stash = 5,
	Terrain = {
		Farmland = 0.025
	}
};

::Legends.BackgroundModifiers.Fisherman <- {
	Gathering = 0.30,
	Stash = 5,
};

::Legends.BackgroundModifiers.FishermanSouthern <- clone ::Legends.BackgroundModifiers.Fisherman;

::Legends.BackgroundModifiers.Flagellant <- {
	Healing = 0.10,
	Injury = 0.03,
	Gathering = 0.30,
	MedConsumption = 0.05,
};

::Legends.BackgroundModifiers.Gambler <- {
	Haggle = 0.005,
};

::Legends.BackgroundModifiers.GamblerSouthern <- clone ::Legends.BackgroundModifiers.Gambler;

::Legends.BackgroundModifiers.Gladiator <- {
	Ammo = 13,
	ArmorParts = 5,
	Meds = 8,
	Training = 0.3,
	Terrain = {
		Steppe = 0.05,
		Desert = 0.1,
		Oasis = 0.1
	}
};

::Legends.BackgroundModifiers.GladiatorOrigin <- clone ::Legends.BackgroundModifiers.Gladiator;

::Legends.BackgroundModifiers.Gravedigger <- {
	Stash = 5,
};

::Legends.BackgroundModifiers.Graverobber <- {
	Haggle = 0.005,
};

::Legends.BackgroundModifiers.HedgeKnight <- {
	Ammo = 21,
	ArmorParts = 13,
	Repair = 0.10,
	Salvage = 0.10,
	Training = 0.1,
};

::Legends.BackgroundModifiers.Historian <- {
	Healing = 0.10,
	Training = 0.2,
};

::Legends.BackgroundModifiers.HistorianSouthern <- clone ::Legends.BackgroundModifiers.Historian;

::Legends.BackgroundModifiers.Houndmaster <- {
	Scout = 0.3,
	Gathering = 0.50,
	Training = 0.1,
};

::Legends.BackgroundModifiers.Hunter <- {
	Ammo = 34,
	Gathering = 0.50,
	Fletching = 0.2,
	Scout = 0.2,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.Juggler <- {
	Haggle = 0.005,
};

::Legends.BackgroundModifiers.JugglerSouthern <- clone ::Legends.BackgroundModifiers.Juggler;

::Legends.BackgroundModifiers.KillerOnTheRun <- {
	Gathering = 0.30,
	Scout = 0.2,
};

::Legends.BackgroundModifiers.KingsGuard <- {
	Ammo = 21,
	ArmorParts = 13,
	Repair = 0.30,
	Salvage = 0.30,
	Training = 0.1,
};

::Legends.BackgroundModifiers.LindwurmSlayer <- {
	Stash = 5,
	Repair = 0.10,
	Salvage = 0.30,
	Gathering = 0.30,
	Scout = 0.1,
	Training = 0.1,
	Terrain = {
		Swamp = 0.025,
		Forest = 0.025,
		SnowyForest = 0.025,
		LeaveForest = 0.025,
		AutumnForest = 0.025,
		Mountains = 0.01,
		Snow = 0.015,
		Badlands = 0.015,
		Tundra = 0.015
	}
};

::Legends.BackgroundModifiers.Lumberjack <- {
	ArmorParts = 8,
	Stash = 8,
	Salvage = 0.30,
	ToolConsumption = 0.01,
	Gathering = 0.30,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05
	}
};

::Legends.BackgroundModifiers.Manhunter <- {
	Haggle = 0.005,
	Injury = 0.03,
};

::Legends.BackgroundModifiers.Mason <- {
	ArmorParts = 8,
	Stash = 8,
	Salvage = 0.30,
	ToolConsumption = 0.01,
};

::Legends.BackgroundModifiers.Messenger <- {
	Scout = 0.3,
	Gathering = 0.30,
	Terrain = {
		Plains = 0.1,
		Swamp = 0.03,
		Hills = 0.05,
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Mountains = 0.03,
		Farmland = 0.1,
		Snow = 0.03,
		Badlands = 0.03,
		Tundra = 0.07,
		Steppe = 0.1,
		Desert = 0.03,
		Oasis = 0.1
	}
};

::Legends.BackgroundModifiers.Militia <- {
	ArmorParts = 8,
	Training = 0.1,
};

::Legends.BackgroundModifiers.Miller <- {
	Stash = 5,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.Miner <- {
	Stash = 8,
	Salvage = 0.30,
	ToolConsumption = 0.01,
	Terrain = {
		Hills = 0.1,
		Mountains = 0.075
	}
};

::Legends.BackgroundModifiers.Minstrel <- {
	Haggle = 0.005,
};

::Legends.BackgroundModifiers.Monk <- {
	Meds = 21,
	Healing = 0.50,
	Injury = 0.10,
	MedConsumption = 0.05,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.MonkTurnedFlagellant <- {
	Healing = 0.10,
	Injury = 0.03,
	Gathering = 0.30,
	MedConsumption = 0.05,
};

::Legends.BackgroundModifiers.Nomad <- {
	Scout = 0.2,
	Terrain = {
		Plains = 0.1,
		Steppe = 0.1,
		Desert = 0.1,
		Oasis = 0.1
	}
};

::Legends.BackgroundModifiers.NomadRanged <- clone ::Legends.BackgroundModifiers.Nomad;

::Legends.BackgroundModifiers.OrcSlayer <- {
	Repair = 0.30,
	Salvage = 0.50,
	Gathering = 0.30,
	Fletching = 0.1,
	Scout = 0.1,
	Training = 0.1,
	Terrain = {
		Swamp = 0.025,
		Forest = 0.025,
		SnowyForest = 0.025,
		LeaveForest = 0.025,
		AutumnForest = 0.025,
		Mountains = 0.01,
		Snow = 0.015,
		Badlands = 0.015,
		Tundra = 0.015
	}
};

::Legends.BackgroundModifiers.PacifiedFlagellant <- {
	Meds = 21,
	Healing = 0.50,
	Injury = 0.10,
	MedConsumption = 0.05,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.Paladin <- {
	ArmorParts = 8,
	Repair = 0.30,
	Salvage = 0.10,
	ToolConsumption = 0.01,
	Training = 0.2,
	Terrain = {
		Plains = 0.05,
		Farmland = 0.03,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.PaladinOld <- clone ::Legends.BackgroundModifiers.Paladin;

::Legends.BackgroundModifiers.Peddler <- {
	ArmorParts = 8,
	Meds = 13,
	Stash = 8,
	Haggle = 0.02,
};

::Legends.BackgroundModifiers.PeddlerSouthern <- clone ::Legends.BackgroundModifiers.Peddler;

::Legends.BackgroundModifiers.Pimp <- {
	Haggle = 0.01,
	Stash = 5,
	Meds = 13,
	Scout = 0.2,
};

::Legends.BackgroundModifiers.Poacher <- {
	Ammo = 21,
	Fletching = 0.1,
	Scout = 0.2,
	Gathering = 0.50,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.Raider <- {
	ArmorParts = 8,
	Stash = 5,
	Training = 0.1,
};

::Legends.BackgroundModifiers.Ratcatcher <- {
	Scout = 0.1,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.Refugee <- {
	Stash = 5,
	Scout = 0.2,
};

::Legends.BackgroundModifiers.RegentInAbsentia <- {
	ArmorParts = 13,
	Repair = 0.30,
	Salvage = 0.30,
	Stash = 8,
	Training = 0.2,
};

::Legends.BackgroundModifiers.RetiredSoldier <- {
	ArmorParts = 8,
	Repair = 0.30,
	Salvage = 0.10,
	Training = 0.3,
};

::Legends.BackgroundModifiers.Sellsword <- {
	Ammo = 21,
	ArmorParts = 8,
	Repair = 0.10,
	Salvage = 0.10,
	Training = 0.2,
};

::Legends.BackgroundModifiers.Servant <- {
	Meds = 13,
	Stash = 5,
	Healing = 0.10,
	Injury = 0.03,
	Repair = 0.10,
	Salvage = 0.10,
	Crafting = 0.50,
	Haggle = 0.01,
	MedConsumption = 0.05,
	Fletching = 0.1,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.Shepherd <- {
	Scout = 0.2,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.ShepherdSouthern <- clone ::Legends.BackgroundModifiers.Shepherd;

::Legends.BackgroundModifiers.Slave <- {
	Stash = 13,
	Salvage = 0.10,
	Terrain = {
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.01,
		Desert = 0.01,
		Oasis = 0.01
	}
};

::Legends.BackgroundModifiers.SlaveBarbarian <- clone ::Legends.BackgroundModifiers.Slave;

::Legends.BackgroundModifiers.SlaveSouthern <- clone ::Legends.BackgroundModifiers.Slave;

::Legends.BackgroundModifiers.Squire <- {
	Ammo = 21,
	ArmorParts = 8,
	Stash = 5,
	Repair = 0.30,
	Salvage = 0.30,
	Fletching = 0.2,
	Training = 0.1,
};

::Legends.BackgroundModifiers.Swordmaster <- {
	ArmorParts = 8,
	Repair = 0.10,
	Training = 0.3,
};

::Legends.BackgroundModifiers.Tailor <- {
	ArmorParts = 8,
	Repair = 0.30,
	Salvage = 0.30,
	Crafting = 0.75,
	Haggle = 0.005,
	ToolConsumption = 0.01,
};

::Legends.BackgroundModifiers.TailorSouthern <- clone ::Legends.BackgroundModifiers.Tailor;

::Legends.BackgroundModifiers.Thief <- {
	Stash = 5,
	Haggle = 0.005,
	Scout = 0.2,
};

::Legends.BackgroundModifiers.ThiefSouthern <- clone ::Legends.BackgroundModifiers.Thief;

::Legends.BackgroundModifiers.Vagabond <- {
	Stash = 5,
	Scout = 0.1,
	Gathering = 0.30,
};

::Legends.BackgroundModifiers.Wildman <- {
	MedConsumption = 0.05,
	Scout = 0.1,
	Gathering = 1.0,
	Training = 0.1,
	Terrain = {
		Swamp = 0.025,
		Hills = 0.025,
		Mountains = 0.025,
		Snow = 0.025,
		Badlands = 0.025,
		Tundra = 0.025
	}
};

::Legends.BackgroundModifiers.Witchhunter <- {
	Crafting = 0.75,
	Fletching = 0.1,
	Gathering = 0.50,
	Training = 0.1,
	Terrain = {
		Swamp = 0.025
	}
};

::Legends.BackgroundModifiers.LegendAlchemist <- {
	Haggle = 0.01,
	Healing = 0.10,
	Injury = 0.03,
	Crafting = 1.00,
};

::Legends.BackgroundModifiers.LegendCommanderAssassin <- {
	Scout = 0.3,
	Training = 0.1,
};

::Legends.BackgroundModifiers.LegendBattleSister <- {
	Healing = 0.10,
	Injury = 0.03,
	ArmorParts = 8,
	Training = 0.1,
};

::Legends.BackgroundModifiers.LegendCommanderBeggar <- {
	Gathering = 0.50,
	Haggle = 0.02,
};

::Legends.BackgroundModifiers.LegendCommanderBeggarScaling <- clone ::Legends.BackgroundModifiers.LegendCommanderBeggar;

::Legends.BackgroundModifiers.LegendBellyDancer <- {
	Haggle = 0.02,
	Stash = 8,
	Scout = 0.1,
};

::Legends.BackgroundModifiers.LegendBerserker <- {
	Stash = 5,
	Scout = 0.2,
	Gathering = 0.30,
	Terrain = {
		Swamp = 0.025,
		Hills = 0.025,
		Mountains = 0.025,
		Snow = 0.025,
		Badlands = 0.025,
		Tundra = 0.025
	}
};

::Legends.BackgroundModifiers.LegendCommanderBerserker <- {
	Stash = 8,
	Scout = 0.2,
	Gathering = 0.30,
	Terrain = {
		Swamp = 0.025,
		Hills = 0.025,
		Mountains = 0.025,
		Snow = 0.025,
		Badlands = 0.025,
		Tundra = 0.025
	}
};

::Legends.BackgroundModifiers.LegendBlacksmith <- {
	ArmorParts = 21,
	Meds = 13,
	Stash = 8,
	Repair = 0.50,
	Salvage = 0.50,
	Crafting = 0.75,
	Haggle = 0.005,
	ToolConsumption = 0.05,
};

::Legends.BackgroundModifiers.LegendBladedancer <- {
	Scout = 0.2,
	Training = 0.3,
};

::Legends.BackgroundModifiers.LegendBountyHunter <- {
	Haggle = 0.005,
	Stash = 5,
	Injury = 0.03,
	Training = 0.1,
	Terrain = {
		Plains = 0.01,
		Swamp = 0.02,
		Hills = 0.01,
		Forest = 0.02,
		SnowyForest = 0.02,
		LeaveForest = 0.02,
		AutumnForest = 0.02,
		Badlands = 0.02,
		Tundra = 0.02,
		Steppe = 0.05,
		Desert = 0.05,
		Oasis = 0.05
	}
};

::Legends.BackgroundModifiers.LegendCompanionMelee <- {
	Scout = 0.1,
	Repair = 0.10,
	Salvage = 0.10,
	Healing = 0.10,
	Injury = 0.03,
	Crafting = 0.50,
	Gathering = 0.30,
	Training = 0.1,
	Fletching = 0.1,
};

::Legends.BackgroundModifiers.LegendCompanionRanged <- {
	Scout = 0.1,
	Repair = 0.10,
	Salvage = 0.10,
	Healing = 0.10,
	Injury = 0.03,
	Crafting = 0.50,
	Gathering = 0.30,
	Training = 0.1,
	Fletching = 0.1,
};

::Legends.BackgroundModifiers.LegendConscript <- {
	Stash = 5,
	Training = 0.2,
	Scout = 0.1,
	Terrain = {
		Plains = 0.05,
		Steppe = 0.1,
		Desert = 0.1,
		Oasis = 0.2
	}
};

::Legends.BackgroundModifiers.LegendConscriptRanged <- clone ::Legends.BackgroundModifiers.LegendConscript;

::Legends.BackgroundModifiers.LegendCrusader <- {
	Healing = 0.10,
	Salvage = 0.10,
	Repair = 0.30,
	ArmorParts = 13,
	Stash = 8,
	ToolConsumption = 0.03,
	Training = 0.2,
};

::Legends.BackgroundModifiers.LegendDervish <- {
	Meds = 13,
	Healing = 0.30,
	Injury = 0.10,
};

::Legends.BackgroundModifiers.LegendDonkey <- {
	Ammo = 89,
	ArmorParts = 55,
	Meds = 55,
	Stash = 34,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025,
		Desert = 0.01,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.LegendDruid <- {
	Stash = 8,
	Scout = 0.3,
	Gathering = 1.0,
	Terrain = {
		Swamp = 0.05,
		Hills = 0.05,
		Forest = 0.1,
		SnowyForest = 0.1,
		LeaveForest = 0.1,
		Mountains = 0.05,
		Snow = 0.05,
		Badlands = 0.05,
		Tundra = 0.05,
		Steppe = 0.05
	}
};

::Legends.BackgroundModifiers.LegendGladiatorPrizefighter <- clone ::Legends.BackgroundModifiers.Gladiator;

::Legends.BackgroundModifiers.LegendGuildmaster <- {
	Gathering = 0.50,
	Crafting = 0.75,
	Training = 0.2,
	Enchanting = 0.1,
	Terrain = {
		Swamp = 0.03,
		Hills = 0.01,
		Forest = 0.03,
		SnowyForest = 0.03,
		LeaveForest = 0.03,
		AutumnForest = 0.03,
		Mountains = 0.03,
		Snow = 0.02,
		Badlands = 0.02,
		Tundra = 0.02,
		Steppe = 0.01,
		Desert = 0.01,
		Oasis = 0.01
	}
};

::Legends.BackgroundModifiers.LegendHerbalist <- {
	Meds = 21,
	Stash = 5,
	Healing = 0.10,
	Injury = 0.03,
	Crafting = 0.50,
	MedConsumption = 0.10,
	Gathering = 1.0,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.LegendHorse <- {
	Ammo = 55,
	ArmorParts = 34,
	Meds = 34,
	Stash = 21,
	Terrain = {
		Plains = 0.05,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.05,
		Snow = 0.015,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.05,
		Desert = 0.01,
		Oasis = 0.05
	}
};

::Legends.BackgroundModifiers.LegendHorseCourser <- {
	Ammo = 34,
	ArmorParts = 21,
	Meds = 21,
	Stash = 13,
};

::Legends.BackgroundModifiers.LegendHorseDestrier <- {
	Ammo = 21,
	ArmorParts = 8,
	Meds = 13,
	Stash = 8,
};

::Legends.BackgroundModifiers.LegendHorseRouncey <- {
	Ammo = 55,
	ArmorParts = 34,
	Meds = 34,
	Stash = 21,
};

::Legends.BackgroundModifiers.LegendHorserider <- {
	Ammo = 55,
	ArmorParts = 34,
	Meds = 34,
	Stash = 21,
	Terrain = {
		Plains = 0.05,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.05,
		Snow = 0.015,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.05,
		Desert = 0.01,
		Oasis = 0.05
	}
};

::Legends.BackgroundModifiers.LegendHusk <- {
	Injury = 0.06,
	Meds = 13,
	MedConsumption = 0.05,
	Training = 0.2,
};

::Legends.BackgroundModifiers.LegendIllusionist <- {
	Meds = 34,
	Stash = 5,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
};

::Legends.BackgroundModifiers.LegendInventor <- {
	ArmorParts = 13,
	Stash = 8,
	Healing = 0.10,
	Injury = 0.03,
	Repair = 0.30,
	Salvage = 0.50,
	Crafting = 0.50,
};

::Legends.BackgroundModifiers.LegendIronmonger <- {
	ArmorParts = 21,
	Stash = 8,
	Repair = 0.30,
	Salvage = 0.30,
	Crafting = 0.50,
	ToolConsumption = 0.03,
};

::Legends.BackgroundModifiers.LegendLeechPeddler <- {
	Meds = 13,
	Healing = 0.10,
	Injury = 0.03,
	MedConsumption = 0.10,
	Gathering = 0.50,
	Haggle = 0.005,
	Terrain = {
		Swamp = 0.04
	}
};

::Legends.BackgroundModifiers.LegendLegionAuxiliary <- {
	Stash = 5,
	Scout = 0.1,
	// Training = 0.1,
	Terrain = {
		Plains = 0.01,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Farmland = 0.01,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01,
		Steppe = 0.01,
		Desert = 0.01,
		Oasis = 0.01
	}
};

::Legends.BackgroundModifiers.LegendLegionCenturion <- {

	Stash = 5,
	Ammo = 21,
	Training = 0.3, // 0.0, 0.1, 0.2, 0.3
	ArmorParts = 21, // 5, 8, 13, 21, 34, 55
	ToolConsumption = 0.03, // 0.0, 0.05, 0.10, 0.20
	Terrain = {
		Plains = 0.02,
		Swamp = 0.02,
		Hills = 0.02,
		Forest = 0.02,
		SnowyForest = 0.02,
		LeaveForest = 0.02,
		AutumnForest = 0.02,
		Mountains = 1.0, // I get its a hannibal reference but kinda gamebreaking
		Farmland = 0.02,
		Snow = 0.02,
		Badlands = 0.02,
		Tundra = 0.02,
		Steppe = 0.02,
		Desert = 0.02,
		Oasis = 0.02
	}
};

::Legends.BackgroundModifiers.LegendLegionGladiator <- {
	Stash = 5,
	Ammo = 21,
	Fletching = 0.1,
	Training = 0.2,
	Terrain = {
		Plains = 0.15,
		Swamp = 0.15,
		Hills = 0.15,
		Forest = 0.15,
		SnowyForest = 0.15,
		LeaveForest = 0.15,
		AutumnForest = 0.15,
		Mountains = 0.01,
		Farmland = 0.15,
		Snow = 0.15,
		Badlands = 0.15,
		Tundra = 0.15,
		Steppe = 0.15,
		Desert = 0.15,
		Oasis = 0.15
	}
};

::Legends.BackgroundModifiers.LegendLegionHonourGuard <- {
	// Stash = 5,
	Scout = 0.1,
	Ammo = 21,
	Fletching = 0.1,
	Training = 0.2,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025,
		Desert = 0.01,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.LegendLegionLegate <- {
	Training = 0.3,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025,
		Desert = 0.01,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.LegendLegionLegionary <- {
	// Stash = 5,
	Scout = 0.2,
	Training = 0.1,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025,
		Desert = 0.01,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.LegendLegionPrefect <- {
	Stash = 5,
	Ammo = 21,
	ArmorParts = 21,
	ToolConsumption = 0.03,
	Repair = 0.30,
	Salvage = 0.30,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025,
		Desert = 0.01,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.LegendLegionSlave <- {
	Stash = 5,
	ArmorParts = 34
};

::Legends.BackgroundModifiers.LegendLonewolf <- {
	Training = 0.3,
};

::Legends.BackgroundModifiers.LegendLurker <- {
	Ammo = 21,
	Gathering = 0.50,
	Fletching = 0.2,
	Scout = 0.1,
	Meds = 13,
	MedConsumption = 0.05,
	Terrain = {
		Swamp = 0.10,
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Farmland = 0.05
	}
};

::Legends.BackgroundModifiers.LegendMagister <- {
	Meds = 34,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
	Gathering = 0.50,
};

::Legends.BackgroundModifiers.LegendManAtArms <- {
	ArmorParts = 13,
	Training = 0.3,
};

::Legends.BackgroundModifiers.LegendMasterArcher <- {
	Ammo = 55,
	Gathering = 0.30,
	Fletching = 0.3,
	Scout = 0.3,
	Terrain = {
		Forest = 0.25,
		SnowyForest = 0.25,
		LeaveForest = 0.25,
		AutumnForest = 0.25,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.LegendMuladi <- {
	Ammo = 21,
	Fletching = 0.1,
	Scout = 0.2,
	Gathering = 0.50,
	Terrain = {
		Plains = 0.025,
		Hills = 0.025,
		Mountains = 0.01,
		Steppe = 0.01,
		Desert = 0.025,
		Oasis = 0.025
	}
};

::Legends.BackgroundModifiers.LegendCommanderNecro <- {
	Meds = 34,
	Stash = 5,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
	Crafting = 0.50,
	Gathering = 0.30,
	Terrain = {
		Swamp = 0.15,
		Forest = 0.10,
		SnowyForest = 0.10,
		LeaveForest = 0.10,
		AutumnForest = 0.10
	}
};

::Legends.BackgroundModifiers.LegendNecromancer <- {
	Meds = 34,
	Stash = 5,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
};

::Legends.BackgroundModifiers.LegendNecrosavant <- {
	Meds = 34,
	Stash = 5,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
};

::Legends.BackgroundModifiers.LegendNightwatch <- {
	Scout = 0.2,
	Terrain = {
		Plains = 0.015,
		Hills = 0.01,
		Farmland = 0.015,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.LegendHouseGuard <- {
	ArmorParts = 8,
	Stash = 8,
	Training = 0.1,
};
::Legends.BackgroundModifiers.LegendCommanderNoble <- {
	Ammo = 21,
	ArmorParts = 8,
	Meds = 13,
	Stash = 8,
	Healing = 0.10,
	Injury = 0.03,
	Haggle = 0.005,
	ToolConsumption = 0.01,
	Training = 0.1,
	Terrain = {
		Plains = 0.025,
		Swamp = 0.01,
		Hills = 0.01,
		Forest = 0.01,
		SnowyForest = 0.01,
		LeaveForest = 0.01,
		AutumnForest = 0.01,
		Mountains = 0.01,
		Farmland = 0.025,
		Snow = 0.011,
		Badlands = 0.015,
		Tundra = 0.015,
		Steppe = 0.025
	}
};

::Legends.BackgroundModifiers.LegendArbalester <- {
	Ammo = 21,
	Stash = 8,
	Training = 0.1,
};

::Legends.BackgroundModifiers.LegendFootSoldier <- {
	ArmorParts = 8,
	Stash = 8,
	Injury = 0.03,
	Training = 0.1,
};

::Legends.BackgroundModifiers.LegendCommanderPeddler <- {
	ArmorParts = 8,
	Meds = 13,
	Stash = 13,
	Haggle = 0.03,
	Terrain = {
		Plains = 0.2,
		Farmland = 0.1,
		Oasis = 0.1
	}
};

::Legends.BackgroundModifiers.LegendPilgrim <- {
	Meds = 13,
	Stash = 8,
	Repair = 0.10,
	Salvage = 0.10,
	Gathering = 0.30,
	Terrain = {
		Plains = 0.01,
		Hills = 0.02,
		Forest = 0.02,
		SnowyForest = 0.02,
		LeaveForest = 0.02,
		AutumnForest = 0.02,
		Mountains = 0.01,
		Farmland = 0.01,
		Badlands = 0.02,
		Tundra = 0.02,
		Steppe = 0.02
	}
};

::Legends.BackgroundModifiers.LegendPreserver <- {
	Meds = 21,
	Stash = 5,
	Healing = 0.10,
	Injury = 0.03,
	Crafting = 0.50,
	MedConsumption = 0.20,
	Gathering = 1.0,
	Terrain = {
		Forest = 0.10,
		SnowyForest = 0.10,
		LeaveForest = 0.10,
		AutumnForest = 0.10,
		Snow = 0.02,
		Badlands = 0.02,
		Tundra = 0.02
	}
};

::Legends.BackgroundModifiers.LegendPuppet <- {
	Stash = 5,
	Gathering = 0.30
};

::Legends.BackgroundModifiers.LegendPuppetMaster <- {};

::Legends.BackgroundModifiers.LegendRanger <- {
	Ammo = 55,
	Stash = 5,
	Gathering = 0.50,
	Fletching = 0.2,
	Scout = 0.3,
	Training = 0.1,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.LegendCommanderRanger <- {
	Ammo = 55,
	Stash = 5,
	Gathering = 0.50,
	Fletching = 0.2,
	Scout = 0.3,
	Training = 0.1,
	Terrain = {
		Forest = 0.05,
		SnowyForest = 0.05,
		LeaveForest = 0.05,
		AutumnForest = 0.05,
		Snow = 0.01,
		Badlands = 0.01,
		Tundra = 0.01
	}
};

::Legends.BackgroundModifiers.LegendShieldmaiden <- {
	Repair = 0.30,
	Salvage = 0.10,
	Training = 0.2,
};

::Legends.BackgroundModifiers.LegendSurgeon <- {
	Meds = 34,
	Healing = 0.50,
	Injury = 0.10,
	MedConsumption = 0.10,
};

::Legends.BackgroundModifiers.LegendTaxidermist <- {
	Healing = 0.10,
	Crafting = 1.00,
	ToolConsumption = 0.01,
	MedConsumption = 0.10,
};

::Legends.BackgroundModifiers.LegendVala <- {
	Meds = 21,
	Healing = 0.50,
	Injury = 0.10,
	Enchanting = 1.0,
};

::Legends.BackgroundModifiers.LegendWarlock <- {
	Meds = 34,
	Stash = 5,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
};

::Legends.BackgroundModifiers.LegendWarlockSummoner <- {
	Meds = 13,
	Stash = 5,
	MedConsumption = 0.05,
	Terrain = {
		Swamp = 0.1
	}
};

::Legends.BackgroundModifiers.LegendSeer <- {
	Meds = 34,
	Stash = 8,
	Healing = 0.30,
	Injury = 0.06,
	MedConsumption = 0.20,
};

::Legends.BackgroundModifiers.LegendYoungblood <- {
	Salvage = 0.10,
	Crafting = 0.50,
	Gathering = 0.50,
	ToolConsumption = 0.01,
	Fletching = 0.1,
	Terrain = {
		Swamp = 0.015
	}
};
