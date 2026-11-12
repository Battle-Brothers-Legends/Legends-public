this.tactical_legend_beast_den <- this.inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.legend_beast_den";
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
			::logError("tactical.legend_beast_den: the den could not be laid (" + e + "), using tactical.mountain");
			this.MapGen.get("tactical.mountain").fill(_rect, _properties, _pass);
		}
	}

	function inField( _x, _y )
	{
		return _x >= 6 && _x <= 26 && _y >= 6 && _y <= 26;
	}

	function rock()
	{
		local r = this.Math.rand(1, 100);

		if (r <= 60)
		{
			return "entity/tactical/objects/boulder";
		}
		else if (r <= 75)
		{
			return "entity/tactical/objects/tundra_boulder1";
		}
		else if (r <= 90)
		{
			return "entity/tactical/objects/autumn_boulder1";
		}

		return "entity/tactical/objects/autumn_boulder2";
	}

	function lay( _rect, _properties )
	{
		local W = _rect.W;
		local H = _rect.H;
		local stone1 = this.MapGen.get("tactical.tile.stone1");
		local stone2 = this.MapGen.get("tactical.tile.stone2");
		local stoneSea = this.MapGen.get("tactical.patch.stone_sea");

		local margin = 4;
		for( local i = 0; i < 7; i = ++i )
		{
			local sx = this.Math.rand(5, 10);
			local sy = this.Math.rand(5, 10);
			local rect = {
				X = this.Math.rand(_rect.X + margin, _rect.X + W - sx - margin),
				Y = this.Math.rand(_rect.Y + margin, _rect.Y + H - sy - margin),
				W = sx,
				H = sy,
				IsEmpty = this.Math.rand(0, 2) != 2
			};

			if (this.Math.rand(1, 100) <= 60)
			{
				this.fillRubble(rect, _properties, stone1, stone2);
			}
			else
			{
				stoneSea.fill(rect, _properties);
			}
		}

		local centre = this.Tactical.getTileSquare(_rect.X + W / 2, _rect.Y + H / 2);
		for( local x = _rect.X; x < _rect.X + W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);
				local rx = x - _rect.X;
				local ry = y - _rect.Y;
				local wall = rx >= 6 && !this.inField(rx, ry) && (rx >= W - 4 || ry <= 2 || ry >= H - 3 || centre.getDistanceTo(tile) > 12 + this.Math.rand(0, 3));

				if (tile.Type == 0)
				{
					(this.Math.rand(1, 100) <= 55 ? stone1 : stone2).fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = wall || this.Math.rand(1, 6) != 1
					}, _properties);
				}

				if (wall) {
					::Legends.Tactical.Tiles.spawnWall(tile)
				}
			}
		}

		local pillars = this.Math.rand(3, 6);
		for( local i = 0; i < pillars; i = ++i )
		{
			local px = 0;
			local py = 0;

			if (this.Math.rand(1, 100) <= 30)
			{
				px = this.Math.rand(16, 17);
				py = this.Math.rand(10, 21);
			}
			else
			{
				px = this.Math.rand(6, 26);
				py = this.Math.rand(0, 1) == 0 ? this.Math.rand(3, 6) : this.Math.rand(26, 28);
			}

			local n = this.Math.rand(1, 3);
			for( local k = 0; k < n; k = ++k )
			{
				local x = _rect.X + px + (k == 1 ? 1 : 0);
				local y = _rect.Y + py + (k == 2 ? 1 : 0);

				if (::Tactical.isValidTileSquare(x, y))	{
					::Legends.Tactical.Tiles.spawnWall(::Tactical.getTileSquare(x, y));
				}
			}
		}

		local bones = this.Math.rand(2, 4);
		for( local i = 0; i < bones; i = ++i )
		{
			this.fillBones({
				X = _rect.X + this.Math.rand(6, 22),
				Y = _rect.Y + this.Math.rand(6, 22),
				W = this.Math.rand(3, 5),
				H = this.Math.rand(3, 5)
			});
		}

		this.furnish(_rect);
		this.makeBordersImpassable(_rect);
	}

	function furnish( _rect )
	{
	}

	function fillBones( _rect )
	{
		local bones = this.Const.BloodDecals[this.Const.BloodType.Bones];
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
					continue;
				}

				local r = this.Math.rand(1, 100);
				if (r < 10) tile.spawnDetail("bust_skeleton_head_03_dead");
				if (r < 30) tile.spawnDetail(bones[this.Math.rand(0, bones.len() - 1)]);
				if (r < 60) tile.spawnDetail(bones[this.Math.rand(0, bones.len() - 1)]);
				if (r < 80) tile.spawnDetail(bones[this.Math.rand(0, bones.len() - 1)]);
				tile.IsHidingEntity = false;
			}
		}
	}

	function fillRubble( _rect, _properties, _tileA, _tileB )
	{
		local mainTile = this.Math.rand(1, 100) < 50 ? _tileA : _tileB;
		local otherTile = mainTile == _tileA ? _tileB : _tileA;
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.Type != 0)
				{
					continue;
				}

				local n = 0;
				if (this.Tactical.isValidTileSquare(x - 1, y) && this.Tactical.getTileSquare(x - 1, y).Level == 1) n = ++n;
				if (this.Tactical.isValidTileSquare(x - 1, y + 1) && this.Tactical.getTileSquare(x - 1, y + 1).Level == 1) n = ++n;
				if (this.Tactical.isValidTileSquare(x, y - 1) && this.Tactical.getTileSquare(x, y - 1).Level == 1) n = ++n;
				tile.Level = this.Math.rand(0, 100) > 98 - n * 20 ? 1 : 0;

				local t = this.Math.rand(0, 100) < 10 ? otherTile : mainTile;
				t.fill({
					X = x,
					Y = y,
					W = 1,
					H = 1,
					IsEmpty = _rect.IsEmpty || this.Math.rand(0, 100) < 33
				}, _properties);
			}
		}
	}

});
