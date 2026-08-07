if (!("BackgroundModifiers" in ::Legends)) {
	::Legends.BackgroundModifiers <- {};
}

::Legends.BackgroundModifiers.AdventurousNoble <- {
	ArmorParts = 13;
	Healing = 0.10;
	Injury = 0.03;
	Repair = 0.10;
	Training = 0.2;
};

::Legends.BackgroundModifiers.Anatomist <- {
	Meds = 34;
	Healing = 0.30;
	Injury = 0.06;
	Gathering = 0.30;
	MedConsumption = 0.05;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.02, //swamp
		0.03, //hills
		0.05, //forest
		0.05, //forest
		0.05, //forest_leaves
		0.05, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.Apprentice <- {
	Salvage = 0.10;
	Crafting = 0.50;
	Haggle = 0.0;
	ToolConsumption = 0.01;
	Repair = 0.30;
};

::Legends.BackgroundModifiers.Assassin <- {
	Scout = 0.3;
	Training = 0.1;
};

::Legends.BackgroundModifiers.AssassinSouthern <- {
	Scout = 0.3;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.02, // badlands
		0.0, //highlands
		0.04, //steppes
		0.0, //ocean
		0.05, //desert
		0.05 //oasis
	];
};

::Legends.BackgroundModifiers.Barbarian <- {
	Training = 0.2;
	Scout = 0.2;
	Hunting = 0.2;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.00, //swamp
		0.00, //hills
		0.05, //forest
		0.05, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.05, // snow
		0.00, // badlands
		0.05, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.Bastard <- {
	Repair = 0.10;
	Healing = 0.10;
	Training = 0.2;
};

::Legends.BackgroundModifiers.BeastSlayer <- {
	Hunting = 0.2;
	Crafting = 0.75;
	Scout = 0.2;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.00,//plains
		0.025, //swamp
		0.0, //hills
		0.025, //forest
		0.025, //forest
		0.025, //forest_leaves
		0.025, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.00, //farmland
		0.015, // snow
		0.015, // badlands
		0.015, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.Beggar <- {
	Gathering = 0.30;
	Haggle = 0.01;
};

::Legends.BackgroundModifiers.BeggarSouthern <- clone ::Legends.BackgroundModifiers.Beggar;

::Legends.BackgroundModifiers.BellyDancer <- {
	Haggle = 0.005;
	Scout = 0.3;
};

::Legends.BackgroundModifiers.Bowyer <- {
	Ammo = 34;
	Repair = 0.10;
	Haggle = 0.005;
	ToolConsumption = 0.01;
	Hunting = 0.1;
	Fletching = 0.2;
};

::Legends.BackgroundModifiers.Brawler <- {
	Training = 0.2;
	Stash = 21;
};

::Legends.BackgroundModifiers.Butcher <- {
	Hunting = 0.1;
	Healing = 0.10;
	Injury = 0.06;
	Meds = 13;
};

::Legends.BackgroundModifiers.CaravanHand <- {
	Scout = 0.2;
	Stash = 8;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.01, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.CaravanHandSouthern <- clone ::Legends.BackgroundModifiers.CaravanHand;

::Legends.BackgroundModifiers.Companion <- {
	ArmorParts = 8;
	ArmorParts = 8;
	Stash = 8;
	Injury = 0.03;
	Training = 0.1;
};

::Legends.BackgroundModifiers.CompanionSouthern <- clone ::Legends.BackgroundModifiers.Companion;

::Legends.BackgroundModifiers.Companion2h <- {
	ArmorParts = 8;
	Stash = 8;
	Training = 0.1;
};

::Legends.BackgroundModifiers.CompanionSouthern2h <- clone ::Legends.BackgroundModifiers.Companion2h;

::Legends.BackgroundModifiers.CompanionRanged <- {
	Ammo = 21;
	Stash = 8;
	Training = 0.1;
};

::Legends.BackgroundModifiers.CompanionSouthernRanged <- clone ::Legends.BackgroundModifiers.CompanionRanged;

::Legends.BackgroundModifiers.Cripple <- {
	Gathering = 0.30;
	Healing = 0.30;
	Injury = 0.06;
	Meds = 13;
	MedConsumption = 0.05;
};

::Legends.BackgroundModifiers.CrippleSouthern <- clone ::Legends.BackgroundModifiers.Cripple;

::Legends.BackgroundModifiers.Crucified <- {
	Healing = 0.10;
	Salvage = 0.10;
	Repair = 0.10;
	ArmorParts = 8;
	Stash = 8;
	ToolConsumption = 0.01;
	Training = 0.1;
};

::Legends.BackgroundModifiers.Crusader <- {
	Healing = 0.10;
	Salvage = 0.10;
	Repair = 0.30;
	ArmorParts = 13;
	Stash = 8;
	ToolConsumption = 0.03;
	Training = 0.2;
};

::Legends.BackgroundModifiers.Cultist <- {
	Injury = 0.06;
	Meds = 13;
	MedConsumption = 0.05;
};

::Legends.BackgroundModifiers.ConvertedCultist <- clone ::Legends.BackgroundModifiers.Cultist;

::Legends.BackgroundModifiers.Daytaler <- {
	Gathering = 0.30;
	Salvage = 0.10;
	Repair = 0.10;
	Stash = 8;
	ToolConsumption = 0.01;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.00,//plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.025, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.DaytalerSouthern <- clone ::Legends.BackgroundModifiers.Daytaler;

::Legends.BackgroundModifiers.Deserter <- {
	Repair = 0.10;
	Training = 0.1;
};

::Legends.BackgroundModifiers.DisownedNoble <- {
	Training = 0.1;
	Healing = 0.10;
	Repair = 0.30;
	Fletching = 0.2;
};

::Legends.BackgroundModifiers.Eunuch <- {
	Meds = 13;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	Repair = 0.10;
	Salvage = 0.10;
	Crafting = 0.50;
	Haggle = 0.005;
	MedConsumption = 0.05;
	Gathering = 0.30;
};

::Legends.BackgroundModifiers.EunuchSouthern <- clone ::Legends.BackgroundModifiers.Eunuch;

::Legends.BackgroundModifiers.Executioner <- {
	Meds = ::Const.LegendMod.ResourceModifiers.Meds[1];
	Injury = ::Const.LegendMod.ResourceModifiers.Injury[1];
};

::Legends.BackgroundModifiers.ExecutionerSouthern <- clone ::Legends.BackgroundModifiers.Executioner;

::Legends.BackgroundModifiers.Farmhand <- {
	Gathering = 0.50;
	Stash = 5;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.00,//plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.025, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.Fisherman <- {
	Hunting = 0.1;
	Stash = 5;
};

::Legends.BackgroundModifiers.FishermanSouthern <- clone ::Legends.BackgroundModifiers.Fisherman;

::Legends.BackgroundModifiers.Flagellant <- {
	Healing = 0.10;
	Injury = 0.03;
	Gathering = 0.30;
	MedConsumption = 0.05;
};

::Legends.BackgroundModifiers.Gambler <- {
	Haggle = 0.005;
};

::Legends.BackgroundModifiers.Gladiator <- {
	Ammo = 13;
	ArmorParts = 5;
	Meds = 8;
	Training = 0.3;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.05, //steppes
		0.0, //ocean
		0.1, //desert
		0.1 //oasis
	];
};

::Legends.BackgroundModifiers.GladiatorOrigin <- clone ::Legends.BackgroundModifiers.Gladiator;

::Legends.BackgroundModifiers.Gravedigger <- {
	Stash = 5;
};

::Legends.BackgroundModifiers.Graverobber <- {
			Haggle = 0.005;
};

::Legends.BackgroundModifiers.HedgeKnight <- {
			Ammo = 21;
		ArmorParts = 13;
		Repair = 0.10;
		Salvage = 0.10;
		Training = 0.1;
};

::Legends.BackgroundModifiers.Historian <- {
			Healing = 0.10;
		Training = 0.2;
};

::Legends.BackgroundModifiers.Houndmaster <- {
			Hunting = 0.2;
		Scout = 0.3;
		Gathering = 0.50;
		Training = 0.1;
};

::Legends.BackgroundModifiers.Hunter <- {
	Ammo = 34;
	Hunting = 0.3;
	Fletching = 0.2;
	Scout = 0.2;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.05, //forest
		0.05, //forest
		0.05, //forest_leaves
		0.05, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.01, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.Juggler <- {
			Haggle = 0.005;
};

::Legends.BackgroundModifiers.JugglerSouthern <- clone ::Legends.BackgroundModifiers.Juggler;

::Legends.BackgroundModifiers.KillerOnTheRun <- {
			Hunting = 0.1;
		Scout = 0.2;
};

::Legends.BackgroundModifiers.KingsGuard <- {
			Ammo = 21;
		ArmorParts = 13;
		Repair = 0.30;
		Salvage = 0.30;
		Training = 0.1;
};

::Legends.BackgroundModifiers.LindwurmSlayer <- {
			Stash = 5;
		Repair = 0.10;
		Salvage = 0.30;
		Hunting = 0.3;
		Scout = 0.1;
		Training = 0.1;

		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.00,//plains
				0.025, //swamp
				0.0, //hills
				0.025, //forest
				0.025, //forest
				0.025, //forest_leaves
				0.025, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.00, //farmland
				0.015, // snow
				0.015, // badlands
				0.015, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
};

::Legends.BackgroundModifiers.Lumberjack <- {
			ArmorParts = 8;
		Stash = 8;
		Salvage = 0.30;
		ToolConsumption = 0.01;
		Gathering = 0.30;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.0, //hills
				0.05, //forest
				0.05, //forest
				0.05, //forest_leaves
				0.05, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
};

::Legends.BackgroundModifiers.Manhunter <- {
			Haggle = 0.005;
		Injury = 0.03;
};

::Legends.BackgroundModifiers.Mason <- {
			ArmorParts = 8;
		Stash = 8;
		Salvage = 0.30;
		ToolConsumption = 0.01;
};

::Legends.BackgroundModifiers.Messenger <- {
			Scout = 0.3;
		Gathering = 0.30;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.1,//plains
			0.03, //swamp
			0.05, //hills
			0.05, //forest
			0.05, //forest
			0.05, //forest_leaves
			0.05, //autumn_forest
			0.03, //mountains
			0.0, // ?
			0.1, //farmland
			0.03, // snow
			0.03, // badlands
			0.07, //highlands
			0.1, //steppes
			0.0, //ocean
			0.03, //desert
			0.1 //oasis
		];
};

::Legends.BackgroundModifiers.Militia <- {
			ArmorParts = 8;
		Training = 0.1;
};

::Legends.BackgroundModifiers.Miller <- {
			Stash = 5;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.Miner <- {
			Stash = 8;
		Salvage = 0.30;
		ToolConsumption = 0.01;
		Terrain =  [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.1, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.075, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
};

::Legends.BackgroundModifiers.Minstrel <- {
			Haggle = 0.005;
};

::Legends.BackgroundModifiers.Monk <- {
			Meds = 21;
		Healing = 0.50;
		Injury = 0.10;
		MedConsumption = 0.05;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.MonkTurnedFlagellant <- {
			Healing = 0.10;
		Injury = 0.03;
		Gathering = 0.30;
		MedConsumption = 0.05;
};

::Legends.BackgroundModifiers.Nomad <- {
	Scout = 0.2;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.1,//plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.1, //steppes
				0.0, //ocean
				0.1, //desert
				0.1 //oasis
			];
};

::Legends.BackgroundModifiers.NomadRanged <- clone ::Legends.BackgroundModifiers.Nomad;

::Legends.BackgroundModifiers.OrcSlayer <- {
			Repair = 0.30;
		Salvage = 0.50;
		Hunting = 0.1;
		Fletching = 0.1;
		Scout = 0.1;
		Training = 0.1;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.00,//plains
				0.025, //swamp
				0.0, //hills
				0.025, //forest
				0.025, //forest
				0.025, //forest_leaves
				0.025, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.00, //farmland
				0.015, // snow
				0.015, // badlands
				0.015, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
};

::Legends.BackgroundModifiers.PacifiedFlagellant <- {
			Meds = 21;
		Healing = 0.50;
		Injury = 0.10;
		MedConsumption = 0.05;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.Paladin <- {
			ArmorParts = 8;
		Repair = 0.30;
		Salvage = 0.10;
		ToolConsumption = 0.01;
		Training = 0.2;

		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.05, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.03, //farmland
				0.0, // snow
				0.01, // badlands
				0.01, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
};

::Legends.BackgroundModifiers.PaladinOld <- clone ::Legends.BackgroundModifiers.Paladin;

::Legends.BackgroundModifiers.Peddler <- {
	ArmorParts = 8;
	Meds = 13;
	Stash = 8;
	Haggle = 0.02;
};

::Legends.BackgroundModifiers.PeddlerSouthern <- clone ::Legends.BackgroundModifiers.Peddler;

::Legends.BackgroundModifiers.Pimp <- {
			Haggle = 0.01;
		Stash = 5;
		Meds = 13;
		Scout = 0.2;
};

::Legends.BackgroundModifiers.Poacher <- {
			Ammo = 21;
		Hunting = 0.2;
		Fletching = 0.1;
		Scout = 0.2;
		Gathering = 0.50;
		Terrain = [
			0.0, // ?
			0.0, //CompanionSouthernRanged
			0.0,//plains
			0.0, //swamp
			0.0, //hills
			0.05, //forest
			0.05, //forest
			0.05, //forest_leaves
			0.05, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.01, // snow
			0.01, // badlands
			0.01, //highlands
			0.0, //steppes
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
};

::Legends.BackgroundModifiers.Raider <- {
			ArmorParts = 8;
		Stash = 5;
		Training = 0.1;
};

::Legends.BackgroundModifiers.Ratcatcher <- {
			Hunting = 0.2;
		Scout = 0.1;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.Refugee <- {
			Stash = 5;
		Scout = 0.2;
};

::Legends.BackgroundModifiers.RegentInAbsentia <- {
			ArmorParts = 13;
		Repair = 0.30;
		Salvage = 0.30;
		Stash = 8;
		Training = 0.2;
};

::Legends.BackgroundModifiers.RetiredSoldier <- {
			ArmorParts = 8;
		Repair = 0.30;
		Salvage = 0.10;
		Training = 0.3;
};

::Legends.BackgroundModifiers.Sellsword <- {
			Ammo = 21;
		ArmorParts = 8;
		Repair = 0.10;
		Salvage = 0.10;
		Training = 0.2;
};

::Legends.BackgroundModifiers.Servant <- {
			Meds = 13;
		Stash = 5;
		Healing = 0.10;
		Injury = 0.03;
		Repair = 0.10;
		Salvage = 0.10;
		Crafting = 0.50;
		Haggle = 0.01;
		MedConsumption = 0.05;
		Fletching = 0.1;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.Shepherd <- {
			Hunting = 0.1;
		Scout = 0.2;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.ShepherdSouthern <- clone ::Legends.BackgroundModifiers.Shepherd;

::Legends.BackgroundModifiers.Slave <- {
			Stash = 13;
		Salvage = 0.10;
		Terrain =  [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.01, //hills
				0.01, //forest
				0.01, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.01, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //steppes
				0.0, //ocean
				0.01, //desert
				0.01 //oasis
			];
};

::Legends.BackgroundModifiers.SlaveBarbarian <- clone ::Legends.BackgroundModifiers.Slave;

::Legends.BackgroundModifiers.SlaveSouthern <- clone ::Legends.BackgroundModifiers.Slave;

::Legends.BackgroundModifiers.Squire <- {
			Ammo = 21;
		ArmorParts = 8;
		Stash = 5;
		Repair = 0.30;
		Salvage = 0.30;
		Fletching = 0.2;
		Training = 0.1;
};

::Legends.BackgroundModifiers.Swordmaster <- {
			ArmorParts = 8;
		Repair = 0.10;
		Training = 0.3;
};

::Legends.BackgroundModifiers.Tailor <- {
			ArmorParts = 8;
		Repair = 0.30;
		Salvage = 0.30;
		Crafting = 0.75;
		Haggle = 0.005;
		ToolConsumption = 0.01;
};

::Legends.BackgroundModifiers.Thief <- {
			Stash = 5;
		Haggle = 0.005;
		Scout = 0.2;
};

::Legends.BackgroundModifiers.Vagabond <- {
			Stash = 5;
		Scout = 0.1;
		Gathering = 0.30;
};

::Legends.BackgroundModifiers.Wildman <- {
			MedConsumption = 0.05;
		Hunting = 0.2;
		Scout = 0.1;
		Gathering = 1.0;
		Training = 0.1;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.025, //swamp
			0.025, //hills
			0.0, //forest
			0.0, //forest
			0.0, //forest_leaves
			0.0, //autumn_forest
			0.025, //mountains
			0.0, // ?
			0.0, //farmland
			0.025, // snow
			0.025, // badlands
			0.025, //highlands
			0.0, //steppes
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
};

::Legends.BackgroundModifiers.Witchhunter <- {
			Crafting = 0.75;
		Hunting = 0.1;
		Fletching = 0.1;
		Gathering = 0.50;
		Training = 0.1;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.025, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
};

::Legends.BackgroundModifiers.LegendAlchemist <- {
			Haggle = 0.01;
		Healing = 0.10;
		Injury = 0.03;
		Crafting = 1.00;
};

::Legends.BackgroundModifiers.LegendCommanderAssassin <- {
			Scout = 0.3;
		Training = 0.1;
};

::Legends.BackgroundModifiers.LegendBattleSister <- {
			Healing = 0.10;
		Injury = 0.03;
		ArmorParts = 8;
		Training = 0.1;
};

::Legends.BackgroundModifiers.LegendCommanderBeggar <- {
			Gathering = 0.50;
		Haggle = 0.02;
};

::Legends.BackgroundModifiers.LegendCommanderBeggarScaling <- clone ::Legends.BackgroundModifiers.LegendCommanderBeggar;

::Legends.BackgroundModifiers.LegendBerserker <- {
			Stash = 5;
		Hunting = 0.2;
		Scout = 0.2;
		Gathering = 0.30;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.025, //swamp
			0.025, //hills
			0.0, //forest
			0.0, //forest
			0.0, //forest_leaves
			0.0, //autumn_forest
			0.025, //mountains
			0.0, // ?
			0.0, //farmland
			0.025, // snow
			0.025, // badlands
			0.025, //highlands
			0.0, //steppes
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
};

::Legends.BackgroundModifiers.LegendCommanderBerserker <- {
			Stash = 8;
		Hunting = 0.2;
		Scout = 0.2;
		Gathering = 0.30;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.025, //swamp
			0.025, //hills
			0.0, //forest
			0.0, //forest
			0.0, //forest_leaves
			0.0, //autumn_forest
			0.025, //mountains
			0.0, // ?
			0.0, //farmland
			0.025, // snow
			0.025, // badlands
			0.025, //highlands
			0.0, //steppes
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
};

::Legends.BackgroundModifiers.LegendBlacksmith <- {
			ArmorParts = 21;
		Meds = 13;
		Stash = 8;
		Repair = 0.50;
		Salvage = 0.50;
		Crafting = 0.75;
		Haggle = 0.005;
		ToolConsumption = 0.05;
};

::Legends.BackgroundModifiers.LegendBladedancer <- {
			Scout = 0.2;
		Training = 0.3;
};

::Legends.BackgroundModifiers.LegendBountyHunter <- {
			Haggle = 0.005;
		Stash = 5;
		Injury = 0.03;
		Training = 0.1;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.01, //plains
			0.02, //swamp
			0.01, //hills
			0.02, //forest
			0.02, //forest
			0.02, //forest_leaves
			0.02, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.0, // snow
			0.02, // badlands
			0.02, //highlands
			0.05, //steppes
			0.0, //ocean
			0.05, //desert
			0.05 //oasis
		];
};

::Legends.BackgroundModifiers.LegendCompanionMelee <- {
			Scout = 0.1;
		Repair = 0.10;
		Salvage = 0.10;
		Healing = 0.10;
		Injury = 0.03;
		Crafting = 0.50;
		Gathering = 0.30;
		Training = 0.1;
		Fletching = 0.1;
		Hunting = 0.1;
};

::Legends.BackgroundModifiers.LegendCompanionRanged <- {
			Scout = 0.1;
		Repair = 0.10;
		Salvage = 0.10;
		Healing = 0.10;
		Injury = 0.03;
		Crafting = 0.50;
		Gathering = 0.30;
		Training = 0.1;
		Fletching = 0.1;
		Hunting = 0.1;
};

::Legends.BackgroundModifiers.LegendConscript <- {
		Stash = 5;
		Training = 0.2;
		Scout = 0.1;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.05, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.1, //steppes
				0.0, //ocean
				0.1, //desert
				0.2 //oasis
			];};

::Legends.BackgroundModifiers.LegendConscriptRanged <- clone ::Legends.BackgroundModifiers.LegendConscript;

::Legends.BackgroundModifiers.LegendCrusader <- {
			Healing = 0.10;
		Salvage = 0.10;
		Repair = 0.30;
		ArmorParts = 13;
		Stash = 8;
		ToolConsumption = 0.03;
		Training = 0.2;
};

::Legends.BackgroundModifiers.LegendDervish <- {
			Meds = 13;
		Healing = 0.30;
		Injury = 0.10;
};

::Legends.BackgroundModifiers.LegendDonkey <- {
	Ammo = 89;
	ArmorParts = 55;
	Meds = 55;
	Stash = 34;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025, //plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.01, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.LegendDruid <- {
		Stash = 8;
		Hunting = 0.2;
		Scout = 0.3;
		Gathering = 1.0;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0, //plains
			0.05, //swamp
			0.05, //hills
			0.1, //forest
			0.1, //forest
			0.1, //forest_leaves
			0.0, //autumn_forest
			0.05, //mountains
			0.0, // ?
			0.0, //farmland
			0.05, // snow
			0.05, // badlands
			0.05, //highlands
			0.05, //steppes
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
};

::Legends.BackgroundModifiers.LegendGladiatorPrizefighter <- clone ::Legends.BackgroundModifiers.Gladiator;

::Legends.BackgroundModifiers.LegendGuildmaster <- {
	Hunting = 0.1;
		Crafting = 0.75;
		Training = 0.2;
		Enchanting = 0.1;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.00,//plains
				0.030, //swamp
				0.01, //hills
				0.030, //forest
				0.030, //forest
				0.030, //forest_leaves
				0.030, //autumn_forest
				0.03, //mountains
				0.0, // ?
				0.00, //farmland
				0.020, // snow
				0.020, // badlands
				0.020, //highlands
				0.01, //steppes
				0.0, //ocean
				0.01, //desert
				0.01 //oasis
			];
};

::Legends.BackgroundModifiers.LegendHerbalist <- {
	Meds = 21;
	Stash = 5;
	Healing = 0.10;
	Injury = 0.03;
	Crafting = 0.50;
	MedConsumption = 0.10;
	Gathering = 1.0;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.05, //forest
		0.05, //forest
		0.05, //forest_leaves
		0.05, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.01, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendHorse <- {
	Ammo = 55;
	ArmorParts = 34;
	Meds = 34;
	Stash = 21;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.05,//plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.05, //farmland
		0.015, // snow
		0.015, // badlands
		0.015, //highlands
		0.05, //steppes
		0.0, //ocean
		0.01, //desert
		0.05 //oasis
	];
};

::Legends.BackgroundModifiers.LegendHorseCourser <- {
	Ammo = 34;
	ArmorParts = 21;
	Meds = 21;
	Stash = 13;
};

::Legends.BackgroundModifiers.LegendHorseDestrier <- {
	Ammo = 21;
	ArmorParts = 8;
	Meds = 13;
	Stash = 8;
};

::Legends.BackgroundModifiers.LegendHorseRouncey <- {
	Ammo = 55;
	ArmorParts = 34;
	Meds = 34;
	Stash = 21;
};

::Legends.BackgroundModifiers.LegendHorserider <- {
		Ammo = 55;
		ArmorParts = 34;
		Meds = 34;
		Stash = 21;
		Terrain = [
			0.0, // ?
			0.0, //ocean
			0.05,//plains
			0.01, //swamp
			0.01, //hills
			0.01, //forest
			0.01, //forest
			0.01, //forest_leaves
			0.01, //autumn_forest
			0.01, //mountains
			0.0, // ?
			0.05, //farmland
			0.015, // snow
			0.015, // badlands
			0.015, //highlands
			0.05, //steppes
			0.0, //ocean
			0.01, //desert
			0.05 //oasis
		];
};

::Legends.BackgroundModifiers.LegendHusk <- {
	Injury = 0.06;
	Meds = 13;
	MedConsumption = 0.05;
	Training = 0.2;
};

::Legends.BackgroundModifiers.LegendIllusionist <- {
	Meds = 34;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
};

::Legends.BackgroundModifiers.LegendInventor <- {
	ArmorParts = 13;
	Stash = 8;
	Healing = 0.10;
	Injury = 0.03;
	Repair = 0.30;
	Salvage = 0.50;
	Crafting = 0.50;
};

::Legends.BackgroundModifiers.LegendIronmonger <- {
	ArmorParts = 21;
	Stash = 8;
	Repair = 0.30;
	Salvage = 0.30;
	Crafting = 0.50;
	ToolConsumption = 0.03;
};

::Legends.BackgroundModifiers.LegendLeechPeddler <- {
	Meds = 13;
	Healing = 0.10;
	Injury = 0.03;
	MedConsumption = 0.10;
	Gathering = 0.50;
	Haggle = 0.005;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.04, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, //snow
		0.0, //badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLegionAuxiliary <- {
		Stash = 5;
		Scout = 0.1;
		// Training = 0.1;
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.01, //plains
				0.01, //swamp
				0.01, //hills
				0.01, //forest
				0.01, //forest
				0.01, //forest_leaves
				0.01, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.01, //farmland
				0.01, //snow
				0.01, //badlands
				0.01, //highlands
				0.01, //steppes
				0.0, //ocean
				0.01, //desert
				0.01 //oasis
			];
};

::Legends.BackgroundModifiers.LegendLegionCenturion <- {

		Stash = 5;
		Ammo = 21;
		Training = 0.3; // 0.0, 0.1, 0.2, 0.3
		ArmorParts = 21; // 5, 8, 13, 21, 34, 55
		ToolConsumption = 0.03; // 0.0, 0.05, 0.10, 0.20
		Terrain = [
				0.0, // ?
				0.0, //ocean
				0.02, //plains
				0.02, //swamp
				0.02, //hills
				0.02, //forest
				0.02, //forest
				0.02, //forest_leaves
				0.02, //autumn_forest
				1.0, //mountains - hannibal time
				0.0, // ?
				0.02, //farmland
				0.02, //snow
				0.02, //badlands
				0.02, //highlands
				0.02, //steppes
				0.0, //ocean
				0.02, //desert
				0.02 //oasis
			];
};

::Legends.BackgroundModifiers.LegendLegionGladiator <- {
	Stash = 5;
	Ammo = 21;
	Fletching = 0.1;
	Training = 0.2; // 0.0, 0.1, 0.2, 0.3
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.15, //plains
		0.15, //swamp
		0.15, //hills
		0.15, //forest
		0.15, //forest
		0.15, //forest_leaves
		0.15, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.15, //farmland
		0.15, //snow
		0.15, //badlands
		0.15, //highlands
		0.15, //steppes
		0.0, //ocean
		0.15, //desert
		0.15 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLegionHonourGuard <- {
	// Stash = 5;
	Scout = 0.1;
	Ammo = 21;
	Fletching = 0.1;
	Training = 0.2;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.01, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLegionLegate <- {
	Training = 0.3; // 0.0, 0.1, 0.2, 0.3
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.01, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLegionLegionary <- {
	// Stash = 5;
	Scout = 0.2;
	Training = 0.1;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.01, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.01, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLegionPrefect <- {
	Stash = 5;
	Ammo = 21;
	ArmorParts = 21; // 5, 8, 13, 21, 34, 55
	ToolConsumption = 0.03; // 0.0, 0.05, 0.10, 0.20
	Repair = 0.30; // 0.0, 0.10, 0.30, 0.50, 1.0
	Salvage = 0.30; // 0.0, 0.10, 0.30, 0.50
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.01, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLegionSlave <- {
	Stash = 5;
	ArmorParts = 34; // 5, 8, 13, 21, 34, 55
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, //snow
		0.0, //badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendLonewolf <- {
	Training = 0.3;
};

::Legends.BackgroundModifiers.LegendLurker <- {
	Ammo = 21;
	Hunting = 0.2;
	Fletching = 0.2;
	Scout = 0.1;
	Meds = 13;
	MedConsumption = 0.05;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.00,//plains
		0.10, //swamp
		0.0, //hills
		0.05, //forest
		0.05, //forest
		0.05, //forest_leaves
		0.05, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.05, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendMagister <- {
	Meds = 34;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
	Gathering = 0.50;
};

::Legends.BackgroundModifiers.LegendManAtArms <- {
	ArmorParts = 13;
	Training = 0.3;
};

::Legends.BackgroundModifiers.LegendMasterArcher <- {
	Ammo = 55;
	Hunting = 0.3;
	Fletching = 0.3;
	Scout = 0.3;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.25, //forest
		0.25, //forest
		0.25, //forest_leaves
		0.25, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.01, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendMuladi <- {
	Ammo = 21;
	Hunting = 0.2;
	Fletching = 0.1;
	Scout = 0.2;
	Gathering = 0.50;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.0, //swamp
		0.025, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.01, //steppes
		0.0, //ocean
		0.025, //desert
		0.025 //oasis
	];
};

::Legends.BackgroundModifiers.LegendNecro <- {
	Meds = 34;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
};

::Legends.BackgroundModifiers.LegendCommanderNecro <- {
	Meds = 34;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
	Crafting = 0.50;
	Gathering = 0.30;
};

::Legends.BackgroundModifiers.LegendNecromancer <- {
	Meds = 34;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
};

::Legends.BackgroundModifiers.LegendNecrosavant <- {
	Meds = 34;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
};

::Legends.BackgroundModifiers.LegendNightwatch <- {
	Scout = 0.2;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.015,//plains
		0.0, //swamp
		0.01, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.015, //farmland
		0.0, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendNoble2h <- {
	ArmorParts = 8;
	Stash = 8;
	Training = 0.1;
};
::Legends.BackgroundModifiers.LegendCommanderNoble <- {
	Ammo = 21;
	ArmorParts = 8;
	Meds = 13;
	Stash = 8;
	Healing = 0.10;
	Injury = 0.03;
	Haggle = 0.005;
	ToolConsumption = 0.01;
	Training = 0.1;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.025,//plains
		0.01, //swamp
		0.01, //hills
		0.01, //forest
		0.01, //forest
		0.01, //forest_leaves
		0.01, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.025, //farmland
		0.011, // snow
		0.015, // badlands
		0.015, //highlands
		0.025, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};


::Legends.BackgroundModifiers.LegendNobleRanged <- {
	Ammo = 21;
	Stash = 8;
	Training = 0.1;
};

::Legends.BackgroundModifiers.LegendNobleShield <- {
	ArmorParts = 8;
	Stash = 8;
	Injury = 0.03;
	Training = 0.1;
};

::Legends.BackgroundModifiers.LegendCommanderPeddler <- {
	ArmorParts = 8;
	Meds = 13;
	Stash = 13;
	Haggle = 0.03;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.2, //plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.1, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.1  //oasis
	];
};

::Legends.BackgroundModifiers.LegendPilgrim <- {
	Meds = 13;
	Stash = 8;
	Repair = 0.10;
	Salvage = 0.10;
	Gathering = 0.30;
	Terrain =  [
		0.0, // ?
		0.0, //ocean
		0.01,//plains
		0.0, //swamp
		0.02, //hills
		0.02, //forest
		0.02, //forest
		0.02, //forest_leaves
		0.02, //autumn_forest
		0.01, //mountains
		0.0, // ?
		0.01, //farmland
		0.0, // snow
		0.02, // badlands
		0.02, //highlands
		0.02, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendPreserver <- {
	Meds = 21;
	Stash = 5;
	Healing = 0.10;
	Injury = 0.03;
	Crafting = 0.50;
	MedConsumption = 0.20;
	Gathering = 1.0;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.10, //forest
		0.10, //forest
		0.10, //forest_leaves
		0.10, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.02, // snow
		0.02, // badlands
		0.02, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendPuppet <- {
	Stash = 5;
	Hunting = 0.1;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, //snow
		0.0, //badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendPuppetMaster <- {
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendQiyan <- {
	Haggle = 0.02;
	Stash = 8;
	Scout = 0.1;
};

::Legends.BackgroundModifiers.LegendRanger <- {
	Ammo = 55;
	Stash = 5;
	Hunting = 0.2;
	Fletching = 0.2;
	Scout = 0.3;
	Training = 0.1;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.05, //forest
		0.05, //forest
		0.05, //forest_leaves
		0.05, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.01, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendCommanderRanger <- {
	Ammo = 55;
	Stash = 5;
	Hunting = 0.2;
	Fletching = 0.2;
	Scout = 0.3;
	Training = 0.1;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.0, //swamp
		0.0, //hills
		0.05, //forest
		0.05, //forest
		0.05, //forest_leaves
		0.05, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.01, // snow
		0.01, // badlands
		0.01, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendShieldmaiden <- {
	Repair = 0.30;
	Salvage = 0.10;
	Training = 0.2;
};

::Legends.BackgroundModifiers.LegendSurgeon <- {
	Meds = 34;
	Healing = 0.50;
	Injury = 0.10;
	MedConsumption = 0.10;
};

::Legends.BackgroundModifiers.LegendTaxidermist <- {
	Healing = 0.10;
	Crafting = 1.00;
	ToolConsumption = 0.01;
	MedConsumption = 0.10;
};

::Legends.BackgroundModifiers.LegendVala <- {
	Meds = 21;
	Healing = 0.50;
	Injury = 0.10;
	Enchanting = 1.0;
};

::Legends.BackgroundModifiers.LegendWarlock <- {
	Meds = 34;
	Stash = 5;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
};

::Legends.BackgroundModifiers.LegendWarlockSummoner <- {
	Meds = 13;
	Stash = 5;
	MedConsumption = 0.05;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0,//plains
		0.1, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};

::Legends.BackgroundModifiers.LegendCommanderWitch <- {
	Meds = 34;
	Stash = 8;
	Healing = 0.30;
	Injury = 0.06;
	MedConsumption = 0.20;
};

::Legends.BackgroundModifiers.LegendYoungblood <- {
	Salvage = 0.10;
	Crafting = 0.50;
	Gathering = 0.50;
	ToolConsumption = 0.01;
	Fletching = 0.1;
	Terrain = [
		0.0, // ?
		0.0, //ocean
		0.0, //plains
		0.015, //swamp
		0.0, //hills
		0.0, //forest
		0.0, //forest
		0.0, //forest_leaves
		0.0, //autumn_forest
		0.0, //mountains
		0.0, // ?
		0.0, //farmland
		0.0, // snow
		0.0, // badlands
		0.0, //highlands
		0.0, //steppes
		0.0, //ocean
		0.0, //desert
		0.0 //oasis
	];
};
