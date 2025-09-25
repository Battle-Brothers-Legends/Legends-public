this.vanilla_template_map <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.vanilla_template";
		this.m.MinX = 30; this.m.MaxX = 30;
		this.m.MinY = 20; this.m.MaxY = 20;
	}

	function onFirstPass( _rect )
	{
		local function GetTile(_id)
		{
			local prefix = "tactical.tile.";
			local path = null;
			if (_id.find(prefix) == 0) path = "scripts/mapgen/templates/tactical/tiles/" + _id.slice(prefix.len());
			else path = _id;
			local inst = null;
			try { inst = this.new(path); } catch(e) { inst = null; }
			if (inst != null && ("init" in inst)) inst.init();
			return inst;
		}
		local Tiles = [ null, GetTile("tactical.tile.grass1"), GetTile("tactical.tile.snow2"), GetTile("tactical.tile.snow1"), GetTile("tactical.tile.tundra5"), GetTile("tactical.tile.tundra4"), GetTile("tactical.tile.autumn1"), GetTile("tactical.tile.swamp2"), GetTile("tactical.tile.tundra3"), GetTile("tactical.tile.stone2"), GetTile("tactical.tile.snow3"), GetTile("tactical.tile.tundra2"), GetTile("tactical.tile.swamp1"), GetTile("tactical.tile.autumn2"), GetTile("tactical.tile.earth2"), GetTile("tactical.tile.moss2"), GetTile("tactical.tile.moss1"), GetTile("tactical.tile.swamp3"), GetTile("tactical.tile.grass2"), GetTile("tactical.tile.tundra1"), GetTile("tactical.tile.road"), GetTile("tactical.tile.swamp5"), GetTile("tactical.tile.swamp4"), GetTile("tactical.tile.desert5"), GetTile("tactical.tile.desert3"), GetTile("tactical.tile.forest2"), GetTile("tactical.tile.desert4"), GetTile("tactical.tile.earth1"), GetTile("tactical.tile.forest1"), GetTile("tactical.tile.steppe1"), GetTile("tactical.tile.steppe2"), GetTile("tactical.tile.steppe4"), GetTile("tactical.tile.steppe3"), GetTile("tactical.tile.steppe5") ];
		local terrainMap = [
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 2, 2, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5],
			[1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 7, 4, 4, 4, 4, 8, 5, 5, 8, 5, 5, 5, 5],
			[1, 9, 6, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 7, 7, 4, 4, 4, 1, 8, 8, 8, 8, 8, 11, 5, 11],
			[1, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 12, 12, 12, 4, 1, 1, 1, 1, 8, 8, 8, 8, 11, 11, 11],
			[1, 9, 6, 13, 13, 6, 1, 1, 1, 1, 1, 1, 14, 15, 15, 16, 12, 12, 1, 1, 1, 1, 1, 1, 8, 8, 8, 11, 11, 11],
			[1, 6, 6, 13, 6, 6, 1, 1, 1, 1, 1, 17, 14, 16, 16, 16, 16, 1, 18, 1, 1, 1, 1, 1, 1, 19, 19, 11, 11, 1],
			[1, 9, 6, 6, 13, 6, 1, 1, 1, 1, 1, 1, 17, 17, 16, 16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 19, 19, 11, 11, 20],
			[1, 6, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1, 17, 21, 22, 22, 22, 1, 1, 1, 1, 18, 18, 1, 1, 19, 19, 1, 20, 20],
			[1, 23, 6, 9, 6, 1, 1, 1, 1, 1, 1, 1, 1, 21, 22, 21, 22, 1, 1, 18, 18, 1, 1, 20, 1, 1, 19, 20, 20, 20],
			[1, 23, 6, 6, 6, 24, 1, 1, 1, 20, 1, 1, 1, 1, 21, 25, 1, 1, 1, 18, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20],
			[1, 1, 9, 6, 6, 1, 1, 20, 20, 20, 20, 20, 1, 25, 25, 25, 26, 18, 18, 20, 20, 20, 20, 1, 20, 20, 20, 20, 20, 1],
			[20, 20, 27, 27, 23, 20, 20, 20, 20, 20, 20, 20, 20, 20, 25, 28, 28, 18, 18, 20, 20, 1, 1, 1, 1, 1, 20, 1, 1, 1],
			[20, 20, 20, 20, 20, 20, 20, 20, 20, 26, 26, 1, 20, 20, 20, 20, 28, 20, 20, 20, 1, 1, 1, 14, 1, 1, 1, 1, 1, 1],
			[20, 20, 20, 20, 20, 20, 20, 26, 26, 26, 26, 1, 1, 1, 20, 20, 20, 20, 20, 14, 14, 14, 1, 1, 1, 29, 1, 29, 1, 29],
			[20, 20, 20, 20, 20, 1, 26, 26, 26, 1, 1, 1, 1, 1, 1, 1, 1, 1, 14, 14, 14, 14, 1, 29, 29, 29, 29, 30, 29, 30],
			[1, 1, 20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 20, 20, 1, 1, 31, 10, 14, 29, 30, 29, 30, 32, 32, 32, 30, 30],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 20, 1, 1, 1, 31, 33, 33, 29, 29, 32, 32, 33, 33, 31, 32, 32],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 1, 1, 1, 1, 29, 29, 32, 32, 33, 33, 31, 31, 33, 31, 31],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 32, 29, 32, 32, 31, 31, 31, 31, 31, 33, 31],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 32, 32, 32, 31, 31, 31, 33, 31, 33, 31, 31, 31]
		];
		local heightMap = [
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		];
		for (local y = 0; y < 20; y = ++y)
		{
			for (local x = 0; x < 30; x = ++x)
			{
				local wx = _rect.X + x;
				local wy = _rect.Y + y;
				local tile = this.Tactical.getTileSquare(wx, wy);
				// Set height first
				tile.Level = heightMap[y][x];
				// Stamp terrain
				local code = terrainMap[y][x];
				local rect = { X = wx, Y = wy, W = 1, H = 1, IsEmpty = false };
				if (code != 0 && Tiles[code] != null) Tiles[code].fill(rect, null);
			}
		}
		this.makeBordersImpassable(_rect);
	}

	function onSecondPass( _rect )
	{
		local Sprites = [ null, "camp_14", "snow_forest_treetrunk_03", "forest_treetrunk_03", "forest_treetrunk_02", "barbarians_02", "socket_desert", "phylactery", "camp_01", "forest_treetrunk_01", "orcs_09", "stump_01", "orcs_03", "camp_18_07", "steppe_cypress_01_bottom", "camp_18_02", "camp_18_03", "camp_18_04", "desert_detail_ruins_01_bottom", "tree_01_bottom", "desert_cactus_02", "desert_stone_01_bottom", "steppe_cypress_02_bottom", "boulder_01", "steppe_cypress_01_top", "desert_detail_ruins_01_top", "tree_01_top", "desert_stone_01_top", "steppe_cypress_02_top", "desert_plant_02" ];
		local Entities = {};
		local objectMap = [
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 23, 29, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0],
			[0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 24, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0],
			[0, 0, 0, 26, 0, 14, 15, 16, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 27, 0],
			[0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 21, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		];
		for (local y = 0; y < 20; y = ++y)
		{
			for (local x = 0; x < 30; x = ++x)
			{
				local wx = _rect.X + x;
				local wy = _rect.Y + y;
				local tile = this.Tactical.getTileSquare(wx, wy);
				local code = objectMap[y][x];
				if (code == 0) continue;
				local sid = Sprites[code];
				if (sid in Entities)
				{
					local o = tile.spawnObject(Entities[sid]);
					if (o != null)
					{
						local b = o.getSprite("body");
						if (b != null) b.setBrush(sid);
					}
				}
				else
				{
					tile.spawnDetail(sid);
				}
			}
		}
	}

});
