this.tactical_tournament <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.tournament";
		this.m.MinX = 26;
		this.m.MinY = 26;
	}

	function fill( _rect, _properties, _pass = 1 )
	{

		local tiles = [
			this.MapGen.get("tactical.tile.autumn1"),
			this.MapGen.get("tactical.tile.autumn2"),
			this.MapGen.get("tactical.tile.autumn3"),
			this.MapGen.get("tactical.tile.autumn4"),
			this.MapGen.get("tactical.tile.desert1"),
			this.MapGen.get("tactical.tile.desert2"),
			this.MapGen.get("tactical.tile.desert3"),
			this.MapGen.get("tactical.tile.desert4"),
			this.MapGen.get("tactical.tile.desert5"),
			this.MapGen.get("tactical.tile.desert6"),
			this.MapGen.get("tactical.tile.desert7"),
			this.MapGen.get("tactical.tile.desert7_oasis"),
			this.MapGen.get("tactical.tile.earth1"),
			this.MapGen.get("tactical.tile.earth2"),
			this.MapGen.get("tactical.tile.forest1"),
			this.MapGen.get("tactical.tile.forest2"),
			this.MapGen.get("tactical.tile.grass1"),
			this.MapGen.get("tactical.tile.grass2"),
			this.MapGen.get("tactical.tile.moss1"),
			this.MapGen.get("tactical.tile.moss2"),
			this.MapGen.get("tactical.tile.earth1"),
			this.MapGen.get("tactical.tile.earth2"),
			this.MapGen.get("tactical.tile.forest1"),
			this.MapGen.get("tactical.tile.forest2"),
			this.MapGen.get("tactical.tile.grass1"),
			this.MapGen.get("tactical.tile.grass2"),
			this.MapGen.get("tactical.tile.moss1"),
			this.MapGen.get("tactical.tile.moss2"),
			this.MapGen.get("tactical.tile.road"),
			this.MapGen.get("tactical.tile.snow1"),
			this.MapGen.get("tactical.tile.snow2"),
			this.MapGen.get("tactical.tile.snow3"),
			this.MapGen.get("tactical.tile.steppe1"),
			this.MapGen.get("tactical.tile.steppe2"),
			this.MapGen.get("tactical.tile.steppe3"),
			this.MapGen.get("tactical.tile.steppe4"),
			this.MapGen.get("tactical.tile.steppe5"),
			this.MapGen.get("tactical.tile.stone1"),
			this.MapGen.get("tactical.tile.stone2"),
			this.MapGen.get("tactical.tile.stone3"),
			this.MapGen.get("tactical.tile.swamp1"),
			this.MapGen.get("tactical.tile.swamp2"),
			this.MapGen.get("tactical.tile.swamp3"),
			this.MapGen.get("tactical.tile.swamp4"),
			this.MapGen.get("tactical.tile.swamp5"),
			this.MapGen.get("tactical.tile.tundra1"),
			this.MapGen.get("tactical.tile.tundra2"),
			this.MapGen.get("tactical.tile.tundra3"),
			this.MapGen.get("tactical.tile.tundra4"),
			this.MapGen.get("tactical.tile.tundra5")
		];

		local Tile1 = tiles[this.Math.rand(0, tiles.len() - 1)];
		local Tile2 = tiles[this.Math.rand(0, tiles.len() - 1)];
		local Tile3 = tiles[this.Math.rand(0, tiles.len() - 1)];
		local Tile4 = tiles[this.Math.rand(0, tiles.len() - 1)];


		this.logWarning("Grand Tournament Tile 1: " + Tile1.getName());
		this.logWarning("Grand Tournament Tile 2: " + Tile2.getName());
		this.logWarning("Grand Tournament Tile 3: " + Tile3.getName());
		this.logWarning("Grand Tournament Tile 4: " + Tile4.getName());

		this.addRoads(_rect, _properties);
		local templates = [	];
		local candidate_patches = [
		this.MapGen.get("tactical.patch.arena"),
		this.MapGen.get("tactical.patch.autumn_brushes"),
		this.MapGen.get("tactical.patch.autumn_grass"),
		this.MapGen.get("tactical.patch.autumn_stony"),
		this.MapGen.get("tactical.patch.bones"),
		this.MapGen.get("tactical.patch.clearing"),
		this.MapGen.get("tactical.patch.clearing_leveled"),
		this.MapGen.get("tactical.patch.clover_sea"),
		this.MapGen.get("tactical.patch.desert"),
		this.MapGen.get("tactical.patch.dry"),
		this.MapGen.get("tactical.patch.forest"),
		this.MapGen.get("tactical.patch.forest_fern_sea"),
		this.MapGen.get("tactical.patch.forest_leaves"),
		// this.MapGen.get("tactical.patch.forest_leaves_thick"), //this one patch in particular can often cause the map to be completely impassable
		this.MapGen.get("tactical.patch.forest_mushrooms"),
		this.MapGen.get("tactical.patch.forest_snow"),
		this.MapGen.get("tactical.patch.hill"),
		this.MapGen.get("tactical.patch.hill_desert"),
		this.MapGen.get("tactical.patch.hill_snow"),
		this.MapGen.get("tactical.patch.hill_steppe"),
		this.MapGen.get("tactical.patch.hill_tundra"),
		this.MapGen.get("tactical.patch.mound"),
		this.MapGen.get("tactical.patch.mountain"),
		this.MapGen.get("tactical.patch.oasis"),
		this.MapGen.get("tactical.patch.ritual_site"),
		this.MapGen.get("tactical.patch.snow"),
		this.MapGen.get("tactical.patch.snow_less"),
		this.MapGen.get("tactical.patch.steppe"),
		this.MapGen.get("tactical.patch.stone_sea"),
		this.MapGen.get("tactical.patch.swamp"),
		this.MapGen.get("tactical.patch.swamp_pond"),
		this.MapGen.get("tactical.patch.tundra_brushes"),
		this.MapGen.get("tactical.patch.tundra_grass"),
		this.MapGen.get("tactical.patch.tundra_stony"),
		];

		local selected1 = candidate_patches[this.Math.rand(0, candidate_patches.len() - 1)];
		local selected2 = candidate_patches[this.Math.rand(0, candidate_patches.len() - 1)];
		local selected3 = candidate_patches[this.Math.rand(0, candidate_patches.len() - 1)];
		local selected4 = candidate_patches[this.Math.rand(0, candidate_patches.len() - 1)];


		templates.push(selected1);
		templates.push(selected1);
		templates.push(selected1);
		templates.push(selected1);
		templates.push(selected1);
		templates.push(selected2);
		templates.push(selected2);
		templates.push(selected2);
		templates.push(selected3);
		templates.push(selected3);
		templates.push(selected4);

		local patches = 12;

		while (patches != 0)
		{
			patches = --patches;
			local selectedTemplate = templates[this.Math.rand(0, templates.len() - 1)];
			local sizeX = this.Math.rand(this.Math.max(selectedTemplate.getMinX(), this.Math.min(selectedTemplate.getMaxX(), 8)), this.Math.min(selectedTemplate.getMaxX(), 16));
			local sizeY = this.Math.rand(this.Math.max(selectedTemplate.getMinY(), this.Math.min(selectedTemplate.getMaxY(), 8)), this.Math.min(selectedTemplate.getMaxY(), 16));
			local rect = {
				X = 0,
				Y = 0,
				W = sizeX,
				H = sizeY,
				IsEmpty = true
			};
			rect.X = this.Math.rand(1, _rect.W - sizeX);
			rect.Y = this.Math.rand(1, _rect.H - sizeY);
			selectedTemplate.fill(rect, _properties);
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (x <= _rect.X + 1 || y <= _rect.Y + 1 || x >= _rect.X + _rect.W - 2 || y >= _rect.Y + _rect.H - 2)
				{
					if (x <= _rect.X || y <= _rect.Y || x >= _rect.X + _rect.W - 1 || y >= _rect.Y + _rect.H - 1)
					{
						tile.Level = 3;
					}
					else
					{
						tile.Level = 2;
					}

					tile.Type = 0;
					Tile4.fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = true
					}, _properties, 1);
				}
				else
				{
					tile.Level = 0;

					if (tile.Type != 0)
					{
					}
					else
					{
						local r = this.Math.rand(1, 3);

						if (r == 1)
						{
							Tile1.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, _properties, 1);
							Tile1.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, _properties, 2);
						}
						else if (r == 2)
						{
							Tile2.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, _properties, 1);
							Tile2.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, _properties, 2);
						}
						else if (r == 3)
						{
							Tile3.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, _properties, 1);
							Tile3.fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, _properties, 2);
						}
					}
				}
			}
		}

		this.makeBordersImpassable(_rect);
	}

});

