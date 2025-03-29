::mods_hookExactClass("mapgen/templates/tactical/tiles/snow2", function(o)
{
	o.init = function ()
	{
		this.m.Name = "tactical.tile.snow2";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setBlendIntoSockets(false);
		t.setBrush(this.Const.Direction.N, "transition_snow_02_N");
		t.setBrush(this.Const.Direction.NE, "transition_snow_02_NE");
		t.setBrush(this.Const.Direction.SE, "transition_snow_02_SE");
		t.setBrush(this.Const.Direction.S, "transition_snow_02_S");
		t.setBrush(this.Const.Direction.SW, "transition_snow_02_SW");
		t.setBrush(this.Const.Direction.NW, "transition_snow_02_NW");
		t.setSocket("socket_snow");
		this.Tactical.setTransitions("tile_snow_02", t);
		this.Tactical.setTransitions("tile_legend_snow_09", t);
		this.Tactical.setTransitions("tile_legend_snow_10", t);
		this.Tactical.setTransitions("tile_legend_snow_11", t);
		this.Tactical.setTransitions("tile_legend_snow_12", t);
		this.Tactical.setTransitions("tile_legend_snow_13", t);
	}

	o.onFirstPass = function ( _rect, _objectSpawnChanceMult = 1.0 )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		local isSpawningObjects = !("SpawnObjects" in _rect) || _rect.SpawnObjects;
		tile.Type = this.Const.Tactical.TerrainType.RoughGround;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.Snow;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Snow2;
		tile.IsBadTerrain = false;


		 local random = this.Math.rand(1, 100);
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

		if (isSpawningObjects && this.Math.rand(0, 100) < this.m.ChanceToSpawnObject * _objectSpawnChanceMult)
		{
			if (_objectSpawnChanceMult != 1.0 || !tile.hasNextTile(this.Const.Direction.S) || tile.getNextTile(this.Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (this.Math.rand(1, 100) <= this.m.ChanceToSpawnDetails)
		{
			if (this.Math.rand(1, 100) <= 90)
			{
				tile.spawnDetail(this.m.DetailsSnow[this.Math.rand(0, this.m.DetailsSnow.len() - 1)]);
			}
			else
			{
				tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
			}
		}
	}
});
