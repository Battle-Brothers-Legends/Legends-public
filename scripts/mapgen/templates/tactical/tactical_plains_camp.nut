this.tactical_plains_camp <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.plains_camp";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local grassTile1 = this.MapGen.get("tactical.tile.grass1");
		local grassTile2 = this.MapGen.get("tactical.tile.grass2");
		local earthTile1 = this.MapGen.get("tactical.tile.earth1");
		this.addRoads(_rect, _properties);
		local templates = [];
		local mainPatch = this.MapGen.get("tactical.patch.clearing_leveled");
		local clearingPatch = this.MapGen.get("tactical.patch.clearing");
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(clearingPatch);
		local patches = 6;

		while (patches != 0)
		{
			patches = --patches;
			local selectedTemplate = templates[this.Math.rand(0, templates.len() - 1)];
			local sizeX = this.Math.rand(this.Math.min(selectedTemplate.getMinX(), 8), this.Math.min(selectedTemplate.getMaxX(), 20));
			local sizeY = this.Math.rand(this.Math.min(selectedTemplate.getMinY(), 8), this.Math.min(selectedTemplate.getMaxY(), 20));
			local rect = {
				X = 0,
				Y = 0,
				W = sizeX,
				H = sizeY,
				IsEmpty = this.Math.rand(0, 2) != 2
			};
			rect.X = this.Math.rand(1, _rect.W - sizeX);
			rect.Y = this.Math.rand(1, _rect.H - sizeY);
			selectedTemplate.fill(rect, _properties);
		}

		local bumpyChance = this.Math.rand(99, 100);

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
					local n = 0;

					if (this.Tactical.isValidTileSquare(x - 1, y) && this.Tactical.getTileSquare(x - 1, y).Level == 1)
					{
						n = ++n;
					}

					if (this.Tactical.isValidTileSquare(x - 1, y + 1) && this.Tactical.getTileSquare(x - 1, y + 1).Level == 1)
					{
						n = ++n;
					}

					if (this.Tactical.isValidTileSquare(x, y - 1) && this.Tactical.getTileSquare(x, y - 1).Level == 1)
					{
						n = ++n;
					}

					tile.Level = 0;

					if (this.Math.rand(1, 100) > bumpyChance - n * 25)
					{
						tile.Level = 1;
					}

					n = this.Math.rand(1, 100);

					if (n < 50)
					{
						grassTile1.fillWithShrubbery({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = this.Math.rand(1, 5) != 1
						}, _properties);
					}
					else if (n < 90)
					{
						grassTile2.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = this.Math.rand(1, 5) != 1
						}, _properties);
					}
					else
					{
						earthTile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = this.Math.rand(1, 5) != 1
						}, _properties);
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
					if (this.Math.rand(1, 100) <= 10)
					{
						tile.spawnObject("entity/tactical/objects/human_camp_object");
					}
				}
			}
		}

		this.makeBordersImpassable(_rect);
	}

});

