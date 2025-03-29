::mods_hookExactClass("mapgen/templates/world/tiles/tile_farmland", function(o)
{
	o.onSecondPass = function ( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local heath = 0;
		local highlands = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = tile.getNextTile(i);
				local type = nextTile.Type;

				if (type == this.Const.World.TerrainType.Heath)
				{
					heath = ++heath;
				}
				else if (type == this.Const.World.TerrainType.Tundra)
				{
					highlands = ++highlands;
				}
			}
		}

		if (heath >= 3)
		{
			tile.setBrush("world_heath_01");
		}
		else if (highlands >= 3)
		{
			local r = this.Math.rand(1, 3);			
			if (r = 1)
			{
				tile.setBrush("world_highlands_01");
			}
			if (r = 2)
			{
				tile.setBrush("world_highlands_02");
			}
			if (r = 3)
			{
				tile.setBrush("world_highlands_03");
			}
		}
		else
		{
			local r = this.Math.rand(1, 10);
			if (r <= 2)
			{
				tile.setBrush("world_plains_01");
			}
			else if (r = 3)
			{
				tile.setBrush("world_plains_02");
			}
			else if (r = 4)
			{
				tile.setBrush("world_plains_03");
			}	
			else if (r = 5)
			{
				tile.setBrush("world_plains_04");
			}
			else if (r = 6)
			{
				tile.setBrush("world_plains_05");
			}	
			else if (r = 7)
			{
				tile.setBrush("world_plains_06");
			}
			else if (r = 8)
			{
				tile.setBrush("world_plains_07");
			}	
			else if (r = 9)			
			{
				tile.setBrush("world_plains_08");
			}	
			else if (r = 10)			
			{
				tile.setBrush("world_plains_09");
			}				
		}

		local flip = this.Math.rand(0, 1) == 1 ? true : false;
		local d = tile.spawnDetail("world_detail_fields", this.Const.World.ZLevel.Terrain, 0, flip);
		local n = this.Math.rand(2, 3);

		for( local i = 1; i <= n; i = ++i )
		{
			if (this.Math.rand(0, 1) == 0)
			{
				tile.spawnDetail("world_detail_fields_wheat_0" + i, this.Const.World.ZLevel.Terrain, 0, flip);
			}
			else
			{
				tile.spawnDetail("world_detail_fields_cabbage_0" + i, this.Const.World.ZLevel.Terrain, 0, flip);
			}
		}
	}
});
