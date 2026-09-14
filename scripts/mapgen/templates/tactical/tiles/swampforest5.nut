this.swampforest5 <- this.inherit("scripts/mapgen/tactical_template", {
	m = {
		Details = [
			"swamp_schilf_01",
			"swamp_schilf_02",
			"swamp_schilf_03",
			"swamp_schilf_04",
			"detail_swamp_01",
			"detail_swamp_02"
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
		ChanceToSpawnDetails = 33,
		ChanceToSpawnHiding = 10,
		ChanceToSpawnHidingExtra = 66,
		ChanceToSpawnHidingVicinityBonus = 20,
		LimitOfSpawnedDetails = 3,
		ChanceToSpawnFog = 42,
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
		ChanceToSpawnObject = 7
	},
	function init()
	{
		this.m.Name = "tactical.tile.swampforest5";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setBlendIntoSockets(false);
		t.setBrush(this.Const.Direction.N, "transition_swamp_05_N");
		t.setBrush(this.Const.Direction.NE, "transition_swamp_05_NE");
		t.setBrush(this.Const.Direction.SE, "transition_swamp_05_SE");
		t.setBrush(this.Const.Direction.S, "transition_swamp_05_S");
		t.setBrush(this.Const.Direction.SW, "transition_swamp_05_SW");
		t.setBrush(this.Const.Direction.NW, "transition_swamp_05_NW");
		t.setSocket("socket_earth");
		this.Tactical.setTransitions("tile_swamp_05", t);
	}

	function onFirstPass( _rect )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = this.Const.Tactical.TerrainType.Swamp;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.MurkyWater;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Swamp5;
		tile.IsBadTerrain = true;
		tile.setBrush("tile_swamp_05");
		local n = 0;

		if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
		{
			tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);
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

			local allowHiding = true;

			if (allowHiding && this.Math.rand(1, 100) < this.m.ChanceToSpawnHiding + h * this.m.ChanceToSpawnHidingVicinityBonus)
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
				while (this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails)
				{
					tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
				}
			}

			if (this.Math.rand(0, 100) < this.m.ChanceToSpawnFog)
			{
				if (this.Math.rand(0, 100) < this.m.ChanceToSpawnFogFiller)
				{
					local detail = tile.spawnDetail(this.m.FogFiller);
					detail.Color = this.m.FogColor;
				}

				if (this.Math.rand(0, 100) < this.m.ChanceToSpawnFogAnimation)
				{
					local detail = tile.spawnDetail(this.m.FogRotator[this.Math.rand(0, this.m.FogRotator.len() - 1)]);
					detail.Color = this.m.FogColor;
				}

				local detail = tile.spawnDetail(this.m.FogCover[this.Math.rand(0, this.m.FogCover.len() - 1)]);
				detail.Color = this.m.FogColor;
			}
		}
	}

	function onSecondPass( _rect )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);
		local h = 0;

		if (tile.IsHidingEntity)
		{
			return;
		}

		if (tile.hasNextTile(this.Const.Direction.SW) && tile.getNextTile(this.Const.Direction.SW).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.NE) && tile.getNextTile(this.Const.Direction.NE).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.NW) && tile.getNextTile(this.Const.Direction.NW).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.SE) && tile.getNextTile(this.Const.Direction.SE).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.N) && tile.getNextTile(this.Const.Direction.N).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.S) && tile.getNextTile(this.Const.Direction.S).IsHidingEntity)
		{
			h = ++h;
		}

		if (h != 0)
		{
			tile.clear();
			local allowHiding = true;

			if (allowHiding && h * this.m.ChanceToSpawnHidingVicinityBonus >= 100)
			{
				tile.spawnDetail(this.m.HidingBack);
				tile.spawnDetail(this.m.HidingFront);
				tile.IsHidingEntity = true;
			}
			else
			{
				local n = this.Math.rand(2, this.Math.min(this.Math.max(2, h), 4));

				for( local hi = 0; hi < n; hi = ++hi )
				{
					tile.spawnDetail(this.m.HidingExtras[this.Math.rand(0, this.m.HidingExtras.len() - 1)]);
				}
			}
		}
	}

});

