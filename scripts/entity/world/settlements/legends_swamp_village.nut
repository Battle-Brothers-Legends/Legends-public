this.legends_swamp_village <- this.inherit("scripts/entity/world/settlements/legends_village", {
	m = {},
	function create()
	{
		this.legends_village.create();
		this.m.Names = [[
			"Stakendorf",
			"Schwartbuck",
			"Monkamp",
			"Sehlendorf",
			"Schwarzpfuhl",
			"Ehlerstorf",
			"Torfbruck",
			"Mohrdorf",
			"Streekmoor",
			"Kolkdorf",
			"Schwarzwasser",
			"Lauenbruck",
			"Farnheim",
			"Birkhain",
			"Rankestadt",
			"Trubewasser",
			"Sumpfschritt",
			"Verschwunden",
			"Ahlen",
			"Suderbusch",
			"Altenfurth",
			"Breitenbrunn",
			"Grunbach",
			"Grunwasser",
			"Schmalfurth",
			"Grossfurth",
			"Grunkraut",
			"Schattenfluth",
			"Weissenbach",
			"Kaltenbach",
			"Tarsdorf",
			"Tiefenbach",
			"Julbach",
			"Auengrund",
			"Schwarzbrook",
			"Brookdorf",
			"Brookheim"
		],[
			"Stakendorf",
			"Schwartbuck",
			"Monkamp",
			"Sehlendorf",
			"Schwarzpfuhl",
			"Ehlerstorf",
			"Torfbruck",
			"Mohrdorf",
			"Streekmoor",
			"Kolkdorf",
			"Schwarzwasser",
			"Lauenbruck",
			"Farnheim",
			"Birkhain",
			"Ahlen",
			"Suderbusch",
			"Altenfurth",
			"Breitenbrunn",
			"Grunbach",
			"Grunwasser",
			"Schmalfurth",
			"Grossfurth",
			"Grunkraut",
			"Schattenfluth",
			"Weissenbach",
			"Kaltenbach",
			"Tarsdorf",
			"Tiefenbach",
			"Julbach",
			"Auengrund",
			"Schwarzbrook",
			"Brookdorf",
			"Brookheim"
		],[
			"Stakenland",
			"Sehlenstadt",
			"Schwarzland",
			"Ehelerstadt",
			"Streekland",
			"Grafenwasser",
			"Lauenstadt",
			"Ahlenstadt",
			"Grunstadt",
			"Austadt",
			"Muckenland",
			"Brookstadt",
			"Pfuhlstadt",
			"Schwarzmark",
			"Muckenmark",
			"Torfmark",
			"Fuhrtmark",
			"Schwartmark",
			"Tiefenmark",
			"Schwanenwasser",
			"Fletland",
			"Fennstedt",
			"Auenhausen",
			"Moorland",
			"Riedland",
			"Drakenstadt",
			"Schwarmstadt",
			"Niedermark"
		]];
		this.m.DraftLists = [[
			::Legends.Background.Beggar,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter
		],[
			::Legends.Background.Beggar,
			::Legends.Background.Beggar,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Flagellant,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.DisownedNoble,
			::Legends.Background.Cripple,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Flagellant,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.Cripple
		],[
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Flagellant,
			::Legends.Background.Flagellant,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.Juggler,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Minstrel,
			::Legends.Background.Monk,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.Bastard,
			::Legends.Background.HedgeKnight,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword,
			::Legends.Background.Swordmaster,
			::Legends.Background.Cripple,
			::Legends.Background.Eunuch,
			::Legends.Background.LegendInventor
		]];

		this.m.StablesLists = [[],[],[]];

		if (this.Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[1].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
		}

		this.m.Rumors = this.Const.Strings.RumorsSwampSettlement;
		this.m.ProduceString = "mushrooms";
	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small settlement in a swampy area. The people living here sure know hardship.";
			case 2:
				return "A somewhat larger settlement spread out across various dry and firm spots in the swamp.";
			case 3:
				return "A collection of many smaller settlements spread out over dry spots in the swampy area to form one modestly sized city.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small and crude settlement in a swampy area";
			case 2:
				return "A larger settlement surrounded by foul swamps";
			case 3:
				return "A modest city spread out over dry spots in the swampy area";
			default:
				return null;
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


			[1, {
				Script = "scripts/entity/world/attached_location/herbalists_grove_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/pig_farm_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/peat_pit_location",
				Terrain = [this.Const.World.TerrainType.Swamp],
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/mushroom_grove_location",
				Terrain = [this.Const.World.TerrainType.Swamp],
				NearTerrain = [],
				Distance = 2,
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
			[1, {
				Script = "scripts/entity/world/attached_location/militia_trainingcamp_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = true,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/wooden_watchtower_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 4,
				Road = true,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/workshop_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
				Road = false,
				Clear = true,
				Force = true
			}],
				]);
				break;
		}

		items = this.filterNewLocation(items);
		local item = this.Const.World.Common.pickItem(items);
		return this.buildAttachedLocation(1, item.Script, item.Terrain, item.NearTerrain, item.Distance, item.Road, item.Clear, item.Force);
	}

	function onBuildOne( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Const.DLC.Unhold && (this.Const.World.Buildings.Taxidermists == 0 || this.Math.rand(1, 100) <= 33))
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (this.Math.rand(1, 100) <= 33)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], []);
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

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Const.DLC.Unhold)
		{
			local r = this.Math.rand(1, 3);

			if (r == 1 || this.Const.World.Buildings.Taxidermists == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
		}
		else
		{
			local r = this.Math.rand(1, 3);

			if (r <= 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}
		else
		{
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			this.Const.World.TerrainType.Swamp
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], 3, true);
	}

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Const.DLC.Unhold)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (this.Math.rand(1, 100) <= 80 || this.Const.World.Buildings.Blackmarket == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}
		else
		{
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}

		if (this.Math.rand(1, 100) <= 60)
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

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], []);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			this.Const.World.TerrainType.Swamp
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
	}

});

