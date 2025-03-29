this.tactical_hill_camp <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.hill_camp";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local grassTile = this.MapGen.get("tactical.tile.grass1");
		local earthTile = this.MapGen.get("tactical.tile.earth1");
		local roadTile = this.MapGen.get("tactical.tile.road");
		local hill = this.MapGen.get("tactical.clear_hill");
		local patches = 1;

		while (patches != 0)
		{
			patches = --patches;
			local rect = {
				X = 12,
				Y = 12,
				W = 7,
				H = 8,
				IsEmpty = false
			};
			hill.fill(rect, _properties);
		}

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
					tile.Level = 0;

					if (this.Math.rand(0, 100) > 94)
					{
						tile.Level = 1;
					}

					local rect = {
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = x >= 9 && x <= 21 && y >= 9 && y <= 20 ? true : false
					};

					if (this.Math.rand(0, 100) < 25)
					{
						earthTile.fill(rect, _properties);
					}
					else
					{
						grassTile.fill(rect, _properties);
					}
				}
			}
		}
		local centerTile = this.Tactical.getTileSquare(_rect.W / 2 + 6, _rect.H / 2);
		local minDist = 0;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);
				local d = centerTile.getDistanceTo(tile);

				if (d < minDist || d > 7)
				{
				}
				else if (d == 7)
				{
					if (this.Math.rand(1, 100) < 80)
					{
						tile.removeObject();
						local o = tile.spawnObject("entity/tactical/objects/human_camp_wall");
						o.setDirBasedOnCenter(centerTile, 10);
					}
				}
				else if (d < 5 && tile.IsEmpty)
				{
					if (this.Math.rand(1, 100) <= 30)
					{
						tile.spawnObject("entity/tactical/objects/human_camp_object");
					}
				}
			}
		}


		this.makeBordersImpassable(_rect);
	}

});

