this.patch_legend_cave<- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.patch.legend_cave";
		this.m.MinX = 10;
		this.m.MinY = 10;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local cave1Tile = this.MapGen.get("tactical.tile.legend_cave1");
		local cave2Tile = this.MapGen.get("tactical.tile.stone2");
		local bumpyChance = 98;
		local mainTile = ::Math.rand(1, 100) < 50 ? cave1Tile : cave2Tile;
		local otherTile = mainTile == cave2Tile ? cave1Tile : cave2Tile;
		local otherTileChance = 10;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);

				if (tile.Type != 0)
				{
				}
				else
				{
					if (::Math.abs(x - _rect.X) <= 2 || ::Math.abs(x - (_rect.X + _rect.W - 1)) <= 2 || ::Math.abs(y - _rect.Y) <= 2 || ::Math.abs(y - (_rect.Y + _rect.H - 1)) <= 2)
					{
						if (::Math.rand(0, 100) < 33)
						{
						}
					}

					local n = 0;

					if (::Tactical.isValidTileSquare(x - 1, y) && ::Tactical.getTileSquare(x - 1, y).Level == 1)
					{
						n = ++n;
					}

					if (::Tactical.isValidTileSquare(x - 1, y + 1) && ::Tactical.getTileSquare(x - 1, y + 1).Level == 1)
					{
						n = ++n;
					}

					if (::Tactical.isValidTileSquare(x, y - 1) && ::Tactical.getTileSquare(x, y - 1).Level == 1)
					{
						n = ++n;
					}

					tile.Level = 0;

					if (::Math.rand(0, 100) > bumpyChance - n * 20)
					{
						tile.Level = 1;
					}

					local brush = ::Math.rand(0, 100) < otherTileChance ? otherTile : mainTile;
					brush.fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = _rect.IsEmpty || ::Math.rand(0, 100) < 33
					}, _properties);
				}
			}
		}
	}

});

