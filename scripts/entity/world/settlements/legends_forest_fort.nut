this.legends_forest_fort <- this.inherit("scripts/entity/world/settlements/legends_fort", {
	m = {},
	function create()
	{
		this.legends_fort.create();
		this.m.Names = [[
			"Holzwacht",
			"Tannwall",
			"Waldwacht",
			"Hainturm",
			"Dunkelwacht",
			"Eichwacht",
			"Waidschanze",
			"Fahrnwacht",
			"Mooswehr",
			"Forstwehr",
			"Eulenwacht",
			"Fuchsturm",
			"Finsterwall",
			"Dusterschanze",
			"Finsterwehr",
			"Dornwall",
			"Farnwacht",
			"Grunwall",
			"Eulenturm",
			"Wildwacht",
			"Steinforst",
			"Haselwacht",
			"Nebelwacht",
			"Hirschturm",
			"Schwarzwacht",
			"Steinweiler",
			"Erlenwall",
			"Eibenwacht",
			"Haselwehr",
			"Waldenwehr"
		],[
			"Holzburg",
			"Tannburg",
			"Waldburg",
			"Hainburg",
			"Dunkelburg",
			"Finsterburg",
			"Eichburg",
			"Waidburg",
			"Fahrnburg",
			"Moosburg",
			"Forstburg",
			"Eulenburg",
			"Fuchsburg",
			"Dusterburg",
			"Dornburg",
			"Grunburg",
			"Buchenburg",
			"Haselburg",
			"Breitenburg",
			"Nesselburg",
			"Wurzelburg",
			"Bieberburg",
			"Katzenburg",
			"Wolfsburg",
			"Natternburg",
			"Findelsburg"
		],[
			"Waldfeste",
			"Tannenfeste",
			"Schlangenfeste",
			"Hainfeste",
			"Dunkelfeste",
			"Finsterfeste",
			"Eichfeste",
			"Eibenfeste",
			"Waidfeste",
			"Eulenfeste",
			"Eberfeste",
			"Fahrnfeste",
			"Moosfeste",
			"Forstfeste",
			"Dusterfeste",
			"Dornfeste",
			"Grunfeste",
			"Falkenfeste",
			"Salamanderfeste",
			"Lerchenfeste",
			"Laubfeste",
			"Erlenfeste",
			"Nadelfeste",
			"Waldachfeste",
			"Hornfeste",
			"Klarbachfeste",
			"Eisbachfeste",
			"Fichtenwall"
		]];
		this.m.DraftLists = [[
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Brawler,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.Lumberjack,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Wildman,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Brawler,
			::Legends.Background.Daytaler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Squire
		],[
		 	::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.Gambler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.HedgeKnight,
			::Legends.Background.Raider,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword,
			::Legends.Background.Squire,
			::Legends.Background.Squire,
			::Legends.Background.Swordmaster,
			::Legends.Background.Cripple,
		]];
		this.m.FemaleDraftLists = [[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
::Legends.Background.LegendShieldmaiden,
		],[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
::Legends.Background.LegendShieldmaiden,
		],[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden
		]];

		this.m.StablesLists = [[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey,
			::Legends.Background.LegendHorseDestrier,
			::Legends.Background.LegendHorseCourser
		]];
		if (::Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[1].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
		}
		this.m.Rumors = ::Const.Strings.RumorsForestSettlement;
	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "Surrounded by forest, this small wooden keep controls the surrounding woodlands.";
			case 2:
				return "This mighty stone keep surrounded by forest acts as a base of operations in the area.";
			case 3:
				return "This citadel towers high over the surrounding forests and dominates the region.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A military strongpoint surrounded by woods";
			case 2:
				return "A mighty stone keep surrounded by woods.";
			case 3:
				return "A citadel towering high over the surrounding woods";
			default:
				return null;
		}
	}

	function buildNewLocation()
	{
		local ALL = [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		];
		local items = [
			[1, {
				Script = "scripts/entity/world/attached_location/fletchers_hut_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/hunters_cabin_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/lumber_camp_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/leather_tanner_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/herbalists_grove_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}]
		];

		switch (this.m.Size)
		{
			case 1:
				items.extend([
					[1, {
						Script = "scripts/entity/world/attached_location/wooden_watchtower_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 4,
						Road = true,
						Clear = true,
						Force = true
					}]
				]);
				break;
			case 2:
				items.extend([
					[1, {
						Script = "scripts/entity/world/attached_location/stone_watchtower_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 5,
						Road = true,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/fortified_outpost_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 1,
						Road = true,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/wheat_fields_location",
						Terrain = [::Const.World.TerrainType.Plains],
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}]
				]);
				break;
			case 3:
				items.extend([
					[1, {
						Script = "scripts/entity/world/attached_location/fortified_outpost_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 1,
						Road = true,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/ore_smelters_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/blast_furnace_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/workshop_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/stone_watchtower_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 5,
						Road = true,
						Clear = true,
						Force = true
					}],
					[1, {
						Script = "scripts/entity/world/attached_location/wheat_fields_location",
						Terrain = [::Const.World.TerrainType.Plains],
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}]
				]);
				break;
		}

		items = this.filterNewLocation(items);
		local item = ::Const.World.Common.pickItem(items);
		return this.buildAttachedLocation(1, item.Script, item.Terrain, item.NearTerrain, item.Distance, item.Road, item.Clear, item.Force);
	}

	function onBuildOne( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (::Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (::Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else
		{
			local r = ::Math.rand(1, 4);

			if (r == 1 || ::Const.World.Buildings.Fletchers == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		], 0, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], 4, true);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));

		if (::Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (::Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else
		{
			local r = ::Math.rand(1, 4);

			if (r == 1)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		], 0, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
	}

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);


		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
		{
			local ALL = [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			];
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);

			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", ALL, [], 1, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/lumber_camp_location", ALL, [], 1, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 0, false, true, true);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));

		if (::Math.rand(1, 100) <= 80)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 2);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 2);
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		], 1, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/lumber_camp_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		], 1, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
	}

});

