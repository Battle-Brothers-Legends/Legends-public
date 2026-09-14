::Legends.World <- {};
::Legends.World.LegendaryLocations <- {
	Order = [
		"BlackMonolith",
		"GoblinCity",
		"UnholdGraveyard",
		"FountainOfYouth",
		"WitchHut",
		"WaterWheel",
		"KrakenCult",
		"IcyCave",
		"HuntingGround",
		"AncientWatchTower",
		"LandShip",
		"AncientStatue",
		"AncientTemple",
		"SunkenLibrary",
		"HolySite1",
		"HolySite2",
		"HolySite3",
		"GolemLocation1",
		"GolemLocation2",
		"LegendMummyPyramid",
		"LegendGrandTournament"
	],
	BlackMonolith = {
		ID = "location.black_monolith",
		Script = "scripts/entity/world/locations/legendary/black_monolith_location",
		AllowedTerrainTypes = [
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Plains
		],
		MinDistToSettlements = 45,
		OnSpawned = function (_action, _camp, _tile) {
			_tile.TacticalType = ::Const.World.TerrainTacticalType.Quarry;
		}
	},
	GoblinCity = {
		ID = "location.goblin_city",
		Script = "scripts/entity/world/locations/legendary/unique_goblin_city_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Hills, ::Const.World.TerrainType.Mountains],
		MinDistToSettlements = 30,
		OnSpawned = function (_action, _camp, _tile) {
			local goblins = ::World.FactionManager.getFactionOfType(::Const.FactionType.Goblins);
			local banner = _action.getAppropriateBanner(_camp, goblins.getSettlements(), 15, ::Const.GoblinBanners);
			_camp.setBanner(banner);
			goblins.addSettlement(_camp, false);
		}
	},
	UnholdGraveyard = {
		ID = "location.unhold_graveyard",
		Script = "scripts/entity/world/locations/legendary/unhold_graveyard_location",
		RequiredDLC = ::Const.DLC.Unhold,
		DisallowedTerrainTypes = [
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest
		],
		MinDistToSettlements = 25
	},
	FountainOfYouth = {
		ID = "location.fountain_of_youth",
		Script = "scripts/entity/world/locations/legendary/fountain_of_youth_location",
		AllowedTerrainTypes = [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest
		],
		MinDistToSettlements = 40
	},
	WitchHut = {
		ID = "location.witch_hut",
		Script = "scripts/entity/world/locations/legendary/witch_hut_location",
		AllowedTerrainTypes = [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest
		],
		SpawnArgs = [15, 25, 1001, 15, 15],
		MinDistToSettlements = 15,
		MaxDistToSettlements = 25,
		OnSpawned = function (_action, _camp, _tile) {
			_tile.TacticalType = ::Const.World.TerrainTacticalType.Plains;
		}
	},
	WaterWheel = {
		ID = "location.waterwheel",
		Script = "scripts/entity/world/locations/legendary/waterwheel_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Plains],
		MinDistToSettlements = 15,
		MaxDistToSettlements = 30
	},
	KrakenCult = {
		ID = "location.kraken_cult",
		Script = "scripts/entity/world/locations/legendary/kraken_cult_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Swamp],
		MinDistToSettlements = 25,
		MaxDistToSettlements = 1000
	},
	IcyCave = {
		ID = "location.icy_cave_location",
		Script = "scripts/entity/world/locations/legendary/icy_cave_location",
		AllowedTerrainTypes = [
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.SnowyForest
		],
		MinDistToSettlements = 10,
		MaxDistToSettlements = 35,
		MinDistToEnemyLocations = 10,
		MinDistToAlliedLocations = 10,
		OnSpawned = function (_action, _camp, _tile) {
			::World.Flags.set("IjirokStage", 0);
			_tile.TacticalType = ::Const.World.TerrainTacticalType.Snow;
		}
	},
	HuntingGround = {
		ID = "location.tundra_elk_location",
		Script = "scripts/entity/world/locations/legendary/tundra_elk_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Tundra],
		MinDistToSettlements = 15,
		MaxDistToSettlements = 99
	},
	AncientWatchTower = {
		ID = "location.ancient_watchtower",
		Script = "scripts/entity/world/locations/legendary/ancient_watchtower_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Mountains, ::Const.World.TerrainType.Hills],
		MinDistToSettlements = 25,
		MaxDistToSettlements = 60,
		MinY = ::Const.DLC.Desert ? 0.15: 0.0
	},
	LandShip = {
		ID = "location.land_ship",
		Script = "scripts/entity/world/locations/legendary/land_ship_location",
		DisallowedTerrainTypes = [::Const.World.TerrainType.Mountains],
		MinDistToSettlements = 15,
		MaxDistToSettlements = 30,
		MaxDistanceToAllies = 1000
	},
	AncientStatue = {
		ID = "location.ancient_statue",
		Script = "scripts/entity/world/locations/legendary/ancient_statue_location",
		DisallowedTerrainTypes = [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.Forest
		],
		MinDistToSettlements = 20,
		MaxDistToSettlements = 35
	},
	AncientTemple = {
		ID = "location.ancient_temple",
		Script = "scripts/entity/world/locations/legendary/ancient_temple_location",
		DisallowedTerrainTypes = [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.Desert
		],
		MinDistToSettlements = 20,
		MaxDistToSettlements = 40
	},
	SunkenLibrary = {
		ID = "location.sunken_library",
		Script = "scripts/entity/world/locations/legendary/sunken_library_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Desert],
		MinDistToSettlements = 18,
		MaxDistToSettlements = 50
	},
	HolySite1 = {
		ID = "location.holy_site.meteorite",
		Script = "scripts/entity/world/locations/legendary/meteorite_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Steppe, ::Const.World.TerrainType.Plains],
		MinDistToSettlements = 8,
		MaxDistToSettlements = 25,
		MinDistToEnemyLocations = 8,
		MinDistToAlliedLocations = 8,
		MinY = 0.1,
		MaxY = 0.35
	},
	HolySite2 = {
		ID = "location.holy_site.oracle",
		Script = "scripts/entity/world/locations/legendary/oracle_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Desert, ::Const.World.TerrainType.Steppe],
		MinDistToSettlements = 8,
		MaxDistToSettlements = 25,
		MinDistToEnemyLocations = 8,
		MinDistToAlliedLocations = 8
	},
	HolySite3 = {
		ID = "location.holy_site.vulcano",
		Script = "scripts/entity/world/locations/legendary/vulcano_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Desert],
		SpawnArgs = [8, 25, 1001, 8, 8, null, 0.1],
		MinDistToSettlements = 8,
		MaxDistToSettlements = 25,
		MinDistToEnemyLocations = 8,
		MinDistToAlliedLocations = 8,
		MinY = 0.1
	},
	GolemLocation1 = {
		ID = "location.abandoned_village",
		Script = "scripts/entity/world/locations/legendary/abandoned_village_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Plains, ::Const.World.TerrainType.Tundra],
		MinDistToSettlements = 6,
		MaxDistToSettlements = 21,
		MinDistToEnemyLocations = 8,
		MinDistToAlliedLocations = 8
	},
	GolemLocation2 = {
		ID = "location.artifact_reliquary",
		Script = "scripts/entity/world/locations/legendary/artifact_reliquary_location",
		AllowedTerrainTypes = [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Tundra
		],
		MinDistToSettlements = 12,
		MaxDistToSettlements = 25
	}
	LegendMummyPyramid = {
		ID = "location.legend_mummy",
		Script = "scripts/entity/world/locations/legendary/legend_mummy_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Desert],
		MinDistToSettlements = 15,
		MaxDistToSettlements = 25,
		MinY = 0.1
	},
	LegendGrandTournament = {
		ID = "location.legend_tournament",
		Script = "scripts/entity/world/locations/legendary/legend_tournament_location",
		AllowedTerrainTypes = [::Const.World.TerrainType.Hills, ::Const.World.TerrainType.Mountains],
		MinDistToSettlements = 15,
		MaxDistToSettlements = 30
	}
}
