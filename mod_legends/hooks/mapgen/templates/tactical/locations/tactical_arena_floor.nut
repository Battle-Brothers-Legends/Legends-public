::mods_hookExactClass("mapgen/templates/tactical/locations/tactical_arena_floor", function(o)
{
	o.fill = function ( _rect, _properties, _pass = 1 )
	{
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				if (x > _rect.X + 1 && x < _rect.X + _rect.W - 2 && y > _rect.Y + 1 && y < _rect.Y + _rect.H - 2)
				{
					if (this.Math.rand(1, 100) <= 3)
					{
						local tile = this.Tactical.getTileSquare(x, y);
						tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
					}
				}
				else if (this.Math.rand(1, 100) <= 66)
				{
					local tile = this.Tactical.getTileSquare(x, y);
					local o = tile.spawnObject("entity/tactical/objects/arena_spectator");

					if (o == null)
					{
						continue;
					}
					if (tile.Coords.X > (_rect.X + _rect.W) / 2)
					{
						o.setFlipped(true);
					}
				}
			}
		}
	}
});
