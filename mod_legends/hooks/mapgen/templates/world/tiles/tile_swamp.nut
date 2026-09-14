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
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local swamp = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp);

		if (this.Math.rand(0, 100) < 90)
		{
			tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)], this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp | this.Const.World.DetailType.NotCompatibleWithRoad);
		}
		else
		{
			tile.spawnDetail(this.m.DetailsGreen[this.Math.rand(0, this.m.DetailsGreen.len() - 1)], this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp | this.Const.World.DetailType.NotCompatibleWithRoad);
			tile.TacticalType = this.Const.World.TerrainTacticalType.SwampGreen;
		}


		if (swamp >= 1)
		{
			local fog = tile.spawnDetail("world_swamp_fog_0" + this.Math.rand(1, 4), this.Const.World.ZLevel.Object + 300, 0);
			fog.Alpha = this.Math.min(255, swamp * 40);

			if (swamp >= 3)
			{
				fog = tile.spawnDetail("world_swamp_fog_0" + this.Math.rand(5, 6), this.Const.World.ZLevel.Object + 305, 0);
				fog.Alpha = this.Math.min(255, swamp * 25);
				fog.Torque = this.Math.rand(0, 30) - 15;
			}
		}
	}
});
