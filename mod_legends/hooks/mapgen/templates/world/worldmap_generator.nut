::mods_hookNewObjectOnce("mapgen/templates/world/worldmap_generator", function (o) {
	o.m.BridgeWideningChance <- 45; // change this if you want bridges to be more regularly wider
	o.m.BridgeMinIslandSize <- 50; // minimum island size to create a bridge to

	o.isWorldAcceptable = function (_rect) {
		local ocean = ::World.getNumOfTilesWithType([::Const.World.TerrainType.Ocean]);
		local nonOcean = _rect.W * _rect.H - ocean * 1.0;
    	local ratio = nonOcean / (ocean * 1.0);
    	this.logInfo("Land/Ocean ratio: " + ::Const.World.Settings.MaxLandToWaterRatio + " >= " + ratio + " >= " + ::Const.World.Settings.MinLandToWaterRatio + " :: Land: " + nonOcean + " Ocean: " + ocean);
		return (ratio >= ::Const.World.Settings.MinLandToWaterRatio) && (ratio <= ::Const.World.Settings.MaxLandToWaterRatio);
	}

	o.isDesertAcceptable = function (_rect) {
		local desert = ::World.getNumOfTilesWithType([
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis,
			::Const.World.TerrainTacticalType.DesertHills
		]);
		this.logInfo("Desert tiles: " + desert + " >= " + ::Const.World.Settings.MinDesertTiles);
		return desert >= ::Const.World.Settings.MinDesertTiles;
	}

	local fill = o.fill;
	o.fill = function (_rect, _properties, _pass = 1) {
		if (::Legends.IsStartingNewCampaign) {
			::Const.World.settingsUpdate(); //
			::logInfo("Generating world with following settings...");
			foreach (k, v in ::Const.World.Settings) {
				::logInfo(k + " : " + v);
			}
			_properties = ::World.State.m.CampaignSettings;
		}

		return fill(_rect, _properties, _pass);
	}
	// o.fill = function ( _rect, _properties)
	// {
	// 	this.Const.World.Buildings.reset();
	// 	this.m.Tiles = [];
	// 	this.m.Tiles.resize(this.Const.World.TerrainType.COUNT);

	// 	for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
	// 	{
	// 		if (this.Const.World.TerrainScript[i].len() != 0)
	// 		{
	// 			this.m.Tiles[i] = this.MapGen.get(this.Const.World.TerrainScript[i]);
	// 		}
	// 	}

	// 	this.__ping();

	// 	while (true)
	// 	{
	// 		this.buildLandAndSea(_rect);
	// 		this.__ping();

	// 		if (!this.isWorldAcceptable(_rect))
	// 		{
	// 			this.logInfo("World rejected. Creating new one...");
	// 			this.clearWorld(_rect);
	// 			continue;
	// 		}

	// 		this.__ping();
	// 		this.buildElevation(_rect);
	// 		this.__ping();
	// 		this.__ping();
	// 		this.defragmentTerrain(_rect);
	// 		this.__ping();

	// 		if (this.Const.DLC.Desert && !this.isDesertAcceptable(_rect))
	// 		{
	// 			this.logInfo("World rejected. Creating new one...");
	// 			this.clearWorld(_rect);
	// 			continue;
	// 		}

	// 		this.logInfo("World accepted.");
	// 		break;
	// 	}

	// 	this.__ping();
	// 	this.removeStraits(_rect);
	// 	this.__ping();
	// 	this.refineTerrain(_rect, null);
	// 	this.__ping();
	// 	this.buildSettlements(_rect, _properties);
	// 	this.__ping();
	// 	this.buildRoads(_rect, null);
	// 	this.__ping();
	// 	this.refineSettlements(_rect, null);
	// 	this.__ping();
	// 	this.guaranteeAllBuildingsInSettlements();
	// 	this.__ping();
	// 	this.buildAdditionalRoads(_rect, null);
	// 	this.__ping();
	// 	this.buildRoadSprites(_rect, null);
	// 	this.__ping();
	// 	this.buildLabels(_rect);
	// 	this.__ping();

	// 	if (this.Const.DLC.Desert)
	// 	{
	// 		this.buildAbandonedFortresses(_rect);
	// 	}

	// 	this.__ping();
	// }
	// {
	// 	this.Const.World.Buildings.reset();
	// 	this.m.Tiles = [];
	// 	this.m.Tiles.resize(this.Const.World.TerrainType.COUNT);

	// 	for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
	// 	{
	// 		if (this.Const.World.TerrainScript[i].len() != 0)
	// 		{
	// 			this.m.Tiles[i] = this.MapGen.get(this.Const.World.TerrainScript[i]);
	// 		}
	// 	}

	// 	this.__ping();
	// 	this.LoadingScreen.updateProgress("Building Land and Sea ...");
	// 	this.buildLandAndSea(_rect);
	// 	this.__ping();
	//	 if (!this.isWorldAcceptable(_rect))
	//	 {
	//		 this.clearWorld(_rect);
	//		 return false;
	//	 }

	// 	this.__ping();
	// 	this.LoadingScreen.updateProgress("Building Terrain ...");
	// 	this.buildElevation(_rect);
	// 	this.__ping();

	// 	this.__ping();
	// 	this.defragmentTerrain(_rect);
	// 	this.__ping();

	// 	if (this.Const.DLC.Desert && !this.isDesertAcceptable(_rect))
	// 	{
	// 		//this.logInfo("World rejected. Creating new one...");
	// 		this.clearWorld(_rect);
	// 		return false;
	// 	}

	// 	this.removeStraits(_rect);
	// 	this.__ping();
	// 	this.refineTerrain(_rect, _properties);
	// 	this.__ping();
	//	 if (!this.buildSettlements(_rect, _properties))
	//	 {
	// 		this.clearWorld(_rect);
	// 		//this.World.clearScene();
	//		 return false;
	//	 }
	// 	this.__ping();
	// 	this.buildRoads(_rect, _properties);
	// 	this.__ping();
	// 	this.refineSettlements(_rect, _properties);
	// 	this.__ping();
	// 	this.guaranteeAllBuildingsInSettlements();
	// 	this.__ping();
	// 	if ( _properties.AllTradeLocations )
	// 	{
	// 		this.guaranteeAllLocations(_rect, _properties);
	// 		this.__ping();
	// 	}
	// 	this.buildAdditionalRoads(_rect, _properties);
	// 	this.__ping();
	// 	this.buildRoadSprites(_rect, _properties);
	// 	this.__ping();
	// 	this.buildLabels(_rect);
	// 	this.__ping();
	// 	if (this.Const.DLC.Desert)
	// 	{
	// 		this.buildAbandonedFortresses(_rect);
	// 	}
	// 	this.__ping();

	//	 return true;
	// }

	o.buildBridges <- function (_rect) {
		this.logInfo("Bridging disconnected continents...");
		local checked = {};
		local islands = [];

		// use BFS to get the map's islands and their sizes
		for (local x = _rect.X; x < _rect.X + _rect.W; x++) {
			for (local y = _rect.Y; y < _rect.Y + _rect.H; y++) {
				local tile = this.m.WorldTiles[x][y];
				if (tile.Type == ::Const.World.TerrainType.Ocean) {
					continue;
				}

				local key = x * 1000 + y;
				if (key in checked) {
					continue;
				}

				local island = [];
				local q = [tile];
				checked[key] <- true;
				local head = 0;

				while (head < q.len()) {
					local currentHead = q[head];
					head++;
					island.push(currentHead);

					for (local i = 0; i < 6; i++) {
						if (currentHead.hasNextTile(i)) {
							local nextTile = currentHead.getNextTile(i);
							if (nextTile.Type != ::Const.World.TerrainType.Ocean) {
								local neighbourKey = nextTile.SquareCoords.X * 1000 + nextTile.SquareCoords.Y;
								if (!(neighbourKey in checked)) {
									checked[neighbourKey] <- true;
									q.push(nextTile);
								}
							}
						}
					}
				}
				//::logDebug("Island size: " + island.len());
				islands.push(island);
			}
		}

		islands.sort(@(a, b) b.len() <=> a.len());
		local mainland = islands[0];

		// find the best place to connect the islands to mainland
		for (local i = 1; i < islands.len(); i = ++i) {
			local island = islands[i];
			if (island.len() >= this.m.BridgeMinIslandSize) {
				local bestDist = 999999;
				local startTile = null;
				local endTile = null;

				for (local k = 0; k < island.len(); k += 5) {
					local islandTile = island[k];
					for (local m = 0; m < mainland.len(); m += 10) {
						local mainlandTile = mainland[m];

						local dist = ::Math.abs(islandTile.SquareCoords.X - mainlandTile.SquareCoords.X) + ::Math.abs(islandTile.SquareCoords.Y - mainlandTile.SquareCoords.Y);
						if (dist < bestDist) {
							bestDist = dist;
							startTile = islandTile;
							endTile = mainlandTile;
						}
					}
				}

				// calculate and paint the tiles on the way
				if (startTile != null && endTile != null) {
					local steps = ::Math.max(1, bestDist * 2);
					local bridgeTiles = [];
					for (local step = 0; step <= steps; step++) {
						local x = ::Math.round(startTile.SquareCoords.X + (endTile.SquareCoords.X - startTile.SquareCoords.X) * (step.tofloat() / steps));
						local y = ::Math.round(startTile.SquareCoords.Y + (endTile.SquareCoords.Y - startTile.SquareCoords.Y) * (step.tofloat() / steps));

						if (x >= _rect.X && x < _rect.X + _rect.W && y >= _rect.Y && y < _rect.Y + _rect.H)	{
							local bridgeTile = this.m.WorldTiles[x][y];
							this.paintBridges(bridgeTile);
							bridgeTiles.push(bridgeTile);

							for (local j = 0; j < 6; j++) {
								if (::Math.rand(1, 100) <= this.m.BridgeWideningChance) {
									if (bridgeTile.hasNextTile(j)) {
										local nextTile = bridgeTile.getNextTile(j);
										this.paintBridges(nextTile);
										bridgeTiles.push(nextTile);
									}
								}
							}
						}
					}
					mainland.extend(island); // it could be better not to do it for the contracts' sake - then the bridges will only be added from the mainland which should be where all towns are
            		mainland.extend(bridgeTiles); 
				}
			}
		}
	}

	o.paintBridges <- function(_tile) {
		if (_tile.Type == ::Const.World.TerrainType.Ocean) {
    		local targetBiome = ::Const.World.TerrainType.Plains;
    
			for (local j = 0; j < 6; j++) {
				if (_tile.hasNextTile(j)) {
					local neighbourType = _tile.getNextTile(j).Type;
					if (neighbourType != ::Const.World.TerrainType.Ocean && neighbourType != ::Const.World.TerrainType.Shore)
						targetBiome = neighbourType;
				}
			}

			_tile.clear();
			_tile.Type = 0; 
		
			local tileRect = {
				X = _tile.SquareCoords.X,
				Y = _tile.SquareCoords.Y,
				W = 1,
				H = 1,
				IsEmpty = true
			};

			this.m.Tiles[targetBiome].fill(tileRect, null);
		}
	}

	local buildElevation = o.buildElevation;
	o.buildElevation = function (_rect) {
		this.removeStraits(_rect);
		this.buildBridges(_rect);
		buildElevation(_rect);
	}
		local _properties = this.World.State.m.CampaignSettings;

		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			s.updateProperties();
			s.build(_properties);
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				foreach( s in settlements )
				{
					local d = s.getTile().getDistanceTo(tile);

					if (d > 6)
					{
						continue;
					}

					tile.HeatFromSettlements = tile.HeatFromSettlements + (6 - d);
				}
			}
		}
	}

	o.addSettlement <- function (_rect, isLeft, settlementList, settlementSize, settlementTiles, additionalSpace, ignoreSide) {
		local tries = 0;

		while (tries++ < 3000) {
			local x = ignoreSide ? ::Math.rand(5, _rect.W - 6) : (isLeft ? ::Math.rand(5, _rect.W * 0.6) : ::Math.rand(_rect.W * 0.4, _rect.W - 6));
			local y = ::Math.rand(5, _rect.H * 0.95);
			local tile = this.World.getTileSquare(x, y);

			if (settlementTiles.find(tile.ID) != null) {
				continue;
			}

			local next = false;
			local distance = 12 + additionalSpace;
			// if (tries > 3000) {
			// 	distance -= 4;
			// }
			// if (tries > 6000) {
			// 	distance -= 8;
			// }

			foreach (settlement in settlementTiles) {
				if (tile.getDistanceTo(settlement) < distance) {
					next = true;
					break;
				}
			}

			if (next) {
				continue;
			}

			local terrain = this.getTerrainInRegion(tile);

			if (terrain.Adjacent[::Const.World.TerrainType.Ocean] >= 3 || terrain.Adjacent[::Const.World.TerrainType.Shore] >= 3) {
				continue;
			}

			local candidates = [];

			foreach (settlement in settlementList) {
				if (settlement.isSuitable(terrain)) {
					candidates.push(settlement);
				}
			}

			if (candidates.len() == 0) {
				continue;
			}

			local type = candidates[::Math.rand(0, candidates.len() - 1)];

			if ((terrain.Region[::Const.World.TerrainType.Ocean] >= 3 || terrain.Region[::Const.World.TerrainType.Shore] >= 3) && !("IsCoastal" in type) && !("IsFlexible" in type)) {
				continue;
			}

			if (!("IsCoastal" in type)) {
				local skip = settlementTiles.len() != 0;
				local navSettings = ::World.getNavigator().createSettings();

				for (local i = settlementTiles.len() - 1; i >= 0; i = --i) {
					navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost;
					local path = ::World.getNavigator().findPath(tile, settlementTiles[i], navSettings, 0);

					if (!path.isEmpty()) {
						skip = false;
						break;
					}
				}

				if (skip) {
					continue;
				}
			} else if (settlementTiles.len() >= 1 && tries < 500) {
				local hasConnection = false;

				for (local i = settlementTiles.len() - 1; i >= 0; i--) {
					local navSettings = ::World.getNavigator().createSettings();
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
					local path = ::World.getNavigator().findPath(tile, settlementTiles[i], navSettings, 0);

					if (!path.isEmpty()) {
						hasConnection = true;
						break;
					}
				}

				if (!hasConnection) {
					continue;
				}
			}

			tile.clear();
			local entity = this.World.spawnLocation(type.Script, tile.Coords);
			entity.setSize(settlementSize);
			settlementTiles.push(tile);
			return settlementTiles;
		}
		return settlementTiles;
	}

	o.buildSettlements = function (_rect) {
		::LoadingScreen.updateProgress("Building Settlements ...");
		::logInfo("Building settlements...");
		local isLeft = ::Math.rand(0, 1);
		local settlementTiles = [];

		local settlementsToCreate = [];
		local weightedFractions = [];
		local fractionSum = 0;
		local settlementsAllocated = 0;

		foreach (list in ::Const.World.Settlements.LegendsWorldMaster) {
			local part = ::Legends.Mod.ModSettings.getSetting("Settlements").getValue() * list.Ratio;
			local number = part.tointeger();
			
			settlementsToCreate.push(number);
			weightedFractions.push(((part - number) * 10000).tointeger());
			settlementsAllocated += number;
			fractionSum += ((part - number) * 10000).tointeger();
		}

		local remainingSettlements = ::Legends.Mod.ModSettings.getSetting("Settlements").getValue() - settlementsAllocated;

		while (remainingSettlements > 0) {
			local pick = ::Math.rand(0, fractionSum);

			for (local i = 0; i < weightedFractions.len(); i++) {
				local score = weightedFractions[i];
				if (score <= 0) {
					continue;
				}

				if (pick <= score) {
					settlementsToCreate[i]++;
					weightedFractions[i] = 0;
					fractionSum -= score;
					remainingSettlements--;
					break;
				}

				pick -= score;
			}
		}

		foreach (i, list in ::Const.World.Settlements.LegendsWorldMaster) {
			local num = settlementsToCreate[i];
			local additionalSpace = 0;

			if ("AdditionalSpace" in list) {
				additionalSpace = list.AdditionalSpace;
			}
			foreach (s in list.Sizes) {
				for (local i = 0; i < s.MinAmount; i++) {
					settlementTiles = this.addSettlement(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list);
					num--;
				}
			}

			while (num > 0) {
				local r = ::Math.rand(1, 10);
				local total = 0;
				foreach (s in list.Sizes) {
					total += s.Ratio;
					if (r > total) {
						continue;
					}
					settlementTiles = this.addSettlement(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list);
					break;
				}
				num--;
			}
		}

		::logInfo("Created " + settlementTiles.len() + " settlements.");
		return settlementTiles.len() >= 19;
	}

	o.guaranteeAllBuildingsInSettlements = function () {

		local settlements = this.World.EntityManager.getSettlements();

		if (this.Const.World.Buildings.Fletchers < 2) {
			local candidates = [];

			foreach (s in settlements) {
				if (s.getSize() >= 2 && s.hasFreeBuildingSlot()	&& !s.hasBuilding("building.fletcher"))	{
					candidates.push(s);
				}
			}

			for (local i = this.Const.World.Buildings.Fletchers; i <= 2; i = ++i) {
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));

				if (candidates.len() == 0) {
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Temples < 2) {
			local candidates = [];

			foreach (s in settlements) {
				if (s.getSize() >= 2 && s.hasFreeBuildingSlot() && !s.hasBuilding("building.temple"))
				{
					candidates.push(s);
				}
			}

			for (local i = this.Const.World.Buildings.Temples; i <= 2; i = ++i) {
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));

				if (candidates.len() == 0) {
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Blackmarket < 2) {
			local candidates = [];

			foreach (s in settlements) {
				if (s.getSize() >= 2 && !s.isMilitary()	&& s.hasFreeBuildingSlot() && !s.hasBuilding("building.blackmarket"))
				{
					candidates.push(s);
				}
			}

			for (local i = this.Const.World.Buildings.Blackmarket; i <= 2; i = ++i) {
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));

				if (candidates.len() == 0) {
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Kennels < 2) {
			local candidates = [];

			foreach (s in settlements) {
				if (s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.kennel"))
				{
					candidates.push(s);
				}
			}

			for (local i = this.Const.World.Buildings.Kennels; i <= 2; i = ++i) {
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));

				if (candidates.len() == 0) {
					break;
				}
			}
		}

		if (this.Const.DLC.Unhold && this.Const.World.Buildings.Taxidermists < 2) {
			local candidates = [];

			foreach (s in settlements) {
				if (!s.isMilitary()	&& s.hasFreeBuildingSlot() && !s.hasBuilding("building.taxidermist"))
				{
					candidates.push(s);
				}
			}

			for (local i = this.Const.World.Buildings.Taxidermists; i <= 2; i = ++i) {
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));

				if (candidates.len() == 0) {
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Stables < 1) {
			local candidates = [];

			foreach (s in settlements) {
				if (s.isMilitary()	&& s.hasFreeBuildingSlot()	&& !s.hasBuilding("building.stables"))
				{
					candidates.push(s);
				}
			}

			for (local i = this.Const.World.Buildings.Stables; i <= 2; i = ++i) {
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));

				if (candidates.len() == 0) {
					break;
				}
			}
		}

	}

	local buildAdditionalRoads = o.buildAdditionalRoads;
	o.buildAdditionalRoads = function (_rect, _properties) {
		if (::Legends.Mod.ModSettings.getSetting("AllTradeLocations").getValue()) {
			this.guaranteeAllLocations();
		}
		buildAdditionalRoads(_rect, _properties);
	}

	o.guaranteeAllLocations <- function () {
		local locs = {}
		locs["attached_location.amber_collector"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/amber_collector_location"
		}
		locs["attached_location.beekeeper"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/beekeeper_location"
		};
		locs["attached_location.brewery"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/brewery_location"
		};
		locs["attached_location.dye_maker"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/dye_maker_location"
		};
		locs["attached_location.fishing_huts"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/fishing_huts_location"
		};
		locs["attached_location.gatherers_hut"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/gatherers_hut_location"
		};
		locs["attached_location.gem_mine"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/gem_mine_location"
		};
		locs["attached_location.goat_herd"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/goat_herd_location"
		};
		locs["attached_location.gold_mine"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/gold_mine_location"
		};
		locs["attached_location.herbalists_grove"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/herbalists_grove_location"
		};
		locs["attached_location.hunters_cabin"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/hunters_cabin_location"
		};
		locs["attached_location.leather_tanner"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/leather_tanner_location"
		};
		locs["attached_location.lumber_camp"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/lumber_camp_location"
		};
		locs["attached_location.mushroom_grove"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/mushroom_grove_location"
		};
		locs["attached_location.orchard"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/orchard_location"
		};
		locs["attached_location.peat_pit"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/peat_pit_location"
		};
		locs["attached_location.pig_farm"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/pig_farm_location"
		};
		locs["attached_location.salt_mine"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/salt_mine_location"
		};
		locs["attached_location.surface_copper_vein"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/surface_copper_vein_location"
		};
		locs["attached_location.surface_iron_vein"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/surface_iron_vein_location"
		};
		locs["attached_location.trapper"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/trapper_location"
		};
		locs["attached_location.wheat_fields"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/wheat_fields_location"
		};
		locs["attached_location.winery"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/winery_location"
		};
		locs["attached_location.wool_spinner"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/wool_spinner_location"
		};
		locs["attached_location.workshop"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/workshop_location"
		};

		local settlements = this.World.EntityManager.getSettlements();
		foreach (s in settlements) {
			foreach (a in s.getAttachedLocations()) {
				if (a.getTypeID() in locs) {
					locs[a.getTypeID()].Amount += 1;
				}
			}
		}

		foreach (k, v in locs) {

			if (v.Amount > 0) {
				continue;
			}

			local ALL = [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			];
			local tries = 0;
			while (tries++ < 1000) {
				local index = this.Math.rand(0, settlements.len() - 1);
				settlements[index].buildAttachedLocation(1, v.Script, ALL, [], 2, false, true, true);
				if (settlements[index].hasAttachedLocation(k)) {
					//this.logInfo("Added " + k)
					break;
				}
				tries = --tries;
			}
		}
	}
});
