::mods_hookExactClass("mapgen/templates/world/tiles/tile_swamp", function(o)
{
	o.m.DetailsGreen <- [
		"world_detail_swamp_green_01",
		"world_detail_swamp_green_02",
		"world_detail_swamp_green_03",
		"world_detail_swamp_green_04",
		"world_detail_swamp_green_05",
		"world_detail_swamp_green_06"
	];

	o.onSecondPass = function ( _rect )
	{
		local tile = ::World.getTileSquare(_rect.X, _rect.Y);
		local swamp = tile.getSurroundingTilesOfType(::Const.World.TerrainType.Swamp);

		if (::Math.rand(0, 100) < 90)
		{
			tile.spawnDetail(this.m.Details[::Math.rand(0, this.m.Details.len() - 1)], ::Const.World.ZLevel.Object, ::Const.World.DetailType.Swamp | ::Const.World.DetailType.NotCompatibleWithRoad);
		}
		else
		{
			tile.spawnDetail(this.m.DetailsGreen[::Math.rand(0, this.m.DetailsGreen.len() - 1)], ::Const.World.ZLevel.Object, ::Const.World.DetailType.Swamp | ::Const.World.DetailType.NotCompatibleWithRoad);
			tile.TacticalType = ::Const.World.TerrainTacticalType.SwampGreen;
		}


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
});
