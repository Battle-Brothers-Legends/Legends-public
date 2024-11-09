::mods_hookNewObjectOnce("mapgen/templates/tactical/tiles/desert1", function(o)
{
	local init = o.init;
	o.init = function ()
	{
		init();
		local t = this.createTileTransition();
		this.Tactical.setTransitions("tile_legend_desert_01", t);
		this.Tactical.setTransitions("tile_legend_desert_02", t);
		this.Tactical.setTransitions("tile_legend_desert_03", t);
		this.Tactical.setTransitions("tile_legend_desert_04", t);
	}

	o.onFirstPass = function ( _rect )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = this.Const.Tactical.TerrainType.Sand;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.Desert;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Desert1;
		tile.IsBadTerrain = false;
		
		 local random = this.Math.rand(1, 100);
		 
		if (random <= 20)
		{
		tile.setBrush("tile_desert_01");
		}
		else if (random >= 21 && random <=40)
		{
		tile.setBrush("tile_legend_desert_01");
		}
		else if (random >= 41 && random <=60)
		{
		tile.setBrush("tile_legend_desert_02");
		}		
		else if (random >= 61 && random <=80)
		{
		tile.setBrush("tile_legend_desert_03");
		}
		else 
		{
		tile.setBrush("tile_legend_desert_04");
		}
		
		
		if (_rect.IsEmpty)
		{
			return;
		}

		if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
		{
			if (!tile.hasNextTile(this.Const.Direction.S) || tile.getNextTile(this.Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails)
		{
			tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
		}
	}
});
