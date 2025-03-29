this.tactical_legend_tournament <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.legend_tournament";
		this.m.MinX = 26;
		this.m.MinY = 26;
	}

	function fill( _rect, _properties, _pass = 1 )
	{

		this.addRoads(_rect, _properties);

		local patches = [
			["tactical.tile.steppe1", "tactical.tile.steppe2", "tactical.tile.steppe3", "tactical.tile.steppe4"],
			["tactical.tile.autumn1", "tactical.tile.autumn2", "tactical.tile.autumn3", "tactical.tile.autumn4"],
			["tactical.tile.forest1", "tactical.tile.forest2", "tactical.tile.moss1", "tactical.tile.moss2"],
			["tactical.tile.swamp1", "tactical.tile.swamp2", "tactical.tile.swamp3", "tactical.tile.swamp4"],
			["tactical.tile.desert1", "tactical.tile.desert2", "tactical.tile.desert7", "tactical.tile.desert4"],
			["tactical.tile.snow1", "tactical.tile.snow2", "tactical.tile.snow3", "tactical.tile.snow4"],
			["tactical.tile.grass1", "tactical.tile.grass2", "tactical.tile.earth3", "tactical.tile.earth4"],
			["tactical.tile.moss1", "tactical.tile.moss2", "tactical.tile.forest1", "tactical.tile.forest2"],
			["tactical.tile.stone1", "tactical.tile.stone2", "tactical.tile.stone3", "tactical.tile.earth1"],
			["tactical.tile.tundra1", "tactical.tile.tundra2", "tactical.tile.tundra3", "tactical.tile.tundra4"],
			["tactical.tile.earth1", "tactical.tile.earth2", "tactical.tile.grass1", "tactical.tile.grass2"],
		];

		local p =  patches[this.Math.rand(0, patches.len() -1)];
		local Tile1 = this.MapGen.get(p[0]);
		local Tile2 = this.MapGen.get(p[1]);
		local Tile3 = this.MapGen.get(p[2]);
		local Tile4 = this.MapGen.get(p[3]);

		local templates = [];

		local patch = [
			"tactical.patch.steppe",
			"tactical.patch.clearing",
			"tactical.patch.clearing_leveled",
			"tactical.patch.tundra",
			"tactical.patch.forest",
			"tactical.patch.swamp",
			"tactical.patch.tundra_grass",
			"tactical.patch.desert",
			"tactical.patch.autumn_grass"
		];
		local StandardPatch = this.MapGen.get(patch[this.Math.rand(0, patch.len() -1)]);

		patch = [
			"tactical.patch.stone_sea",
			"tactical.patch.dry",
			"tactical.patch.bones",
			"tactical.patch.forest_leaves",
			"tactical.patch.arena",
			"tactical.patch.tundra_stony",
			"tactical.patch.autumn_stony",
			"tactical.patch.snow_less",
			"tactical.patch.forest_mushrooms",
			"tactical.patch.stone_circle"
		];
		local DryPatch = this.MapGen.get(patch[this.Math.rand(0, patch.len() -1)]);

		patch = [
			"tactical.patch.autumn_brushes",
			"tactical.patch.clover_sea",
			"tactical.patch.flower_sea",
			"tactical.patch.oasis",
			"tactical.patch.arena",
			"tactical.patch.forest_leaves_thick",
			"tactical.patch.forest_thick",
			"tactical.patch.swamp_pond",
			"tactical.patch.tundra_brushes",
			"tactical.patch.snow",
			"tactical.patch.forest_fern_sea"
		];
		local WetPatch = this.MapGen.get(patch[this.Math.rand(0, patch.len() -1)]);

		patch = [
			"tactical.patch.hill_steppe",
			"tactical.patch.hill_snow",
			"tactical.patch.hill_desert",
			"tactical.patch.hill_tundra",
			"tactical.patch.mountain",
			"tactical.patch.mound",
			"tactical.patch.hill",
			"tactical.patch.ritual_site",
			"tactical.patch.forest_snow",
		];
		local HillPatch = this.MapGen.get(patch[this.Math.rand(0, patch.len() -1)]);

		templates.push(StandardPatch);
		templates.push(StandardPatch);
		templates.push(StandardPatch);
		templates.push(HillPatch);
		templates.push(WetPatch);
		templates.push(DryPatch);


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
							steppeTile1.fill({
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

