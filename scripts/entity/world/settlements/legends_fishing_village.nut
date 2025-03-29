this.legends_fishing_village <- this.inherit("scripts/entity/world/settlements/legends_village", {
	m = {},
	function create()
	{
		this.legends_village.create();
		this.m.Names = [[
			"Seedorf",
			"Kielseng",
			"Meierwik",
			"Fischschlachten",
			"Schiffdrucken",
			"Schiffbauen",
			"Nassort",
			"Sanddorf",
			"Sandwik",
			"Holnis",
			"Holmwik",
			"Niewik",
			"Hattlund",
			"Stohl",
			"Strande",
			"Sandkamp",
			"Sandberg",
			"Birkenstrand",
			"Sundheim",
			"Seekamp",
			"Krakendorf",
			"Blankwasser",
			"Harkensee",
			"Otterndorf",
			"Seefeld",
			"Horum",
			"Krumhorn",
			"Gothmund",
			"Angeln",
			"Sandholm",
			"Jadensee",
			"Egernsande",
			"Nebelheim",
			"Sudersande",
			"Grossenkoog",
			"Aalbek",
			"Seedeich"
		],[
			"Seedock",
			"Wikhavn",
			"Sandhoom",
			"Sandkai",
			"Holnishovn",
			"Holmwader",
			"Niewekai",
			"Stohlhoven",
			"Strandekai",
			"Kampwader",
			"Birkhaven",
			"Sundkajung",
			"Seehoben",
			"Krakenwader",
			"Blankhoom",
			"Harkendock",
			"Krumwader",
			"Saltkai",
			"Salthaven",
			"Grotenhoom",
			"Lutendock",
			"Kaiwader",
			"Singhoben",
			"Weissenhaven",
			"Tiefenhaven",
			"Wasserkoog",
			"Osterstrande",
			"Steinhaven",
			"Duhnenhaven",
			"Neudeich",
			"Sandehaven"
		],[
			"Seestadt",
			"Wikstadt",
			"Konigshaven",
			"Grafenhaven",
			"Holnisland",
			"Nieweland",
			"Kampstadt",
			"Krakenland",
			"Blankenstadt",
			"Harkenstadt",
			"Tiefenstadt",
			"Weissenstadt",
			"Kobmanhaven",
			"Grotenhaven",
			"Konigswasser",
			"Konigsmunde",
			"Kronenkoog",
			"Steinkai",
			"Deichstadt"
		]];
		this.m.DraftLists = [[
			"beggar_background",
			"beggar_background",
			"daytaler_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"peddler_background",
			"tailor_background",
			"vagabond_background",
			"vagabond_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"peddler_background",
			"vagabond_background",
			"vagabond_background"
		],[
			"apprentice_background",
			"beggar_background",
			"beggar_background",
			"brawler_background",
			"caravan_hand_background",
			"daytaler_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"graverobber_background",
			"historian_background",
			"juggler_background",
			"killer_on_the_run_background",
			"messenger_background",
			"militia_background",
			"monk_background",
			"peddler_background",
			"flagellant_background",
			"ratcatcher_background",
			"refugee_background",
			"servant_background",
			"tailor_background",
			"thief_background",
			"vagabond_background",
			"cripple_background",
			"eunuch_background",
			"sellsword_background",
			"apprentice_background",
			"brawler_background",
			"caravan_hand_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"graverobber_background",
			"historian_background",
			"juggler_background",
			"killer_on_the_run_background",
			"messenger_background",
			"militia_background",
			"monk_background",
			"peddler_background",
			"flagellant_background",
			"ratcatcher_background",
			"refugee_background",
			"vagabond_background",
			"cripple_background",
			"eunuch_background",
			"sellsword_background"
		],[
			"apprentice_background",
			"brawler_background",
			"caravan_hand_background",
			"caravan_hand_background",
			"gambler_background",
			"cultist_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"graverobber_background",
			"historian_background",
			"juggler_background",
			"killer_on_the_run_background",
			"mason_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"minstrel_background",
			"monk_background",
			"cripple_background",
			"eunuch_background",
			"peddler_background",
			"flagellant_background",
			"ratcatcher_background",
			"refugee_background",
			"vagabond_background",
			"bastard_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background",
			"sellsword_background",
			"swordmaster_background",
			"legend_inventor_background"
		]];

		this.m.StablesLists = [[],[],[]];


		this.m.Rumors = this.Const.Strings.RumorsFishingSettlement;
		this.m.ProduceString = "fish";
	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small fishing village made up of a few humble huts.";
			case 2:
				return "A larger spread out village relying on fishing and a little trade.";
			case 3:
				return "A big harbor city relying on trade and fishing, and an important hub for travellers arriving or leaving by ship.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small fishing village made up of a few humble huts";
			case 2:
				return "A larger spread out village relying on fishing and a little trade";
			case 3:
				return "A large coastal city and trading hub";
			default:
				return null;
		}
	}

	function getUIBackgroundLeft()
	{
		return "ui/settlements/water_01";
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
			 	return 4;
			case 2:
				return 5;
			case 3:
				return 8;
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
			[1, {
				Script = "scripts/entity/world/attached_location/harbor_location",
				Terrain = [this.Const.World.TerrainType.Shore],
				NearTerrain = [this.Const.World.TerrainType.Shore, this.Const.World.TerrainType.Ocean],
				Distance = 1,
				Road = false,
				Clear = false,
				Force = true
			}],
			[1, {
				Script = "scripts/entity/world/attached_location/fishing_huts_location",
				Terrain = ALL,
				NearTerrain = [this.Const.World.TerrainType.Shore],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {
				Script = "scripts/entity/world/attached_location/amber_collector_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 2,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {
				Script = "scripts/entity/world/attached_location/herbalists_grove_location",
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
					[1, {
						Script = "scripts/entity/world/attached_location/workshop_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}]
				]);
				break;
			case 3:
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
						Script = "scripts/entity/world/attached_location/workshop_location",
						Terrain = ALL,
						NearTerrain = [],
						Distance = 0,
						Road = false,
						Clear = true,
						Force = true
					}]
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
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);

		if (this.Math.rand(1, 100) <= 20)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Math.rand(1, 100) <= 66)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1 || this.Const.World.Buildings.Blackmarket == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
			else if (r <= 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		], 1, true);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/amber_collector_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 2);
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
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Math.rand(1, 100) <= 60 || this.Const.World.Buildings.Blackmarket == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
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

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/amber_collector_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Shore
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 3);
	}

});

