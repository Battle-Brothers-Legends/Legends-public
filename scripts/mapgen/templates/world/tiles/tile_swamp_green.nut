this.tile_swamp_green <- this.inherit("scripts/mapgen/map_template", {
	m = {
		DetailsGreen = [
			"world_detail_swamp_green_01",
			"world_detail_swamp_green_02",
			"world_detail_swamp_green_03",
			"world_detail_swamp_green_04",
			"world_detail_swamp_green_05",
			"world_detail_swamp_green_06"
		]	
	},
	function init()
	{
		this.m.Name = "world.tile.swamp_green";
		this.m.MinX = 1;
		this.m.MinY = 1;
	}

	function onFirstPass( _rect )
	{
		local tile = ::World.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = ::Const.World.TerrainType.Swamp;
		tile.TacticalType = ::Const.World.TerrainTacticalType.SwampGreen;
		tile.setBrush("world_swamp_0" + ::Math.rand(1, 4));
	
	}

	function onSecondPass( _rect )
	{
		local tile = ::World.getTileSquare(_rect.X, _rect.Y);
		local swamp = tile.getSurroundingTilesOfType(::Const.World.TerrainType.Swamp);
		tile.spawnDetail(this.m.DetailsGreen[::Math.rand(0, this.m.DetailsGreen.len() - 1)], ::Const.World.ZLevel.Object, ::Const.World.DetailType.Swamp | ::Const.World.DetailType.NotCompatibleWithRoad);



		if (swamp >= 1)
		{
			local fog = tile.spawnDetail("world_swamp_fog_0" + ::Math.rand(1, 4), ::Const.World.ZLevel.Object + 300, 0);
			fog.Alpha = ::Math.min(255, swamp * 40);

			if (swamp >= 3)
			{
				fog = tile.spawnDetail("world_swamp_fog_0" + ::Math.rand(5, 6), ::Const.World.ZLevel.Object + 305, 0);
				fog.Alpha = ::Math.min(255, swamp * 25);
				fog.Torque = ::Math.rand(0, 30) - 15;
			}
		}
	}

	function onRoadPass( _rect )
	{
		local tile = ::World.getTileSquare(_rect.X, _rect.Y);

		if (tile.IsOccupied)
		{
			return;
		}

		if (tile.HasRoad)
		{
			tile.clearAllBut(::Const.World.DetailType.Road | ::Const.World.DetailType.Houses);
			tile.spawnDetail("world_detail_swamp_road_01", ::Const.World.ZLevel.Object, 0);
			local fog = tile.spawnDetail("world_swamp_fog_0" + ::Math.rand(1, 4), ::Const.World.ZLevel.Object + 5, 0);
			fog.Alpha = 150;
		}
	}

});

