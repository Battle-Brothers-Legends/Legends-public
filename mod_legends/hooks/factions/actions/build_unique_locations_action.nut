::mods_hookExactClass("factions/actions/build_unique_locations_action", function (o) {
	o.m.BuildLegendMummyPyramid <- true;
	o.m.BuildLegendGrandTournament <- false;

	o.updateBuildings = function () {
		foreach (loc in ::World.EntityManager.getLocations()) {
			foreach (key in ::Legends.World.LegendaryLocations.Order) {
				if (loc.getTypeID() == ::Legends.World.LegendaryLocations[key].ID) {
					this.m["Build" + key] = false;
				}
			}
		}
	}

	o.onExecute = function (_faction, _retries = 5) {
		local missingLocations = [];
		foreach (key in ::Legends.World.LegendaryLocations.Order) {
			local location = ::Legends.World.LegendaryLocations[key];
			local camp = null;
			if (this.m["Build" + key]) {
				local disallowedTerrain = [];
				if ("AllowedTerrainTypes" in location) {
					for (local i = 0; i < ::Const.World.TerrainType.COUNT; i++) {
						if (location.AllowedTerrainTypes.find(i) == null) {
							disallowedTerrain.push(i);
						}
					}
				} else if ("DisallowedTerrainTypes" in location) {
					disallowedTerrain = location.DisallowedTerrainTypes;
				}
				local retryModifier = _retries - 5;
				local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries * 1000, disallowedTerrain, ("MinDistToSettlements" in location ? location.MinDistToSettlements : 7) + retryModifier, "MaxDistToSettlements" in location ? location.MaxDistToSettlements : 1000, "MaxDistToAllies" in location ? location.MaxDistToAllies : 1001, ("MinDistToEnemyLocations" in location ? location.MinDistToEnemyLocations : 15) + retryModifier, ("MinDistToAlliedLocations" in location ? location.MinDistToAlliedLocations : 15) + retryModifier, null, "MinY" in location ? location.MinY : 0.0, "MaxY" in location ? location.MaxY : 1.0);
				if (tile != null) {
					camp = ::World.spawnLocation(location.Script, tile.Coords);
				}
				if (camp != null) {
					camp.onSpawned();
					if ("OnSpawned" in location) {
						location.OnSpawned(this, camp, tile);
					}
				} else {
					missingLocations.push(key);
				}
			}
		}

		if (missingLocations.len() == 0) {
			this.m.CooldownUntil = 1000000000.0;
			this.m.IsRunOnNewCampaign = false;
			return;
		} else {
			if (_retries > 0) {
				::logDebug("Unable to place: " + missingLocations.reduce(@(_a, _b) _a + ", " + _b) + ", retrying...");
				this.updateBuildings();
				this.onExecute(_faction, _retries - 1);
			}
		}
	}
});