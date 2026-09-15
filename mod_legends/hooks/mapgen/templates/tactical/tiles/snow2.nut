::mods_hookExactClass("mapgen/templates/tactical/tiles/snow2", function(o)
{
	o.init = function ()
	{
		this.m.Name = "tactical.tile.snow2";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setBlendIntoSockets(false);
		t.setBrush(::Const.Direction.N, "transition_snow_02_N");
		t.setBrush(::Const.Direction.NE, "transition_snow_02_NE");
		t.setBrush(::Const.Direction.SE, "transition_snow_02_SE");
		t.setBrush(::Const.Direction.S, "transition_snow_02_S");
		t.setBrush(::Const.Direction.SW, "transition_snow_02_SW");
		t.setBrush(::Const.Direction.NW, "transition_snow_02_NW");
		t.setSocket("socket_snow");
		::Tactical.setTransitions("tile_snow_02", t);
		::Tactical.setTransitions("tile_legend_snow_09", t);
		::Tactical.setTransitions("tile_legend_snow_10", t);
		::Tactical.setTransitions("tile_legend_snow_11", t);
		::Tactical.setTransitions("tile_legend_snow_12", t);
		::Tactical.setTransitions("tile_legend_snow_13", t);
	}

	o.onFirstPass = function ( _rect, _objectSpawnChanceMult = 1.0 )
	{
		local tile = ::Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		local isSpawningObjects = !("SpawnObjects" in _rect) || _rect.SpawnObjects;
		tile.Type = ::Const.Tactical.TerrainType.RoughGround;
		tile.Subtype = ::Const.Tactical.TerrainSubtype.Snow;
		tile.BlendPriority = ::Const.Tactical.TileBlendPriority.Snow2;
		tile.IsBadTerrain = false;


		 local random = ::Math.rand(1, 100);
		if (random <= 20)
		{
		tile.setBrush("tile_snow_02");
		}
		else if (random >= 21 && random <=30)
		{
		tile.setBrush("tile_legend_snow_09");
		}
		else if (random >= 31 && random <=40)
		{
		tile.setBrush("tile_legend_snow_10");
		}
		else if (random >= 41 && random <=60)
		{
		tile.setBrush("tile_legend_snow_11");
		}
		else if (random >= 61 && random <=80)
		{
		tile.setBrush("tile_legend_snow_12");
		}
		else
		{
		tile.setBrush("tile_legend_snow_13");
		}

		local n = 0;

		if (isSpawningObjects && ::Math.rand(0, 100) < this.m.ChanceToSpawnObject * _objectSpawnChanceMult)
		{
			if (_objectSpawnChanceMult != 1.0 || !tile.hasNextTile(::Const.Direction.S) || tile.getNextTile(::Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[::Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (::Math.rand(1, 100) <= this.m.ChanceToSpawnDetails)
		{
			if (::Math.rand(1, 100) <= 90)
			{
				tile.spawnDetail(this.m.DetailsSnow[::Math.rand(0, this.m.DetailsSnow.len() - 1)]);
			}
			else
			{
				tile.spawnDetail(this.m.Details[::Math.rand(0, this.m.Details.len() - 1)]);
			}
		}
	}
});
