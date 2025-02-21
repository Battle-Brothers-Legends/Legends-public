this.legends_farming_village <- this.inherit("scripts/entity/world/settlements/legends_village", {
	m = {},
	function create()
	{
		this.legends_village.create();
		this.m.Names = [[
			"Weidefeld",
			"Hemmeln",
			"Saxdorf",
			"Kochendorf",
			"Altenhof",
			"Weidenau",
			"Schnellen",
			"Neudorf",
			"Freidorf",
			"Weissenhaus",
			"Muhlenheim",
			"Grunfelde",
			"Ivendorf",
			"Ohnemenschen",
			"Kornstadt",
			"Ausbeute",
			"Feldgehen",
			"Tierbauernhof",
			"Grafenheide",
			"Hermannshof",
			"Koppeldorf",
			"Meiding",
			"Varel",
			"Durbach",
			"Dreifelden",
			"Bockhorn",
			"Hufschlag",
			"Hage",
			"Wagenheim",
			"Harlingen",
			"Wiese",
			"Wiesendorf",
			"Markdorf",
			"Heuweiler",
			"Bitterfeld",
			"Neuenried",
			"Auenbach",
			"Adelshofen",
			"Allersdorf",
			"Brunnendorf",
			"Ochsenhausen",
			"Weingarten",
			"Konigsfeld",
			"Rosenhof",
			"Weidenbach"
		],[
			"Weidefeld",
			"Hemmeln",
			"Saxdorf",
			"Kochendorf",
			"Altenhof",
			"Schnellen",
			"Neudorf",
			"Freidorf",
			"Durbach",
			"Weissenhaus",
			"Muhlenheim",
			"Grunfelde",
			"Ivendorf",
			"Weidenau",
			"Grafenheide",
			"Hermannshof",
			"Koppeldorf",
			"Meiding",
			"Varel",
			"Dreifelden",
			"Bockhorn",
			"Hufschlag",
			"Hage",
			"Wagenheim",
			"Harlingen",
			"Wiese",
			"Wiesendorf",
			"Markdorf",
			"Heuweiler",
			"Bitterfeld"
		],[
			"Weidemark",
			"Hemmelmark",
			"Kochenland",
			"Altenstadt",
			"Schnellmark",
			"Neumark",
			"Freistadt",
			"Weissenstadt",
			"Muhlstadt",
			"Grunmark",
			"Ivenstadt",
			"Grafenstadt",
			"Konigsland",
			"Dreigrafen",
			"Koppelstadt",
			"Varelmark",
			"Hageland",
			"Dulmen",
			"Wiesenmark",
			"Heuland",
			"Auenmark",
			"Kornstadt",
			"Konigsheim",
			"Wedelmark",
			"Albstadt",
			"Kammersmark",
			"Adelsland",
			"Heldenland",
			"Dinkelsmark",
			"Schwanstadt",
			"Grunhain"
		]];
		this.m.DraftLists = [[
			"beggar_background",
			"daytaler_background",
			"daytaler_background",
			"farmhand_background",
			"farmhand_background",
			"farmhand_background",
			"farmhand_background",
			"miller_background",
			"miller_background",
			"ratcatcher_background",
			"tailor_background",
			"vagabond_background",
			"poacher_background",
			"ratcatcher_background",
			"vagabond_background",
			"poacher_background"
		],[
			"apprentice_background",
			"beggar_background",
			"butcher_background",
			"gambler_background",
			"daytaler_background",
			"daytaler_background",
			"farmhand_background",
			"farmhand_background",
			"farmhand_background",
			"juggler_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"miller_background",
			"miller_background",
			"minstrel_background",
			"ratcatcher_background",
			"refugee_background",
			"servant_background",
			"tailor_background",
			"vagabond_background",
			"retired_soldier_background",
			"apprentice_background",
			"butcher_background",
			"gambler_background",
			"juggler_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"minstrel_background",
			"ratcatcher_background",
			"refugee_background",
			"vagabond_background",
			"retired_soldier_background"
		],[
			"swordmaster_background",
			"apprentice_background",
			"caravan_hand_background",
			"gambler_background",
			"historian_background",
			"juggler_background",
			"militia_background",
			"militia_background",
			"minstrel_background",
			"minstrel_background",
			"peddler_background",
			"ratcatcher_background",
			"refugee_background",
			"shepherd_background",
			"vagabond_background",
			"bastard_background",
			"hedge_knight_background",
			"raider_background",
			"retired_soldier_background",
			"sellsword_background",
			"squire_background",
			"swordmaster_background",
			"legend_inventor_background"
		]];

		this.m.StablesLists = [[
			"legend_donkey_background",
			"legend_donkey_background",
		],[
			"legend_donkey_background",
			"legend_donkey_background",
			"legend_horse_rouncey"
		],[
			"legend_donkey_background",
			"legend_donkey_background",
			"legend_horse_rouncey"
		]];
		this.m.Rumors = this.Const.Strings.RumorsFarmingSettlement;
	}


	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small farming village living mostly off of the surrounding fertile lands.";
			case 2:
				return "A prospering village surrounded by fertile land. The market is usually filled with all kinds of fresh food.";
			case 3:
				return "A large city surrounded by lush green meadows, orchards and fields. Food stocks are usually filled to the brim.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small farming village living mostly off of the surrounding fertile lands";
			case 2:
				return "A prospering village surrounded by fertile land";
			case 3:
				return "A large city thriving on trade and agriculture";
			default:
				return null;
		}
	}

	function getHousesMin()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return 1;
			case 2:
				return 2;
			case 3:
				return 4;
			default:
				return 1;
		}
	}

	function getHousesMax()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return 2;
			case 2:
				return 3;
			case 3:
				return 6;
			default:
				return 1;
		}
	}

	function getAttachedLocationsMax()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return 3;
			case 2:
				return 4;
			case 3:
				return 7;
			default:
				return 1;
		}
	}

	function buildNewLocation()
	{
		local ALL = [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.SnowyForest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest
		];
		local items = [

			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/wheat_fields_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/orchard_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/herbalists_grove_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/brewery_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/wool_spinner_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}]

		];

		switch (this.m.Size)
		{
			case 1:
				items.extend([]);
				break;
			case 2:
				items.extend([

			[1, {
				Script = "scripts/entity/world/attached_location/wooden_watchtower_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 4,
				Road = true,
				Clear = true,
				Force = true
			}],

				]);
				break;
			case 3:
				items.extend([
			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/wooden_watchtower_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 4,
				Road = true,
				Clear = true,
				Force = true
			}],
			[1, {Num = 1,
				Script = "scripts/entity/world/attached_location/militia_trainingcamp_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = true,
				Clear = true,
				Force = true
			}],
				]);
				break;
		}

		items = this.filterNewLocation(items);
		local item = this.Const.World.Common.pickItem(items);
		return this.buildAttachedLocation(1, item.Script, item.Terrain, item.NearTerrain, item.Distance, item.Road, item.Clear, item.Force)
	}

	function onBuildOne( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			this.Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
			this.Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Plains
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 2, true);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = this.Math.rand(1, 3);

		if (r == 1 || this.Const.World.Buildings.Blackmarket == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wool_spinner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			this.Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
			this.Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Plains
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 3, true);
	}

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));

		if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else if (this.Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wool_spinner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1, true);
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wooden_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			this.Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 2), "scripts/entity/world/attached_location/orchard_location", [
			this.Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 2);
	}

});

