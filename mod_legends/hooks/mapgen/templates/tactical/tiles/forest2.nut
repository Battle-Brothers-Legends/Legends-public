::mods_hookExactClass("mapgen/templates/tactical/tiles/forest2", function(o)
{
	o.onFirstPass = function ( _rect, _objectSpawnChanceMult = 1.0 )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = this.Const.Tactical.TerrainType.Forest;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.Forest;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Forest;
		tile.setBrush("tile_forest_02");
		local n = 0;

		if (!("IsSmallTree" in _rect))
		{
			_rect.IsSmallTree <- false
		}

		if (!("IsTreeAllowed" in _rect))
		{
			_rect.IsTreeAllowed <- false
		}

		if (!_rect.IsEmpty && this.Math.rand(1, 100) < this.m.ChanceToSpawnObject * _objectSpawnChanceMult)
		{
			if (_rect.IsSmallTree)
			{
				tile.spawnObject(this.m.ObjectsTreesSmall[this.Math.rand(0, this.m.ObjectsTreesSmall.len() - 1)]);

				if (this.Math.rand(1, 100) <= 33)
				{
					for( local details = this.Math.rand(1, 100) < 45 ? this.m.DetailsA : this.m.DetailsB; this.Math.rand(1, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails;  )
					{
						tile.spawnDetail(details[this.Math.rand(0, details.len() - 1)]);
					}
				}
			}
			else if (_rect.IsTreeAllowed)
			{
				tile.spawnObject(this.m.ObjectsTrees[this.Math.rand(0, this.m.ObjectsTrees.len() - 1)]);
			}
			else
			{
				tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);

				while (this.Math.rand(1, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails)
				{
					tile.spawnDetail(this.m.DetailsB[this.Math.rand(0, this.m.DetailsB.len() - 1)]);
				}

				if (this.Math.rand(1, 100) <= 80)
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						tile.spawnDetail("hiding_shrubbery_01_front");
					}
					else
					{
						tile.spawnDetail("forest_roots_0" + this.Math.rand(1, 3));
					}
				}
			}

			tile.IsSpecialTerrain = true;
		}
		else
		{
			local h = 0;

			if (this.Tactical.isValidTileSquare(_rect.X - 1, _rect.Y) && this.Tactical.getTileSquare(_rect.X - 1, _rect.Y).IsHidingEntity)
			{
				h = ++h;
			}

			if (this.Tactical.isValidTileSquare(_rect.X - 1, _rect.Y + 1) && this.Tactical.getTileSquare(_rect.X - 1, _rect.Y + 1).IsHidingEntity)
			{
				h = ++h;
			}

			if (this.Tactical.isValidTileSquare(_rect.X, _rect.Y - 1) && this.Tactical.getTileSquare(_rect.X, _rect.Y - 1).IsHidingEntity)
			{
				h = ++h;
			}

			if (this.Math.rand(1, 100) < this.m.ChanceToSpawnHiding + h * this.m.ChanceToSpawnHidingVicinityBonus)
			{
				tile.spawnDetail(this.m.HidingBack);
				tile.spawnDetail(this.m.HidingFront);

				if (this.Math.rand(1, 100) < this.m.ChanceToSpawnHidingExtra)
				{
					tile.spawnDetail(this.m.HidingExtras[this.Math.rand(0, this.m.HidingExtras.len() - 1)]);
				}

				tile.IsHidingEntity = true;
			}
			else
			{
				local details = this.Math.rand(1, 100) < 45 ? this.m.DetailsA : this.m.DetailsB;
				local decalSpawned = false;

				if (this.Math.rand(1, 100) < this.m.ChanceToSpawnShadow)
				{
					tile.spawnDetail(this.m.Shadows[this.Math.rand(0, this.m.Shadows.len() - 1)]);
				}

				while (this.Math.rand(1, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails)
				{
					tile.spawnDetail(details[this.Math.rand(0, details.len() - 1)]);
					decalSpawned = true;
				}

				if (decalSpawned && this.Math.rand(1, 100) < this.m.ChanceToSpawnBugs)
				{
					for( local i = 0; i < this.m.Bugs.len(); i = ++i )
					{
						tile.spawnDetail(this.m.Bugs[i]);
					}
				}

				if (this.Math.rand(1, 100) < this.m.ChanceToSpawnLightshaft)
				{
					tile.spawnDetail(this.m.Lightshaft);
				}
			}

			if (this.Math.rand(1, 100) < this.m.ChanceToSpawnLightshaft)
			{
				tile.spawnDetail(this.m.Lightshaft);
			}
		}
	}
});
