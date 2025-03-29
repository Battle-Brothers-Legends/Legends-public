::mods_hookExactClass("mapgen/templates/tactical/tiles/desert2", function(o)
{
	o.init = function ()
	{
		this.m.Name = "tactical.tile.desert2";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setSocket("socket_desert");
		this.Tactical.setTransitions("tile_desert_02", t);
		this.Tactical.setTransitions("tile_legend_desert_05", t);
		this.Tactical.setTransitions("tile_legend_desert_06", t);
		this.Tactical.setTransitions("tile_legend_desert_07", t);
		this.Tactical.setTransitions("tile_legend_desert_08", t);
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
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Desert2;
		tile.IsBadTerrain = false;
		 local random = this.Math.rand(1, 100);
		if (random <= 20)
		{
		tile.setBrush("tile_desert_02");
		}
		else if (random >= 21 && random <=40)
		{
		tile.setBrush("tile_legend_desert_05");
		}
		else if (random >= 41 && random <=60)
		{
		tile.setBrush("tile_legend_desert_06");
		}
		else if (random >= 61 && random <=80)
		{
		tile.setBrush("tile_legend_desert_07");
		}
		else
		{
		tile.setBrush("tile_legend_desert_08");
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
