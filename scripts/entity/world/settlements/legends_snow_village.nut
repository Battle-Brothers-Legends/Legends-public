this.legends_snow_village <- this.inherit("scripts/entity/world/settlements/legends_village", {
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
			"Gammeljord",
			"Tabtmennesker",
			"Morktoppe",
			"Lysdal",
			"Narredod",
			"Forsvinde",
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
			"Lonneberg"
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
			"Arsasted",
			"Rollarsted",
			"Skagensted",
			"Harkensted",
			"Agersted",
			"Svarrested",
			"Ovarsted"
		]];
		this.m.DraftLists = [[
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Lumberjack,
			::Legends.Background.Mason,
			::Legends.Background.Miner,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			::Legends.Background.Lumberjack,
			::Legends.Background.Mason,
			::Legends.Background.Miner,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Hunter,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Lumberjack,
			::Legends.Background.Militia,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.LegendDisownedNobleRanged,
			::Legends.Background.DisownedNoble,
			::Legends.Background.Cripple,
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Hunter,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Lumberjack,
			::Legends.Background.Militia,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Cripple
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Peddler,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Raider,
			::Legends.Background.Raider,
			::Legends.Background.Sellsword,
			::Legends.Background.Swordmaster,
			::Legends.Background.LegendInventor
		]];
		this.m.FemaleDraftLists = [
		[
			// nothing at lvl 1
		],[
			// nothing at lvl 2
		],[
			::Legends.Background.LegendShieldmaiden
		]];


		this.m.StablesLists = [[],[],[]];

		if (::Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[1].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
		}

		this.m.Culture = ::Const.World.Culture.Northern;
		this.m.Rumors = ::Const.Strings.RumorsSnowSettlement;
	}


	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small group of huts huddled together, defying the harsh snowy winds of the north.";
			case 2:
				return "A medium sized village covered in snow throughout most of the year.";
			case 3:
				return "A large city far up north. Traders, travelers and adventurers come here for shelter from snow and storms.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "Some huts huddled together";
			case 2:
				return "A medium sized village covered in snow throughout most of the year";
			case 3:
				return "A large city sheltering travelers and traders from snow and cold";
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
				Script = "scripts/entity/world/attached_location/hunters_cabin_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

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
				Script = "scripts/entity/world/attached_location/surface_copper_vein_location",
				Terrain = [::Const.World.TerrainType.Hills, ::Const.World.TerrainType.Snow ],
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/leather_tanner_location",
				Terrain = ALL,
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

		if (::Math.rand(1, 100) <= 30)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (::Math.rand(1, 100) <= 30)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 0, false, true);
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
			], [], 0, false, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 0, false, true);
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
			], [], 0, false, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], [
			::Const.World.TerrainType.Snow >= 2
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Tundra
		], 3, true);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 3);

		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], [
			::Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
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

		if (::Math.rand(1, 100) <= 50 || ::Const.World.Buildings.Blackmarket == 0)
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

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wooden_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
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
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Snow
			], [], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Snow
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow
			], [], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Snow
		], [], 1, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Snow
		], [], 1, true);
	}

});

