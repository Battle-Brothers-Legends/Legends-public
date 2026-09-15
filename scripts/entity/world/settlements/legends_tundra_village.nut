this.legends_tundra_village <- this.inherit("scripts/entity/world/settlements/legends_village", {
	m = {},
	function create()
	{
		this.legends_village.create();
		this.m.Names = [[
			"Tonder",
			"Lydersholm",
			"Kravlund",
			"Bola",
			"Ravestad",
			"Plyndring",
			"Koldjord",
			"Naturlegeme",
			"Klogflygte",
			"Alsliv",
			"Hellevad",
			"Heimstad",
			"Hornheim",
			"Jerstal",
			"Hejsager",
			"Kalk",
			"Sommerstad",
			"Horn",
			"Bramming",
			"Varde",
			"Norre",
			"Vistadt",
			"Olbing",
			"Grimstad",
			"Birkeland",
			"Donnerstad",
			"Tangvall",
			"Helvik",
			"Ogna",
			"Norheim",
			"Undheim",
			"Torvastad",
			"Skjold",
			"Eidsvik",
			"Halheim",
			"Gerheim",
			"Asenstad",
			"Gunnheim",
			"Hammar",
			"Bullarsby",
			"Lonneberg",
			"Kallesheim"
		],[
			"Tonder",
			"Lydersholm",
			"Kravlund",
			"Bola",
			"Ravestad",
			"Alsliv",
			"Hellevad",
			"Heimstad",
			"Hornheim",
			"Jerstal",
			"Hejsager",
			"Kalk",
			"Sommerstad",
			"Horn",
			"Bramming",
			"Varde",
			"Norre",
			"Vistadt",
			"Olbing",
			"Grimstad",
			"Birkeland",
			"Donnerstad",
			"Tangvall",
			"Helvik",
			"Ogna",
			"Norheim",
			"Undheim",
			"Torvastad",
			"Skjold",
			"Eidsvik",
			"Halheim",
			"Gerheim",
			"Asenstad",
			"Gunnheim",
			"Hammar"
		],[
			"Tondersted",
			"Jarlsted",
			"Lydersted",
			"Bolasted",
			"Ravested",
			"Hellested",
			"Hornsted",
			"Hejsted",
			"Sommersted",
			"Brammingsted",
			"Vardested",
			"Norrested",
			"Grimsted",
			"Ognasted",
			"Eidsted",
			"Gersted",
			"Asested",
			"Gunnsted",
			"Hammarsted",
			"Einarsted",
			"Skallested",
			"Halfdansted",
			"Ratarsted",
			"Lugnisted",
			"Leifsted",
			"Lorrested"
		]];
		this.m.DraftLists = [[
			::Legends.Background.Brawler,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Farmhand,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Shepherd,
			::Legends.Background.Tailor,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Brawler,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Shepherd,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman
		],[
			::Legends.Background.Beggar,
			::Legends.Background.Bowyer,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Butcher,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Hunter,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Minstrel,
			::Legends.Background.Monk,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Tailor,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Hunter,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman
		],[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
::Legends.Background.LegendShieldmaiden,
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Hunter,
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
			::Legends.Background.Shepherd,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Bastard,
			::Legends.Background.Raider,
			::Legends.Background.Sellsword,
			::Legends.Background.Swordmaster,
			::Legends.Background.LegendInventor
		]];

		this.m.FemaleDraftLists = [[
			// nothing at lvl 1
		],[
			// nothing at lvl 2
		],[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
::Legends.Background.LegendShieldmaiden,
		]];
		this.m.StablesLists = [[],[],[]];
		this.m.Culture = ::Const.World.Culture.Northern;
		this.m.Rumors = ::Const.Strings.RumorsTundraSettlement;
		this.m.ProduceString = "pelts";
	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A humble village that managed to survive in the sparse tundra.";
			case 2:
				return "An established village in the rough tundra that is a meeting point for the area.";
			case 3:
				return "Surrounded by barren tundra, this large city has lasted as an important trading hub and home to thinkers and fine arts.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A humble village that managed to survive in the sparse tundra";
			case 2:
				return "An established village in the rough tundra";
			case 3:
				return "A large city and trading hub surrounded by barren tundra";
			default:
				return null;
		}
	}

	function buildNewLocation()
	{
		local ALL = [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		];
		local items = [

			[1, {
				Script = "scripts/entity/world/attached_location/trapper_location",
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
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/surface_iron_vein_location",
				Terrain = ALL
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/gatherers_hut_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
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
			}],

		];

		switch (this.m.Size)
		{
			case 1:
				items.extend([]);
				break;
			case 2:
				items.extend([
			[1, {
				Script = "scripts/entity/world/attached_location/leather_tanner_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}]
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
				Script = "scripts/entity/world/attached_location/ore_smelters_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/blast_furnace_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
				Road = false,
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
		local item = ::Const.World.Common.pickItem(items);
		return this.buildAttachedLocation(1, item.Script, item.Terrain, item.NearTerrain, item.Distance, item.Road, item.Clear, item.Force);
	}

	function onBuildOne( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (::Math.rand(1, 100) <= 40)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}
		else if (::Const.DLC.Unhold && (::Const.World.Buildings.Taxidermists == 0 || ::Math.rand(1, 100)))
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (::Math.rand(1, 100) <= 20)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Snow
			], [
				::Const.World.TerrainType.Tundra
			]);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/trapper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Snow
			], [
				::Const.World.TerrainType.Tundra
			]);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 2);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Const.DLC.Unhold)
		{
			local r = ::Math.rand(1, 4);

			if (r == 1 || ::Const.World.Buildings.Taxidermists == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
		}
		else
		{
			local r = ::Math.rand(1, 4);

			if (r <= 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/trapper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Snow
			], [
				::Const.World.TerrainType.Tundra
			], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/peat_pit_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Snow
			], [
				::Const.World.TerrainType.Tundra
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/peat_pit_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Const.DLC.Unhold && ::Const.World.Buildings.Taxidermists == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (::Math.rand(1, 100) <= 75)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/trapper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Snow
			], [
				::Const.World.TerrainType.Tundra
			], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/peat_pit_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Snow
			], [
				::Const.World.TerrainType.Tundra
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/peat_pit_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
		}

		if (::Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wooden_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
	}

});

