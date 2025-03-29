this.tactical_legend_tournament_floor <- this.inherit("scripts/mapgen/tactical_template", {
	m = {
		Details = [
			"arrow_missed_01",
			"arrow_missed_02",
			"arrow_missed_03",
			"arrow_missed_04",
			"arrow_missed_05",
			"arrow_missed_06",
			"arrow_missed_07",
			"arrow_missed_08",
			"blood_red_01",
			"blood_red_02",
			"blood_red_03",
			"blood_red_04",
			"blood_red_05",
			"blood_red_06",
			"blood_red_07",
			"blood_red_08",
			"blood_red_09",
			"blood_red_10",
			"blood_red_01",
			"blood_red_02",
			"blood_red_03",
			"blood_red_04",
			"blood_red_05",
			"blood_red_06",
			"blood_red_07",
			"blood_red_08",
			"blood_red_09",
			"blood_red_10",
			"corpse_part_01",
			"corpse_part_02",
			"corpse_part_03",
			"corpse_part_04",
			"corpse_part_05",
			"steppe_grass_detail_01",
			"steppe_grass_detail_02",
			"steppe_grass_detail_03",
			"steppe_grass_detail_04",
			"steppe_grass_detail_05",
			"steppe_stone_detail_01",
			"steppe_stone_detail_02",
			"steppe_stone_detail_03",
			"steppe_stone_detail_04",
			"steppe_stone_detail_05",
			"steppe_stone_detail_06",
			"steppe_stone_detail_07",
			"steppe_stone_detail_08",
			"steppe_stone_detail_09",
			"steppe_stone_detail_10",
			"steppe_stone_detail_11",
			"detail_grass_0",
			"detail_grass_1",
			"detail_grass_2",
			"detail_grass_3"
		]
	},
	function init()
	{
		this.m.Name = "tactical.legend_tournament_floor";
		this.m.MinX = 26;
		this.m.MinY = 26;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				if (x > _rect.X + 1 && x < _rect.X + _rect.W - 2 && y > _rect.Y + 1 && y < _rect.Y + _rect.H - 2)
				{
					if (this.Math.rand(1, 100) <= 3)
					{
						local tile = this.Tactical.getTileSquare(x, y);
						tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
					}
				}
				else if (this.Math.rand(1, 100) <= 66)
				{
					// local tile = this.Tactical.getTileSquare(x, y);
					// local o = tile.spawnObject("entity/tactical/objects/legend_tournament_spectator");
					
				// causes endless error on loading a battle: the index setFlipped does not exist 
				//	if (tile.Coords.X > (_rect.X + _rect.W) / 2)
				//	{
				//		o.setFlipped(true);
				//	}
				
				}
			}
		}
	}

});

