::mods_hookExactClass("mapgen/templates/tactical/tiles/forest1", function(o)
{
	o.onFirstPass = function ( _rect, _objectSpawnChanceMult = 1.0 )
	{
		local tile = ::Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = ::Const.Tactical.TerrainType.Forest;
		tile.Subtype = ::Const.Tactical.TerrainSubtype.Forest;
		tile.BlendPriority = ::Const.Tactical.TileBlendPriority.Forest;
		tile.setBrush("tile_forest_01");
		local n = 0;

		if (!("IsSmallTree" in _rect))
		{
			_rect.IsSmallTree <- false
		}

		if (!("IsTreeAllowed" in _rect))
		{
			_rect.IsTreeAllowed <- false
		}


		if (!_rect.IsEmpty && ::Math.rand(1, 100) < this.m.ChanceToSpawnObject * _objectSpawnChanceMult)
		{
			if (_rect.IsSmallTree)
			{
				tile.spawnObject(this.m.ObjectsTreesSmall[::Math.rand(0, this.m.ObjectsTreesSmall.len() - 1)]);

				if (::Math.rand(1, 100) <= 33)
				{
					for( local details = ::Math.rand(1, 100) < 45 ? this.m.DetailsA : this.m.DetailsB; ::Math.rand(1, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails;  )
					{
						tile.spawnDetail(details[::Math.rand(0, details.len() - 1)]);
					}
				}
			}
			else if (_rect.IsTreeAllowed)
			{
				tile.spawnObject(this.m.ObjectsTrees[::Math.rand(0, this.m.ObjectsTrees.len() - 1)]);
			}
			else
			{
				tile.spawnObject(this.m.Objects[::Math.rand(0, this.m.Objects.len() - 1)]);
			}

			tile.IsSpecialTerrain = true;

			if (::Math.rand(1, 100) <= 90)
			{
				if (::Math.rand(1, 100) <= 50)
				{
					tile.spawnDetail("hiding_shrubbery_01_front");
				}
				else
				{
					tile.spawnDetail("forest_roots_0" + ::Math.rand(1, 3));
				}
			}
		}

		local h = 0;

		if (::Tactical.isValidTileSquare(_rect.X - 1, _rect.Y) && ::Tactical.getTileSquare(_rect.X - 1, _rect.Y).IsHidingEntity)
		{
			h = ++h;
		}

		if (::Tactical.isValidTileSquare(_rect.X - 1, _rect.Y + 1) && ::Tactical.getTileSquare(_rect.X - 1, _rect.Y + 1).IsHidingEntity)
		{
			h = ++h;
		}

		if (::Tactical.isValidTileSquare(_rect.X, _rect.Y - 1) && ::Tactical.getTileSquare(_rect.X, _rect.Y - 1).IsHidingEntity)
		{
			h = ++h;
		}

		local details = ::Math.rand(1, 100) < 45 ? this.m.DetailsA : this.m.DetailsB;
		local decalSpawned = false;

		if (::Math.rand(1, 100) < this.m.ChanceToSpawnShadow)
		{
			tile.spawnDetail(this.m.Shadows[::Math.rand(0, this.m.Shadows.len() - 1)]);
		}

		while (::Math.rand(1, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails)
		{
			tile.spawnDetail(details[::Math.rand(0, details.len() - 1)]);
			decalSpawned = true;
		}

		if (decalSpawned && ::Math.rand(1, 100) < this.m.ChanceToSpawnBugs)
		{
			for( local i = 0; i < this.m.Bugs.len(); i = ++i )
			{
				tile.spawnDetail(this.m.Bugs[i]);
			}
		}
	}
});
