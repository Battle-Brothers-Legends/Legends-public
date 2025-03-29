::mods_hookExactClass("mapgen/templates/world/tiles/tile_autumn_forest", function(o)
{
	o.onSecondPass = function ( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local forest = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Forest);
		local leaves = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.LeaveForest);

		if (forest > 1)
		{
			tile.spawnDetail("world_detail_green_autumn_0" + this.Math.rand(1, 6), this.Const.World.ZLevel.Object, 0);
		}
		else if (leaves > 1)
		{
			tile.spawnDetail("world_detail_autumn_leaves_0" + this.Math.rand(3, 5), this.Const.World.ZLevel.Object, 0);
		}
		else
		{
			local random = this.Math.rand(1, 13);
			if (random <=9)
			{
				local d = tile.spawnDetail("world_detail_autumn_0" + this.Math.rand(1, 9), this.Const.World.ZLevel.Object, 0);
			}
			else
			{
				local d = tile.spawnDetail("world_detail_autumn_1" + this.Math.rand(0, 3), this.Const.World.ZLevel.Object, 0);
			}
		}
	}

	o.onRoadPass = function ( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local forest_autumn = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest);
		
		if (tile.IsOccupied)
		{
			return;
		}

		if (tile.HasRoad || forest_autumn <= 2)
		{
			tile.clearAllBut(this.Const.World.DetailType.Road);
			local d = tile.spawnDetail("world_detail_autumn_0" + this.Math.rand(1, 3), this.Const.World.ZLevel.Object, 0);
		}
		else if (forest_autumn >= 5 && this.Math.rand(1, 100) <= 75)
		{
			tile.clear();
			local d = tile.spawnDetail("world_detail_autumn_0" + this.Math.rand(4, 6), this.Const.World.ZLevel.Object, 0);
		}
	}
});
