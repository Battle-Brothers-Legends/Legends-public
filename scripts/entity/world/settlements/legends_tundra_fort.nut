this.legends_tundra_fort <- this.inherit("scripts/entity/world/settlements/legends_fort", {
	m = {},
	function create()
	{
		this.legends_fort.create();
		this.m.Names = [[
			"Tonderwold",
			"Hornwold",
			"Grimtorn",
			"Helleweir",
			"Kalkweir",
			"Lyderswold",
			"Hornspira",
			"Sommerspira",
			"Brammingwold",
			"Vardegard",
			"Norrewold",
			"Birketorn",
			"Donnerswold",
			"Tangweir",
			"Helviktorn",
			"Torvastorn",
			"Skjoldwold",
			"Eidsviktorn",
			"Halspira",
			"Gerwold",
			"Gunnspira",
			"Asentorn",
			"Hammarwold",
			"Holmwold",
			"Eidarswold",
			"Skallewold",
			"Knorrespira",
			"Linderstorn",
			"Neidspira",
			"Bredaswold"
		],[
			"Tonderhovel",
			"Horngard",
			"Grimhaug",
			"Hellehovel",
			"Kalkhovel",
			"Lydersgard",
			"Homsgard",
			"Sommersholm",
			"Brammingholm",
			"Vardegard",
			"Norreholm",
			"Birkehovel",
			"Donnersgard",
			"Tanghaug",
			"Helvikholm",
			"Torvaholm",
			"Skjoldgard",
			"Eidsvikholm",
			"Halshovel",
			"Gerholm",
			"Gunnholm",
			"Asengard",
			"Hammargard",
			"Vikeholm",
			"Skandergard",
			"Skallegard",
			"Varehaug",
			"Gufirsgard",
			"Hafnarsholm",
			"Ragnhaug",
			"Torgeirsholm",
			"Heersgard",
			"Holmhaug",
			"Lundirsholm"
		],[
			"Tonderborg",
			"Hornborg",
			"Grimborg",
			"Helleborg",
			"Kalkborg",
			"Lydersborg",
			"Homsborg",
			"Sommersborg",
			"Brammingborg",
			"Vardeborg",
			"Norreborg",
			"Birkeborg",
			"Donnersborg",
			"Tangborg",
			"Helvikborg",
			"Torvaborg",
			"Skjoldborg",
			"Eidsvikborg",
			"Halsborg",
			"Gerborg",
			"Gunnborg",
			"Asenborg",
			"Hammarborg",
			"Skagaborg",
			"Selasborg",
			"Haellborg",
			"Kampaborg",
			"Gufarsborg",
			"Husnarborg",
			"Reistarborg",
			"Geirborg"
		]];
		this.m.DraftLists = [[
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Miner,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier
		],[
			::Legends.Background.Houndmaster,
			::Legends.Background.Brawler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Gambler,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Peddler,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Shepherd,
			::Legends.Background.Shepherd,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword,
			::Legends.Background.Sellsword,
			::Legends.Background.Squire,
			::Legends.Background.Swordmaster,
			::Legends.Background.Cripple,
			::Legends.Background.Eunuch,
			::Legends.Background.HedgeKnight,
			::Legends.Background.HedgeKnight
		]];

		this.m.FemaleDraftLists = [[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
		],[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.Witchhunter,
		],[
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.Witchhunter,
		]];

		this.m.StablesLists = [[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey,
			::Legends.Background.LegendHorseDestrier
		]];
		this.m.Culture = ::Const.World.Culture.Northern;
		this.m.Rumors = ::Const.Strings.RumorsTundraSettlement;
	}


	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "In the flat lands of the tundra, this small fortification can be spotted from quite a distance.";
			case 2:
				return "A stone keep that is the seat of power in the surrounding tundra. It acts as a base of operations for a decently sized garrison.";
			case 3:
				return "A large citadel towering high over the surrounding tundra and securing the large and open region. Many come here to resupply, make repairs and rest until venturing on.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A wooden motte towering above the tundra";
			case 2:
				return "A stone keep securing the surrounding tundra";
			case 3:
				return "A large citadel towering high over the surrounding tundra";
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
				Script = "scripts/entity/world/attached_location/fletchers_hut_location",
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

		];

		switch (this.m.Size)
		{
			case 1:
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
				Script = "scripts/entity/world/attached_location/leather_tanner_location",
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
			}]

				]);
				break;
			case 2:
				items.extend([

			[1, {
				Script = "scripts/entity/world/attached_location/stone_watchtower_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 5,
				Road = true,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/fortified_outpost_location",
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

			[1, {
				Script = "scripts/entity/world/attached_location/workshop_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {
				Script = "scripts/entity/world/attached_location/brewery_location",
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

				]);
				break;
			case 3:
				items.extend([

			[1, {
				Script = "scripts/entity/world/attached_location/stone_watchtower_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 5,
				Road = true,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/fortified_outpost_location",
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

			[1, {
				Script = "scripts/entity/world/attached_location/workshop_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {
				Script = "scripts/entity/world/attached_location/brewery_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
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

		if (!::Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else
		{
			local r = ::Math.rand(1, 4);

			if (r == 1)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [
			::Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], 4, true);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));

		if (::Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else
		{
			local r = ::Math.rand(1, 4);

			if (r <= 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [
				::Const.World.TerrainType.Tundra
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [
				::Const.World.TerrainType.Tundra
			], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 1, true);
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

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
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
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);

			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", ALL, [], 0, false, true, true);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 30)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [
			::Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(::Math.rand(1, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], []);
	}

});

