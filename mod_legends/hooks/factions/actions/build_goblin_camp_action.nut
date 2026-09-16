::mods_hookExactClass("factions/actions/build_goblin_camp_action", function(o) 
{
	o.onExecute = function ( _faction )
	{
		local camp;
		local r;
		local minY = ::Const.DLC.Desert ? 0.2 : 0.0;

		if (_faction.getSettlements().len() == 0)
		{
			r = 6;
		}
		else if (::World.FactionManager.isGreenskinInvasion())
		{
			r = ::Math.rand(0, 3);
		}
		else
		{
			r = ::Math.rand(1, 5);
		}

		if (r == 0 || r == 1)
		{
			local tile;

			if (::World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 8, 20, 20, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 15, 1000, 20, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = ::World.spawnLocation("scripts/entity/world/locations/goblin_camp_location", tile.Coords);
			}
		}
		else if (r == 2)
		{
			local tile;

			if (::World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 12, 30, 20, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 20, 1000, 20, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = ::World.spawnLocation("scripts/entity/world/locations/goblin_outpost_location", tile.Coords);
			}
		}
		else if (r == 3)
		{
			local tile;

			if (::World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 8, 18, 20, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 14, 30, 20, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = ::World.spawnLocation("scripts/entity/world/locations/goblin_ruins_location", tile.Coords);
			}
		}
		else if (r == 4)
		{
			local tile;

			if (::World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 6, 14, 30, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
					::Const.World.TerrainType.Mountains
				], 10, 20, 30, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = ::World.spawnLocation("scripts/entity/world/locations/goblin_hideout_location", tile.Coords);
			}
		}
		else if (r == 5 || r == 6)
		{
			local disallowedTerrain = [];

			for( local i = 0; i != ::Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == ::Const.World.TerrainType.Mountains || i == ::Const.World.TerrainType.Hills || i == ::Const.World.TerrainType.SwampGreen)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile;

			if (::World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(r == 6 ? 1000 : ::Const.Factions.BuildCampTries, disallowedTerrain, 20, 40, 20, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(r == 6 ? 1000 : ::Const.Factions.BuildCampTries, disallowedTerrain, 25, 1000, 20, minY);
			}

			if (tile != null && _faction.getSettlements().len() == 0)
			{
				local orcs = ::World.FactionManager.getFactionOfType(::Const.FactionType.Orcs).getSettlements();

				foreach( s in orcs )
				{
					if (s.getTile().getDistanceTo(tile) <= 25)
					{
						return;
					}
				}
			}

			if (tile != null)
			{
				camp = ::World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", tile.Coords);
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, ::Const.GoblinBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}
	}
});