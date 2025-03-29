this.patch_swamp_green_pond <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.patch.swamp_green_pond";
		this.m.MinX = 10;
		this.m.MinY = 10;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local pondTile = this.MapGen.get("tactical.tile.swampgreen4");
		local mixedTile = this.MapGen.get("tactical.tile.swampgreen5");

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.Type != 0)
				{
				}
				else
				{
					local isTreeAllowed = true;

					if (this.Math.abs(x - _rect.X) <= 0 || this.Math.abs(x - (_rect.X + _rect.W - 1)) <= 0 || this.Math.abs(y - _rect.Y) <= 0 || this.Math.abs(y - (_rect.Y + _rect.H - 1)) <= 0)
					{
						if (this.Math.rand(1, 100) < 33)
						{
						}
					}

					tile.Level = 0;

					if (this.Math.rand(1, 100) <= 90)
					{
						pondTile.onFirstPass({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false,
							IsTreeAllowed = false,
							IsSmallTree = false
						});
					}
					else
					{
						mixedTile.onFirstPass({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false,
							IsTreeAllowed = false,
							IsSmallTree = false
						});
					}
				}
			}
		}
	}

});

