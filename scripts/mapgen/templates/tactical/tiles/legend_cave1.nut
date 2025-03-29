this.legend_cave1 <- this.inherit("scripts/mapgen/tactical_template", {
	m = {
		Details = [
			"autumn_moss_01",
			"autumn_moss_01",
			"autumn_moss_02",
			"autumn_moss_02",
			"autumn_moss_03",
			"autumn_moss_03",
			"rocks_01",
			"rocks_02",
			"rocks_03",
			"rocks_04",
			"rocks_05",
			"rocks_06"
		],
		DetailsStones = [
			"detail_stone_01",
			"detail_stone_02",
			"detail_stone_03",
			"detail_stone_04",
			"detail_mushrooms_1",
			"detail_mushrooms_2",
			"detail_mushrooms_3",
			"autumn_moss_01",
			"autumn_moss_02",
			"autumn_moss_03",
			"rocks_01",
			"rocks_02",
			"rocks_03",
			"rocks_04",
			"rocks_05",
			"rocks_06"
		],
		ChanceToSpawnDetails = 35,
		LimitOfSpawnedDetails = 4,
		Objects = [
			"entity/tactical/objects/tundra_boulder1",
			"entity/tactical/objects/autumn_boulder1",
			"entity/tactical/objects/autumn_boulder2"
		],
		ChanceToSpawnObject = 8
	},
	function init()
	{
		this.m.Name = "tactical.tile.legend_cave1";
		this.m.MinX = 1;
		this.m.MinY = 1;
	}

	function onFirstPass( _rect )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = this.Const.Tactical.TerrainType.FlatGround;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.FlatStone;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Autumn4;
		tile.IsBadTerrain = false;
		tile.setBrush("tile_autumn_04");
		local n = 0;

		if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
		{
			if (!tile.hasNextTile(this.Const.Direction.S) || tile.getNextTile(this.Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (this.Math.rand(1, 100) <= this.m.ChanceToSpawnDetails)
		{
			if (this.Math.rand(1, 100) <= 20)
			{
				tile.spawnDetail(this.m.DetailsStones[this.Math.rand(0, this.m.DetailsStones.len() - 1)]);
			}
			else if (this.Math.rand(1, 100) <= 50)
			{
				tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
			}
			else
			{
				for( local n = 0; this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails && n++ < this.m.LimitOfSpawnedDetails;  )
				{
					local i = this.Math.rand(0, this.m.Details.len() - 1);
					tile.spawnDetail(this.m.Details[i]);
				}
			}
		}
	}

});

