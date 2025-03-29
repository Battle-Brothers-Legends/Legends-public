::mods_hookExactClass("mapgen/templates/world/tiles/tile_forest_leaves", function(o)
{
	o.onSecondPass = function ( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local urban = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Urban);
		local swamp = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp);
		local forest = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Forest);
		local autumn = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest);
		if (urban != 0)
		{
			tile.spawnDetail("world_detail_forest_leaves_cut_0" + this.Math.rand(1, 2), this.Const.World.ZLevel.Object, 0);
		}
		else if (forest > 1)
		{
			tile.spawnDetail("world_detail_forest_green_0" + this.Math.rand(4, 6), this.Const.World.ZLevel.Object, 0);
		}
		else if (autumn > 1)
		{
			tile.spawnDetail("world_detail_autumn_leaves_0" + this.Math.rand(1, 2), this.Const.World.ZLevel.Object, 0);
		}
		else if (swamp > 1)
		{
			tile.spawnDetail("world_detail_swamp_green_leaves_0" + this.Math.rand(1, 4), this.Const.World.ZLevel.Object, 0);
		}
		else
		{
			tile.spawnDetail("world_detail_forest_leaves_0" + this.Math.rand(2, 4), this.Const.World.ZLevel.Object, 0);
		}
	}
});
