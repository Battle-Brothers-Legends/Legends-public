::mods_hookExactClass("mapgen/templates/tactical/tiles/desert1", function(o)
{
	o.init = function ()
	{
		this.m.Name = "tactical.tile.desert1";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setSocket("socket_desert");
		::Tactical.setTransitions("tile_desert_01", t);
		::Tactical.setTransitions("tile_legend_desert_01", t);
		::Tactical.setTransitions("tile_legend_desert_02", t);
		::Tactical.setTransitions("tile_legend_desert_03", t);
		::Tactical.setTransitions("tile_legend_desert_04", t);
	}

	o.onFirstPass = function ( _rect )
	{
		local tile = ::Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = ::Const.Tactical.TerrainType.Sand;
		tile.Subtype = ::Const.Tactical.TerrainSubtype.Desert;
		tile.BlendPriority = ::Const.Tactical.TileBlendPriority.Desert1;
		tile.IsBadTerrain = false;

		 local random = ::Math.rand(1, 100);

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

		if (::Math.rand(0, 100) < this.m.ChanceToSpawnObject)
		{
			if (!tile.hasNextTile(::Const.Direction.S) || tile.getNextTile(::Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[::Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (::Math.rand(0, 100) < this.m.ChanceToSpawnDetails)
		{
			tile.spawnDetail(this.m.Details[::Math.rand(0, this.m.Details.len() - 1)]);
		}
	}
});
