this.tactical_legend_beast_den_forest <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.legend_beast_den_forest";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		try
		{
			this.lay(_rect, _properties);
		}
		catch (e)
		{
			::logError("tactical.legend_beast_den_forest: the nest could not be laid (" + e + "), using tactical.forest");
			this.MapGen.get("tactical.forest").fill(_rect, _properties, _pass);
		}
	}

	function inField( _x, _y )
	{
		return _x >= 6 && _x <= 26 && _y >= 6 && _y <= 26;
	}

	function getTheme( _properties )
	{
		local type = _properties != null && _properties.Tile != null ? _properties.Tile.Type : ::Const.World.TerrainType.Forest;

		if (type == ::Const.World.TerrainType.AutumnForest)
		{
			return {
				Floor = [ "tactical.tile.autumn1", "tactical.tile.autumn2", "tactical.tile.autumn3", "tactical.tile.autumn4" ],
				Clump = null,
				Tall = [ "entity/tactical/objects/autumn_tree1", "entity/tactical/objects/autumn_tree2" ],
				Small = [ "entity/tactical/objects/autumn_tree1", "entity/tactical/objects/autumn_tree2" ]
			};
		}
		else if (type == ::Const.World.TerrainType.LeaveForest)
		{
			return {
				Floor = [ "tactical.tile.moss2" ],
				Clump = "tactical.tile.forest2",
				Tall = [ "entity/tactical/objects/tree_lush" ],
				Small = [ "entity/tactical/objects/tree_lush_small", "entity/tactical/objects/tree_lush_smaller", "entity/tactical/objects/tree_trunk_forest_leaves" ]
			};
		}

		return {
			Floor = [ "tactical.tile.moss1" ],
			Clump = "tactical.tile.forest1",
			Tall = [ "entity/tactical/objects/tree_needle2" ],
			Small = [ "entity/tactical/objects/tree_needle1", "entity/tactical/objects/tree_needle2_smaller", "entity/tactical/objects/tree_trunk_forest" ]
		};
	}

	function pick( _list )
	{
		return _list[::Math.rand(0, _list.len() - 1)];
	}

	function plant( _tile, _object, _webChance = 0 )
	{
		_tile.Level = 0;
		_tile.clear();

		if (!_tile.IsEmpty)
		{
			_tile.removeObject();
		}

		local tree = _tile.spawnObject(_object);

		if (tree.hasSprite("web") && ::Math.rand(1, 100) <= _webChance)
		{
			tree.getSprite("web").Visible = true;
		}
	}

	function lay( _rect, _properties )
	{
		local W = _rect.W;
		local H = _rect.H;
		local theme = this.getTheme(_properties);

		if (theme.Clump != null)
		{
			local clump = this.MapGen.get(theme.Clump);
			local margin = 4;
			for( local i = 0; i < 7; i = ++i )
			{
				local sx = ::Math.rand(4, 8);
				local sy = ::Math.rand(4, 8);
				local px = ::Math.rand(_rect.X + margin, _rect.X + W - sx - margin);
				local py = ::Math.rand(_rect.Y + margin, _rect.Y + H - sy - margin);
				for( local x = px; x < px + sx; x = ++x )
				{
					for( local y = py; y < py + sy; y = ++y )
					{
						clump.fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, _properties);
					}
				}
			}
		}

		local centre = ::Tactical.getTileSquare(_rect.X + W / 2, _rect.Y + H / 2);
		for( local x = _rect.X; x < _rect.X + W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + H; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);
				local rx = x - _rect.X;
				local ry = y - _rect.Y;
				local wall = rx >= 6 && !this.inField(rx, ry) && (rx >= W - 4 || ry <= 2 || ry >= H - 3 || centre.getDistanceTo(tile) > 12 + ::Math.rand(0, 3));

				if (tile.Type == 0)
				{
					this.MapGen.get(this.pick(theme.Floor)).fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = wall
					}, _properties);
				}

				if (wall)
				{
					local isDeep = rx >= W - 3 || ry <= 1 || ry >= H - 2;
					this.plant(tile, this.pick(isDeep ? theme.Tall : theme.Small), 40);
				}
			}
		}

		local thickets = ::Math.rand(5, 9);
		for( local i = 0; i < thickets; i = ++i )
		{
			local px = 0;
			local py = 0;

			if (::Math.rand(1, 100) <= 30)
			{
				px = ::Math.rand(16, 17);
				py = ::Math.rand(10, 21);
			}
			else
			{
				px = ::Math.rand(6, 26);
				py = ::Math.rand(0, 1) == 0 ? ::Math.rand(3, 6) : ::Math.rand(26, 28);
			}

			local n = ::Math.rand(1, 3);
			for( local k = 0; k < n; k = ++k )
			{
				local x = _rect.X + px + (k == 1 ? 1 : 0);
				local y = _rect.Y + py + (k == 2 ? 1 : 0);

				if (::Tactical.isValidTileSquare(x, y))
				{
					this.plant(::Tactical.getTileSquare(x, y), this.pick(::Math.rand(0, 1) == 0 ? theme.Tall : theme.Small), 100);
				}
			}
		}

		local bones = ::Math.rand(2, 4);
		for( local i = 0; i < bones; i = ++i )
		{
			this.fillBones({
				X = _rect.X + ::Math.rand(6, 22),
				Y = _rect.Y + ::Math.rand(6, 22),
				W = ::Math.rand(3, 5),
				H = ::Math.rand(3, 5)
			});
		}

		this.makeBordersImpassable(_rect);
	}

	function fillBones( _rect )
	{
		local bones = ::Const.BloodDecals[::Const.BloodType.Bones];
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = ::Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
					continue;
				}

				local r = ::Math.rand(1, 100);
				if (r < 10) tile.spawnDetail("bust_skeleton_head_03_dead");
				if (r < 30) tile.spawnDetail(bones[::Math.rand(0, bones.len() - 1)]);
				if (r < 60) tile.spawnDetail(bones[::Math.rand(0, bones.len() - 1)]);
				if (r < 80) tile.spawnDetail(bones[::Math.rand(0, bones.len() - 1)]);
				tile.IsHidingEntity = false;
			}
		}
	}

});
