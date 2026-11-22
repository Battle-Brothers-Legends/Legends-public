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
	// Camp stations that grant experience and the working speed that scales it
	Stations = {
		[::Legends.Camp.CampBuildings.Crafting] = "Crafting",
		[::Legends.Camp.CampBuildings.Enchanter] = "Enchanting",
		[::Legends.Camp.CampBuildings.Fletcher] = "Fletching",
		[::Legends.Camp.CampBuildings.Gatherer] = "Gathering",
		[::Legends.Camp.CampBuildings.Healer] = "Healing",
		[::Legends.Camp.CampBuildings.Kitchen] = "Cooking",
		[::Legends.Camp.CampBuildings.Repair] = "Repair",
		[::Legends.Camp.CampBuildings.Scout] = "Scout",
		[::Legends.Camp.CampBuildings.Training] = "Training",
		[::Legends.Camp.CampBuildings.Workshop] = "Salvage"
	}
};
