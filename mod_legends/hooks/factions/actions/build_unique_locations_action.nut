::mods_hookExactClass("factions/actions/build_unique_locations_action", function(o)
{
	o.m.BuildMummySite <- true;
	o.m.BuildTournamentSite <- true;

	local updateBuildings = o.updateBuildings;
	o.updateBuildings = function( )
	{
		updateBuildings();

		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.legend_mummy")
				this.m.BuildMummySite = false;

			if (v.getTypeID() == "location.legend_tournament")
				this.m.BuildTournamentSite = false;
		}
	}

	local onExecute = o.onExecute;
	o.onExecute = function( _faction )
	{
		onExecute(_faction);

		local camp;
		local distanceToOthers = 15;

		if (this.m.BuildMummySite)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = i )
			{
				if (i == this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 8, 25, 1001, 8, 8, null, 0.1);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/legend_mummy_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
				this.logInfo("Built Legends Ancient Mastaba location")
			}
		}
		if (this.m.BuildTournamentSite)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = i )
			{
				if (i == this.Const.World.TerrainType.Hills || i == this.Const.World.TerrainType.Mountains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
				i = ++i;
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 30, 1000, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/legend_tournament_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
				this.logInfo("Built Legends Tournament location")
			}
		}
	}
});
