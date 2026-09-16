::mods_hookExactClass("mapgen/templates/tactical/tiles/desert7", function(o)
{
	o.init = function ()
	{
		this.m.Name = "tactical.tile.desert7";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setBlendIntoSockets(false);
		t.setBrush(::Const.Direction.N, "transition_desert_07_N");
		t.setBrush(::Const.Direction.NE, "transition_desert_07_NE");
		t.setBrush(::Const.Direction.SE, "transition_desert_07_SE");
		t.setBrush(::Const.Direction.S, "transition_desert_07_S");
		t.setBrush(::Const.Direction.SW, "transition_desert_07_SW");
		t.setBrush(::Const.Direction.NW, "transition_desert_07_NW");
		t.setSocket("socket_desert");
		::Tactical.setTransitions("tile_legend_desert_09", t);
		::Tactical.setTransitions("tile_legend_desert_10", t);
		::Tactical.setTransitions("tile_legend_desert_11", t);
		::Tactical.setTransitions("tile_legend_desert_12", t);
		::Tactical.setTransitions("tile_legend_desert_13", t);
		::Tactical.setTransitions("tile_legend_desert_14", t);
		::Tactical.setTransitions("tile_legend_desert_15", t);
		::Tactical.setTransitions("tile_legend_desert_16", t);
		::Tactical.setTransitions("tile_legend_desert_17", t);
		::Tactical.setTransitions("tile_legend_desert_18", t);
		::Tactical.setTransitions("tile_legend_desert_19", t);
		::Tactical.setTransitions("tile_legend_desert_20", t);
		::Tactical.setTransitions("tile_legend_desert_21", t);
		::Tactical.setTransitions("tile_legend_desert_22", t);
		::Tactical.setTransitions("tile_legend_desert_23", t);
		::Tactical.setTransitions("tile_legend_desert_24", t);
		::Tactical.setTransitions("tile_legend_desert_25", t);
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
		tile.BlendPriority = ::Const.Tactical.TileBlendPriority.Desert7;
		tile.IsBadTerrain = false;

		local random = ::Math.rand(1, 100);
		if (random <= 10)
		{
		tile.setBrush("tile_desert_07");
		}
		else if (random >= 11 && random <=15)
		{
		tile.setBrush("tile_legend_desert_09");
		}
		else if (random >= 16 && random <=20)
		{
		tile.setBrush("tile_legend_desert_10");
		}
		else if (random >= 21 && random <= 25)
		{
		tile.setBrush("tile_legend_desert_11");
		}
		else if (random >= 26 && random <=30)
		{
		tile.setBrush("tile_legend_desert_12");
		}
		else if (random >= 31 && random <=35)
		{
		tile.setBrush("tile_legend_desert_13");
		}
		else if (random >= 36 && random <=40)
		{
		tile.setBrush("tile_legend_desert_14");
		}
		else if (random >= 41 && random <=45)
		{
		tile.setBrush("tile_legend_desert_15");
		}
		else if (random >= 46 && random <=50)
		{
		tile.setBrush("tile_legend_desert_16");
		}
		else if (random >= 51 && random <=60)
		{
		tile.setBrush("tile_legend_desert_17");
		}
		else if (random >= 61 && random <=65)
		{
		tile.setBrush("tile_legend_desert_18");
		}
		else if (random >= 66 && random <=70)
		{
		tile.setBrush("tile_legend_desert_19");
		}
		else if (random >= 71 && random <=75)
		{
		tile.setBrush("tile_legend_desert_20");
		}
		else if (random >= 76 && random <=80)
		{
		tile.setBrush("tile_legend_desert_21");
		}
		else if (random >= 81 && random <= 85)
		{
		tile.setBrush("tile_legend_desert_22");
		}
		else if (random >= 86 && random <= 90)
		{
		tile.setBrush("tile_legend_desert_23");
		}
		else if (random >= 91 && random <= 95)
		{
		tile.setBrush("tile_legend_desert_24");
		}
		else
		{
		tile.setBrush("tile_legend_desert_25");
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
