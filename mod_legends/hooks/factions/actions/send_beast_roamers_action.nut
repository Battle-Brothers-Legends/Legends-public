::mods_hookExactClass("factions/actions/send_beast_roamers_action", function (o) {
	o.create = function () {
		this.m.ID = "send_beast_roamers_action";
		this.m.Cooldown = 5.0;
		this.faction_action.create();
		
		local beasts = [
			{
				Name = "Alps",
				Spawn = ::Const.World.Spawn.Alps,
				Description = "Pale and haggard creatures creeping around.",
				Footprints = ::Const.World.FootprintsType.Alps,
				Flag = "IsAlps",
				MinDays = 15,
				SpawnChance = 75,
				DistanceScalingMult = 2.0,
				MaxDistToSettlements = 35,
				Lists = [this.m.BeastsMedium],
				DisallowedTerrainTypes = [
					::Const.World.TerrainType.Mountains,
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.SwampForest,
					::Const.World.TerrainType.SwampGreen,
					::Const.World.TerrainType.AutumnForest,
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.Swamp,
					::Const.World.TerrainType.Hills
				],
				SetRoam = function (_roam) {
					_roam.setAllTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Mountains, false);
					_roam.setTerrain(::Const.World.TerrainType.Ocean, false);
					_roam.setTerrain(::Const.World.TerrainType.Shore, false);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Hills, false);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Forest, false);
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, false);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, false);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.Swamp, false);
						_roam.setTerrain(::Const.World.TerrainType.SwampGreen, false);
					}
				}
			},
			{
				Name = "Basilisks",
				Spawn = ::Const.World.Spawn.LegendBasiliskLOW,
				Description = "A chaotic swarm of Basilisks",
				Footprints = ::Const.World.FootprintsType.Basilisks,
				Lists = [this.m.BeastsLow],
				MinY = 0.2,
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.AutumnForest
				],
				SlowerAtNight = true,
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.SnowyForest, false);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					} else if (r == 5) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					} else if (r == 6) {
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					} else if (r == 7) {
						_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					}
				}
			},
			{
				Name = "Direwolves",
				Spawn = ::Const.World.Spawn.Direwolves,
				Description = "A pack of ferocious direwolves on the hunt for prey.",
				Footprints = ::Const.World.FootprintsType.Direwolves,
				Lists = [this.m.BeastsLow],
				MinY = 0.2,
				AllowedTerrainTypes = [
					::Const.World.TerrainType.AutumnForest,
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.LeaveForest, 
					::Const.World.TerrainType.SnowyForest,
				],
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					} else if (r == 5) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					} else if (r == 6) {
						_roam.setTerrain(::Const.World.TerrainType.Snow, true);
					} else if (r == 7) {
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					} else if (r == 8) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
					} else if (r == 9) {
						_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					}
				}
			},
			{
				Name = "Hexen",
				MinDays = 20,
				SpawnChance = 90,
				Lists = [this.m.BeastsMedium],
				DisallowedTerrainTypes = [
					::Const.World.TerrainType.Mountains,
					::Const.World.TerrainType.Hills,
					::Const.World.TerrainType.Snow,
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.Desert,
					::Const.World.TerrainType.Oasis
				],
				MinDistToSettlements = 8,
				MinY = 0.1,
				MaxY = 0.9,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.HexenAndMore,
				Description = "A malevolent old crone, said to lure and abduct little children to make broth and concoctions out of, strike sinister pacts with villagers, and weave curses.",
				Footprints = ::Const.World.FootprintsType.Hexen,
				SetRoam = function(_roam) {
					_roam.setAllTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Mountains, false);
					_roam.setTerrain(::Const.World.TerrainType.Ocean, false);
					_roam.setTerrain(::Const.World.TerrainType.Shore, false);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Forest, true);
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
						_roam.setTerrain(::Const.World.TerrainType.Urban, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
						_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					}
				}
			},
			{
				Name = "Hyenas",
				Spawn = ::Const.World.Spawn.Hyenas,
				Description = "A pack of esurient hyenas on the hunt for prey.",
				Footprints = ::Const.World.FootprintsType.Hyenas,
				Lists = [this.m.BeastsLow],
				MaxY = 0.2,
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Desert,
					::Const.World.TerrainType.Oasis,
					::Const.World.TerrainType.Hills
				],
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Desert, true);
					_roam.setTerrain(::Const.World.TerrainType.Oasis, true);
					_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					local r = ::Math.rand(1, 10);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					} else if (r == 5) {
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					}
				}
			},
			{
				Name = "Ifrits",
				MinDays = 20,
				Lists = [],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Desert,
					::Const.World.TerrainType.Oasis,
					::Const.World.TerrainType.Hills
				],
				MinDistToSettlements = function(_nearTile) { return 16 - (_nearTile == null ? 0 : 10); },
				MaxDistToSettlements = 100,
				MaxY = 0.2,
				Spawn = ::Const.World.Spawn.SandGolems,
				Description = "Creatures of living stone shaped by the blistering heat and fire of the burning sun of the south.",
				Footprints = ::Const.World.FootprintsType.SandGolems,
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Desert, true);
					_roam.setTerrain(::Const.World.TerrainType.Oasis, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
				}
			},
			{
				Name = "Lindwurm",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Steppe,
					::Const.World.TerrainType.Desert
				],
				MinDistToSettlements = function(_nearTile) { return 18 - (_nearTile == null ? 0 : 10); },
				MinY = 0.1,
				MaxY = 0.5,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.Lindwurm,
				Description = "A Lindwurm - a wingless bipedal dragon resembling a giant snake.",
				Footprints = ::Const.World.FootprintsType.Lindwurms,
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					_roam.setTerrain(::Const.World.TerrainType.Desert, true);
					_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
						_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					}
				}
			},
			{
				Name = "Nachzehrers",
				Spawn = ::Const.World.Spawn.Ghouls,
				Description = "A flock of scavenging nachzehrers.",
				Footprints = ::Const.World.FootprintsType.Ghouls,
				Lists = [this.m.BeastsLow],
				MaxDistToSettlements = 35,
				MaxY = 0.75,
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Plains,
					::Const.World.TerrainType.Steppe
				],
				SetRoam = function (_roam) {
					_roam.setAllTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Mountains, false);
					_roam.setTerrain(::Const.World.TerrainType.Ocean, false);
					_roam.setTerrain(::Const.World.TerrainType.Shore, false);
				}
			},
			{
				Name = "Schrats",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.AutumnForest
				],
				MinDistToSettlements = function(_nearTile) { return 20 - (_nearTile == null ? 0 : 11); },
				MaxDistToSettlements = 100,
				MinY = 0.1,
				MaxY = 0.9,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.Schrats,
				Description = "A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.",
				Footprints = ::Const.World.FootprintsType.Schrats,
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
						_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					}
					_roam.setMinRange(1);
					_roam.setMaxRange(4);
				}
			},
			{
				Name = "Serpents",
				Spawn = ::Const.World.Spawn.Serpents,
				Description = "Giant serpents slithering about.",
				Footprints = ::Const.World.FootprintsType.Serpents,
				Lists = [],
				MinDays = 15,
				MaxY = 0.2,
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Desert,
					::Const.World.TerrainType.Oasis
				],
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Desert, true);
					_roam.setTerrain(::Const.World.TerrainType.Oasis, true);
					_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
				}
			},
			{
				Name = "Unholds",
				Spawn = ::Const.World.Spawn.Unhold,
				Description = "One or more lumbering giants.",
				Footprints = ::Const.World.FootprintsType.Unholds,
				Flag = "IsUnholds",
				SlowerAtNight = true,
				MinDays = 10,
				MaxY = 0.9,
				Lists = [this.m.BeastsMedium],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Tundra,
					::Const.World.TerrainType.Hills,
					::Const.World.TerrainType.Mountains
				],
				MinDistToSettlements = function (_nearTile) {
					return 10 - (_nearTile == null ? 0 : 2);
				},
				MaxDistToSettlements = 100,
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
					_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					} else if (r == 5) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					} else if (r == 6) {
						_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					} else if (r == 7) {
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					} else if (r == 8) {
						_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					} else if (r == 9) {
						_roam.setTerrain(::Const.World.TerrainType.Snow, true);
					}
				}
			},
			{
				Name = "Frost Unholds",
				Spawn = ::Const.World.Spawn.UnholdFrost,
				Description = "One or more lumbering giants covered in white fur.",
				Footprints = ::Const.World.FootprintsType.Unholds,
				Flag = "IsUnholds",
				SlowerAtNight = true,
				MinDays = 10,
				MinY = 0.7,
				MinDistToSettlements = 5,
				MaxDistToSettlements = 100,
				Lists = [this.m.BeastsMedium],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Snow,
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.Tundra
				],				
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Snow, true);
					_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					local r = ::Math.rand(1, 20);
					if (r <= 5) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
					} else if (r >= 18) {
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					}
				}
			},
			{
				Name = "Bog Unholds",
				Spawn = ::Const.World.Spawn.UnholdBog,
				Description = "One or more lumbering giants covered in fungal growth and moss.",
				Footprints = ::Const.World.FootprintsType.Unholds,
				Flag = "IsUnholds",
				SlowerAtNight = true,
				MinDays = 10,
				MinDistToSettlements = function (_nearTile) {
					return 10 - (_nearTile == null ? 0 : 2);
				},
				MaxDistToSettlements = 100,
				Lists = [this.m.BeastsMedium],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Swamp,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.Oasis
				],
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Oasis, true);
						_roam.setTerrain(::Const.World.TerrainType.Shore, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					}
				}
			},
			{
				Name = "Webknechts",
				Spawn = ::Const.World.Spawn.Spiders,
				Description = "A swarm of webknechts skittering about.",
				Footprints = ::Const.World.FootprintsType.Spiders,
				Flag = "IsWebknechts",
				Lists = [this.m.BeastsLow],
				MaxDistToSettlements = 40,
				MinY = 0.2,
				MaxY = 0.8,
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.AutumnForest
				],
				SetRoam = function (_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					_roam.setMinRange(1);
					_roam.setMaxRange(4);
				}
			},
			// Legends beasts start here
			{
				Name = "Greenwood Schrats",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.AutumnForest
				],
				MinDistToSettlements = function(_nearTile) { return 20 - (_nearTile == null ? 0 : 11); },
				MaxDistToSettlements = 100,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.LegendGreenwoodSchrat,
				Description = "A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.",
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
					}
					_roam.setMinRange(1);
					_roam.setMaxRange(2);
				}
			},
			{
				Name = "Rock Unhold",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [::Const.World.TerrainType.Mountains],
				MinDistToSettlements = function(_nearTile) { return 18 - (_nearTile == null ? 0 : 10); },
				MaxDistToSettlements = 100,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.LegendRockUnhold,
				Description = "One or more lumbering giants whose skin is as hard as rock and virtually impenetrable save for the best weapons.",
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
						_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					}
				}
			},
			{
				Name = "Redback Spider",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.AutumnForest,
					::Const.World.TerrainType.Forest
				],
				MinDistToSettlements = function(_nearTile) { return 18 - (_nearTile == null ? 0 : 10); },
				MaxDistToSettlements = 100,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.LegendRedbackSpider,
				Description = "A black-red spider whose poison is known to be especially deadly.",
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Forest, true);
					_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
					_roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
						_roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Desert, true);
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					}
				}
			},
			{
				Name = "Skin Ghoul",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [::Const.World.TerrainType.Swamp],
				MinDistToSettlements = function(_nearTile) { return 18 - (_nearTile == null ? 0 : 10); },
				MaxDistToSettlements = 100,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.LegendSkinGhouls,
				Description = "A terrifying creature, which seems to be wearing the skin of other beings upon its own.",
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Farmland, true);
						_roam.setTerrain(::Const.World.TerrainType.Urban, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					}
				}
			},
			{
				Name = "Stollwurm",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [::Const.World.TerrainType.Hills],
				MinDistToSettlements = function(_nearTile) { return 18 - (_nearTile == null ? 0 : 10); },
				MaxDistToSettlements = 100,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.LegendStollwurm,
				Description = "A Stollwurm - a wingless bipedal dragon resembling a giant snake.",
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Desert, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					}
				}
			},
			{
				Name = "White Wolf",
				MinDays = 25,
				Lists = [this.m.BeastsHigh],
				AllowedTerrainTypes = [
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.Snow
				],
				MinDistToSettlements = function(_nearTile) { return 18 - (_nearTile == null ? 0 : 10); },
				MaxDistToSettlements = 100,
				DistanceScalingMult = 2.0,
				Spawn = ::Const.World.Spawn.LegendWhiteDirewolf,
				Description = "A magnificent creature whose pristine white fur can fetch a high price at a collector's.",
				SetRoam = function(_roam) {
					_roam.setNoTerrainAvailable();
					_roam.setTerrain(::Const.World.TerrainType.Snow, true);
					_roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					local r = ::Math.rand(1, 20);
					if (r == 1) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
					} else if (r == 2) {
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
					} else if (r == 3) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
					} else if (r == 4) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
						_roam.setTerrain(::Const.World.TerrainType.Forest, true);
						_roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
						_roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					} else if (r == 5) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
						_roam.setTerrain(::Const.World.TerrainType.Hills, true);
						_roam.setTerrain(::Const.World.TerrainType.Plains, true);
					} else if (r == 6) {
						_roam.setTerrain(::Const.World.TerrainType.Tundra, true);
						_roam.setTerrain(::Const.World.TerrainType.Mountains, true);
						_roam.setTerrain(::Const.World.TerrainType.Badlands, true);
						_roam.setTerrain(::Const.World.TerrainType.Steppe, true);
					}
				}
			}
		];

		foreach (beast in beasts) {
			this.addBeast(beast);
		}
		
		local kraken = function (_action, _nearTile = null) { // added separately as its a bit customized
			if (!this.World.Flags.get("IsKrakenDefeated")) {
				return false;
			}

			local disallowedTerrain = [];
			for (local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i) {
				if (i == this.Const.World.TerrainType.Swamp) {
				} else {
					disallowedTerrain.push(i);
				}
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 25, 1000, 1000, 3, 0, _nearTile);

			if (tile == null || _action.getDistanceToNextAlly(tile) <= 10) {
				return false;
			}

			local party = _action.getFaction().spawnEntity(tile, "Kraken", false, ::Const.World.Spawn.Kraken, 1000);
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A tentacled horror from another age.");
			party.setFootprintType(this.Const.World.FootprintsType.Kraken);
			party.setSlowerAtNight(true);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(this.Const.World.TerrainType.Swamp, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(kraken);
	}

	o.onUpdate = function (_faction) {
		foreach (u in _faction.getUnits()) {
			if (!u.isDiscovered() && ::Time.getVirtualTimeF() - u.getSpawnTime() >= 20.0 * ::World.getTime().SecondsPerDay && !u.getSprite("selection").Visible && (::World.State.getPlayer() == null || ::World.State.getPlayer().getTile().getDistanceTo(u.getTile()) >= 8)) {
				u.die();
				break;
			}
		}

		if (_faction.getUnits().len() >= 20) {
			return;
		}

		this.m.Score = 10;
	}

	o.onExecute = function (_faction) {
		this.m.Cooldown = 0.0;
		for (local i = 0; i < 20 - _faction.getUnits().len(); i++) {
			local r = ::World.getTime().Days <= 9 ? ::Math.rand(0, this.m.BeastsLow.len() - 1) : ::Math.rand(0, this.m.Options.len() - 1);

			if (this.m.Options[r](this)) {
				this.m.Cooldown = 5.0;
				break;
			}
		}
	}

	o.addBeast <- function (_config) {
		local beast = this.createBeastParty(_config);
        this.m.Options.push(beast);
        foreach (list in _config.Lists) {
            list.push(beast);
        }
	}

	o.createBeastParty <- function (_config) {
		return function ( _action, _nearTile = null ) {
			if (("MinDays" in _config) && ::World.getTime().Days < _config.MinDays	&& _nearTile == null) {
				return false;
			}

			if (("SpawnChance" in _config) && ::Math.rand(1, 100) > _config.SpawnChance && _nearTile == null) {
				return false;
			}

			local minDistToSettlements = "MinDistToSettlements" in _config ? _config.MinDistToSettlements : 7;
			if (typeof minDistToSettlements == "function") {
				minDistToSettlements = minDistToSettlements(_nearTile);
			}

			local disallowedTerrain = [];
				if ("AllowedTerrainTypes" in _config) {
					for (local i = 0; i < ::Const.World.TerrainType.COUNT; i++) {
						if (_config.AllowedTerrainTypes.find(i) == null) {
							disallowedTerrain.push(i);
						}
					}
				} else if ("DisallowedTerrainTypes" in _config) {
					disallowedTerrain = _config.DisallowedTerrainTypes;
				}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, minDistToSettlements, "MaxDistToSettlements" in _config ? _config.MaxDistToSettlements : 50, 1000, 3, 0, _nearTile, "MinY" in _config ? _config.MinY : 0.0, "MaxY" in _config ? _config.MaxY : 1.0);


			if (tile == null) {
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= 10 / (_nearTile == null ? 1 : 2)) {
				return false;
			}

			local party = _action.getFaction().spawnEntity(tile, _config.Name, false, _config.Spawn, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Const.World.Scaling.Beasts.getDistanceScaling(_action, tile, "DistanceScalingMult" in _config ? _config.DistanceScalingMult : 1.0));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription(_config.Description);
			party.setFootprintType(_config.Footprints);
			party.setSlowerAtNight("SlowerAtNight" in _config ? _config.SlowerAtNight : false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);

			if ("Flag" in _config) {
				party.getFlags().set(_config.Flag, true);
			}

			local roam = ::new("scripts/ai/world/orders/roam_order");
			if ("SetRoam" in _config) {
				_config.SetRoam(roam);
			}
			party.getController().addOrder(roam);
			return true;
		}
	}
});
