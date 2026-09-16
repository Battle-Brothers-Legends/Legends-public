this.tactical_legend_cave <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.legend_cave";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local stoneTile1 = this.MapGen.get("tactical.tile.stone1");
		local stoneTile2 = this.MapGen.get("tactical.tile.stone2");
		local earthTile1 = this.MapGen.get("tactical.tile.legend_cave1");
		this.addRoads(_rect, _properties);
		local templates = [];
		local mainPatch = this.MapGen.get("tactical.patch.legend_cave");
		local clearingPatch = this.MapGen.get("tactical.patch.bones");
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(clearingPatch);

		if (::Math.rand(1, 100) <= 10)
		{
			templates.push(this.MapGen.get("tactical.patch.stone_circle"));
		}

		if (::Math.rand(1, 100) <= 20)
		{
			templates.push(this.MapGen.get("tactical.patch.stone_sea"));
		}

		if (::Math.rand(1, 100) <= 30)
		{
			templates.push(this.MapGen.get("tactical.patch.dry"));
		}

		local patches = 6;

		while (patches != 0)
		{
			patches = --patches;
			local selectedTemplate = templates[::Math.rand(0, templates.len() - 1)];
			local sizeX = ::Math.rand(::Math.min(selectedTemplate.getMinX(), 8), ::Math.min(selectedTemplate.getMaxX(), 20));
			local sizeY = ::Math.rand(::Math.min(selectedTemplate.getMinY(), 8), ::Math.min(selectedTemplate.getMaxY(), 20));
			local rect = {
				X = 0,
				Y = 0,
				W = sizeX,
				H = sizeY,
				IsEmpty = ::Math.rand(0, 2) != 2
			};
			rect.X = ::Math.rand(1, _rect.W - sizeX);
			rect.Y = ::Math.rand(1, _rect.H - sizeY);
			selectedTemplate.fill(rect, _properties);
		}

		local bumpyChance = ::Math.rand(90, 100);
		local centerTile = ::Tactical.getTileSquare(_rect.X + _rect.W / 2, _rect.Y + _rect.H / 2);
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);
				local d = centerTile.getDistanceTo(tile);
				if (d > 8 && x > (_rect.X / 4))
				{
					tile.Level = 4;
				}
				if (tile.Type != 0)
				{
				}
				else
				{
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

				//	tile.Level = 0;

				//	if (::Math.rand(1, 100) > bumpyChance - n * 25)
				//	{
				//		tile.Level = 1;
				//	}

					n = ::Math.rand(1, 100);

					if (n < 50)
					{
						stoneTile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = ::Math.rand(1, 5) != 1
						}, _properties);
					}
					else if (n < 90)
					{
						stoneTile2.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = ::Math.rand(1, 5) != 1
						}, _properties);
					}
					else
					{
						earthTile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = ::Math.rand(1, 5) != 1
						}, _properties);
					}
				}
			}
		}

		this.makeBordersImpassable(_rect);
	}

	function campify( _rect, _properties )
	{
		local earthTile1 = this.MapGen.get("tactical.tile.earth1");
		local earthTile2 = this.MapGen.get("tactical.tile.earth2");
		local centerTile = ::Tactical.getTileSquare(_rect.X + _rect.W / 2 + _properties.ShiftX, _rect.Y + _rect.H / 2 + _properties.ShiftY);

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);
				local d = centerTile.getDistanceTo(tile);

				if (d <= ::Const.Tactical.Settings.CampRadius)
				{
					tile.Level = 0;

					if (::Math.rand(1, 100) <= 50 + (7 - d) * 7)
					{
						tile.Type = 0;
						tile.clear();
						local r = ::Math.rand(1, 2);

						if (r == 1)
						{
							earthTile1.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = false
							}, null);
						}
						else
						{
							earthTile2.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = false
							}, null);
						}
					}

					if (tile.IsHidingEntity)
					{
						tile.clear();
					}

					if (!tile.IsEmpty && ::Math.rand(1, 100) <= 50)
					{
						tile.removeObject();
					}
				}

		
			}
		}
	}

});

