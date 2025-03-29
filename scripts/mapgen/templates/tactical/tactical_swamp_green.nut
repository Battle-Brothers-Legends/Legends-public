this.tactical_swamp_green <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.swamp_green";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local tile1 = this.MapGen.get("tactical.tile.swampgreen3");
		local tile2 = this.MapGen.get("tactical.tile.swampgreen2");
		local tile3 = this.MapGen.get("tactical.tile.swampgreen1");
		local tile4 = this.MapGen.get("tactical.tile.swampgreen4");
		local tile5 = this.MapGen.get("tactical.tile.swampgreen5");
		this.addRoads(_rect, _properties);
		local templates = [];
		local mainPatch = this.MapGen.get("tactical.patch.swamp_green");
		local pondPatch = this.MapGen.get("tactical.patch.swamp_green_pond");
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(mainPatch);
		templates.push(pondPatch);
		local pondPatches = 20;
		local pondAttempts = 0;

		while (pondPatches != 0 && pondAttempts < 3000)
		{
			pondAttempts = ++pondAttempts;
			local sizeX = this.Math.rand(4, 8);
			local sizeY = this.Math.rand(4, 8);
			local rect = {
				X = 0,
				Y = 0,
				W = sizeX,
				H = sizeY,
				IsEmpty = false
			};
			rect.X = this.Math.rand(1, _rect.W - sizeX);
			rect.Y = this.Math.rand(1, _rect.H - sizeY);
			pondPatch.fill(rect, _properties);
			pondPatches = --pondPatches;
		}

		local patches = 12;

		while (patches != 0)
		{
			patches = --patches;
			local selectedTemplate = templates[this.Math.rand(0, templates.len() - 1)];
			local sizeX = this.Math.rand(this.Math.max(selectedTemplate.getMinX(), this.Math.min(selectedTemplate.getMaxX(), 8)), this.Math.min(selectedTemplate.getMaxX(), 20));
			local sizeY = this.Math.rand(this.Math.max(selectedTemplate.getMinY(), this.Math.min(selectedTemplate.getMaxY(), 8)), this.Math.min(selectedTemplate.getMaxY(), 20));
			local rect = {
				X = 0,
				Y = 0,
				W = sizeX,
				H = sizeY,
				IsEmpty = false
			};
			rect.X = this.Math.rand(1, _rect.W - sizeX);
			rect.Y = this.Math.rand(1, _rect.H - sizeY);
			selectedTemplate.fill(rect, _properties);
		}

		local bumpyChance = 100;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.Type != 0)
				{
					if (tile.BlendPriority == this.Const.Tactical.TileBlendPriority.Swampgreen4)
					{
						tile4.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1
						}, _properties, 2);
					}
					else
					{
						tile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1
						}, _properties, 2);
					}
				}
				else
				{
					tile.Level = 0;
					local n = this.Math.rand(1, 100);

					if (n < 50)
					{
						tile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties);
					}
					else if (n < 70)
					{
						tile2.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties);
					}
					else if (n < 90)
					{
						tile3.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties);
					}
					else
					{
						tile5.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties);
					}
				}
			}
		}

		this.makeBordersImpassable(_rect);
	}

	function campify( _rect, _properties )
	{
		local tile1 = this.MapGen.get("tactical.tile.swampgreen1");
		local tile2 = this.MapGen.get("tactical.tile.swampgreen2");
		local tile3 = this.MapGen.get("tactical.tile.swampgreen3");
		local centerTile = this.Tactical.getTileSquare(_rect.X + _rect.W / 2 + _properties.ShiftX, _rect.Y + _rect.H / 2 + _properties.ShiftY);
		local radius = this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);
				local d = centerTile.getDistanceTo(tile);

				if (d <= radius + 1)
				{
					if (tile.IsHidingEntity)
					{
						tile.clear();
					}

					tile.Type = 0;
					local r = this.Math.rand(1, 3);

					if (r == 1)
					{
						tile1.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, null);
					}
					else if (r == 2)
					{
						tile2.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, null);
					}
					else if (r == 3)
					{
						tile3.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, null);
					}
				}
			}
		}
	}

});

