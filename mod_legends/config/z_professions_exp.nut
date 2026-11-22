if (!("Professions" in ::Legends)) {
	::Legends.Professions <- {};
}

// Profession experience is counted in hours of work at a camp station
::Legends.Professions.Exp <- {
	// Hours needed for each profession level: 8h, 1d, 3d, 5d, 10d, 25d, 100d, 500d, 5000d. Each level grants a profession point
	Levels = [8, 24, 72, 120, 240, 600, 2400, 12000, 120000],
	// Share of the experience that is earned while the station is not at work
	PassiveMult = 0.1,
	// Bonus of the Scholar profession, applied after the experience is split between the workers
	ScholarMult = 1.2,
	// Camp stations that grant experience and the working speed that scales it, in the order they are listed in the Professions tab
	Stations = [
		{ ID = ::Legends.Camp.CampBuildings.Healer, Modifier = "Healing", Name = "Healing", Icon = "ui/icons/banner_heal_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Repair, Modifier = "Repair", Name = "Repairing", Icon = "ui/icons/banner_repair_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Workshop, Modifier = "Salvage", Name = "Salvaging", Icon = "ui/icons/banner_scrap_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Crafting, Modifier = "Crafting", Name = "Crafting", Icon = "ui/icons/banner_craft_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Scout, Modifier = "Scout", Name = "Scouting", Icon = "ui/icons/banner_scout_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Training, Modifier = "Training", Name = "Training", Icon = "ui/icons/banner_train_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Fletcher, Modifier = "Fletching", Name = "Fletching", Icon = "ui/icons/banner_fletch_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Gatherer, Modifier = "Gathering", Name = "Gathering", Icon = "ui/icons/banner_gather_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Kitchen, Modifier = "Cooking", Name = "Cooking", Icon = "ui/icons/banner_cook_icon.png" },
		{ ID = ::Legends.Camp.CampBuildings.Enchanter, Modifier = "Enchanting", Name = "Enchanting", Icon = "ui/icons/banner_enchant_icon.png" }
	]
};
