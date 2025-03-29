this.patch_swamp_forest <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.patch.swamp_forest";
		this.m.MinX = 10;
		this.m.MinY = 10;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local tile1 = this.MapGen.get("tactical.tile.swampforest3");
		local tile2 = this.MapGen.get("tactical.tile.swampforest2");
		local tile3 = this.MapGen.get("tactical.tile.swampforest1");

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
					if (this.Math.abs(x - _rect.X) <= 2 || this.Math.abs(x - (_rect.X + _rect.W - 1)) <= 2 || this.Math.abs(y - _rect.Y) <= 2 || this.Math.abs(y - (_rect.Y + _rect.H - 1)) <= 2)
					{
						if (this.Math.rand(0, 100) < 33)
						{
						}
					}

					tile.Level = 0;
					local r = this.Math.rand(0, 100);

					if (r <= 50)
					{
						tile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties, 1);
					}
					else if (r <= 75)
					{
						tile2.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties, 1);
					}
					else
					{
						tile3.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties, 1);
					}
				}
			}
		}
	}

});

