this.swampforest2 <- this.inherit("scripts/mapgen/tactical_template", {
	m = {
		Details = [
			"swamp_grass_03",
			"swamp_grass_04",
			"swamp_grass_05",
			"detail_swamp_01",
			"detail_swamp_02",
			"detail_mushrooms_01",
			"detail_mushrooms_02",
			"swamp_puddle_02",
			"swamp_puddle_03",
			"swamp_puddle_04",
			"swamp_puddle_05",
			"swamp_puddle_06",
			"swamp_puddle_07",
			"swamp_grass_06",
			"swamp_grass_08"
		],
		DetailsAlt = [
			"swamp_grass_01"
		],
		HidingFront = "hiding_swamp_01_front",
		HidingBack = "hiding_swamp_01_back",
		HidingExtras = [
			"swamp_grass_06",
			"swamp_grass_07",
			"swamp_grass_08",
			"swamp_grass_09",
			"swamp_grass_10",
			"swamp_grass_11",
			"swamp_grass_12"
		],
		ChanceToSpawnDetails = 66,
		ChanceToSpawnHiding = 0,
		ChanceToSpawnHidingExtra = 66,
		ChanceToSpawnHidingVicinityBonus = 20,
		LimitOfSpawnedDetails = 3,
		ChanceToSpawnFog = 21,
		ChanceToSpawnFogAnimation = 75,
		ChanceToSpawnFogFiller = 0,
		FogCover = [
			"fog_detail_01",
			"fog_detail_02"
		],
		FogRotator = [
			"fog_rotator_01",
			"fog_rotator_02",
			"fog_rotator_03",
			"fog_rotator_04"
		],
		FogColor = this.createColor("#8d9271"),
		FogFiller = "fog_detail_03",
		Objects = [
			// "entity/tactical/objects/tree_forest",
			"entity/tactical/objects/tree_needle1",
			"entity/tactical/objects/tree_needle1",
			"entity/tactical/objects/tree_needle2",
			"entity/tactical/objects/tree_needle2",
			"entity/tactical/objects/tree_needle2_smaller",
			"entity/tactical/objects/tree_needle2_smaller",
			"entity/tactical/objects/tree_trunk_forest"
		],
		ChanceToSpawnObject = 30
	},
	function init()
	{
		this.m.Name = "tactical.tile.swampforest2";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setBlendIntoSockets(false);
		t.setBrush(::Const.Direction.N, "transition_swamp_02_N");
		t.setBrush(::Const.Direction.NE, "transition_swamp_02_NE");
		t.setBrush(::Const.Direction.SE, "transition_swamp_02_SE");
		t.setBrush(::Const.Direction.S, "transition_swamp_02_S");
		t.setBrush(::Const.Direction.SW, "transition_swamp_02_SW");
		t.setBrush(::Const.Direction.NW, "transition_swamp_02_NW");
		t.setSocket("socket_earth");
		::Tactical.setTransitions("tile_swamp_02", t);
	}

	function onFirstPass( _rect )
	{
		local tile = ::Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = ::Const.Tactical.TerrainType.RoughGround;
		tile.Subtype = ::Const.Tactical.TerrainSubtype.MoistEarth;
		tile.BlendPriority = ::Const.Tactical.TileBlendPriority.Swamp2;
		tile.IsBadTerrain = false;
		tile.setBrush("tile_swamp_02");
		local n = 0;

		if (::Math.rand(0, 100) < this.m.ChanceToSpawnObject)
		{
			tile.spawnObject(this.m.Objects[::Math.rand(0, this.m.Objects.len() - 1)]);
		}
		else
		{
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

			if (::Math.rand(1, 100) < this.m.ChanceToSpawnHiding + h * this.m.ChanceToSpawnHidingVicinityBonus)
			{
				tile.spawnDetail(this.m.HidingBack);
				tile.spawnDetail(this.m.HidingFront);

				if (::Math.rand(1, 100) < this.m.ChanceToSpawnHidingExtra)
				{
					tile.spawnDetail(this.m.HidingExtras[::Math.rand(0, this.m.HidingExtras.len() - 1)]);
				}

				tile.IsHidingEntity = true;
			}
			else
			{
				while (::Math.rand(0, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails)
				{
					tile.spawnDetail(this.m.Details[::Math.rand(0, this.m.Details.len() - 1)]);
				}
			}

			if (::Math.rand(0, 100) < this.m.ChanceToSpawnFog)
			{
				if (::Math.rand(0, 100) < this.m.ChanceToSpawnFogFiller)
				{
					local detail = tile.spawnDetail(this.m.FogFiller);
					detail.Color = this.m.FogColor;
				}

				if (::Math.rand(0, 100) < this.m.ChanceToSpawnFogAnimation)
				{
					local detail = tile.spawnDetail(this.m.FogRotator[::Math.rand(0, this.m.FogRotator.len() - 1)]);
					detail.Color = this.m.FogColor;
				}

				local detail = tile.spawnDetail(this.m.FogCover[::Math.rand(0, this.m.FogCover.len() - 1)]);
				detail.Color = this.m.FogColor;
			}
		}
	}

	function onSecondPass( _rect )
	{
		local tile = ::Tactical.getTileSquare(_rect.X, _rect.Y);
		local h = 0;

		if (tile.IsHidingEntity)
		{
			return;
		}

		if (tile.hasNextTile(::Const.Direction.SW) && tile.getNextTile(::Const.Direction.SW).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(::Const.Direction.NE) && tile.getNextTile(::Const.Direction.NE).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(::Const.Direction.NW) && tile.getNextTile(::Const.Direction.NW).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(::Const.Direction.SE) && tile.getNextTile(::Const.Direction.SE).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(::Const.Direction.N) && tile.getNextTile(::Const.Direction.N).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(::Const.Direction.S) && tile.getNextTile(::Const.Direction.S).IsHidingEntity)
		{
			h = ++h;
		}

		if (h != 0)
		{
			tile.clear();
			local n = ::Math.rand(2, ::Math.min(::Math.max(2, h), 4));

			for( local hi = 0; hi < n; hi = ++hi )
			{
				tile.spawnDetail(this.m.HidingExtras[::Math.rand(0, this.m.HidingExtras.len() - 1)]);
			}
		}
	}

});

