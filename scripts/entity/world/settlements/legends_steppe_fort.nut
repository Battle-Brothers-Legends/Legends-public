this.legends_steppe_fort <- this.inherit("scripts/entity/world/settlements/legends_fort", {
	m = {},
	function create()
	{
		this.legends_fort.create();
		this.m.Names = [[
			"Wohlenwacht",
			"Krauchwall",
			"Erlachwall",
			"Treitenwacht",
			"Thurnwall",
			"Rothenwall",
			"Sandwacht",
			"Sonnwehr",
			"Siegwacht",
			"Schanzthal",
			"Sudschanze",
			"Strauchwacht",
			"Kargwall",
			"Dornwall",
			"Dornturm",
			"Gelbwall",
			"Suderwacht",
			"Dorngard",
			"Dornwacht",
			"Weissenwacht",
			"Goldwall",
			"Wurmwacht",
			"Brunnwall",
			"Unterwall",
			"Brackenwacht",
			"Steppwall"
		],[
			"Wohlenburg",
			"Krauchburg",
			"Erlachburg",
			"Treitenburg",
			"Thunburg",
			"Rothburg",
			"Sonnenburg",
			"Siegburg",
			"Sudburg",
			"Strauchburg",
			"Maderburg",
			"Kargburg",
			"Dornburg",
			"Gelbburg",
			"Suderburg",
			"Lichtburg",
			"Hellenburg",
			"Glanzburg",
			"Strahlenburg",
			"Trockenburg",
			"Schattenburg",
			"Schimmerburg",
			"Splitterburg",
			"Staubburg",
			"Lehmburg",
			"Wustenburg"
		],[
			"Wohlenfeste",
			"Krauchfeste",
			"Erlachfeste",
			"Treitenfeste",
			"Thunfeste",
			"Rothenfeste",
			"Sonnenfeste",
			"Siegfeste",
			"Sudfeste",
			"Suderfeste",
			"Strauchfeste",
			"Maderfeste",
			"Kargfeste",
			"Dornenfeste",
			"Gelbfeste",
			"Lichtfeste",
			"Hellenfeste",
			"Glanzfeste",
			"Strahlfeste",
			"Konigsfeste",
			"Knochenfeste",
			"Durrfeste",
			"Sandsturmfeste",
			"Gelbfelsfeste",
			"Rothsteinfeste",
			"Goldfeste",
			"Scharfzahnfeste",
			"Brandfeste",
			"Staubfeste",
			"Odfeste",
			"Habichtfeste"
		]];
		this.m.DraftLists = [ [
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.Houndmaster,
			::Legends.Background.Daytaler,
			::Legends.Background.Mason,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Shepherd,
			::Legends.Background.Vagabond,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.Houndmaster,
			::Legends.Background.Mason,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Shepherd,
			::Legends.Background.Vagabond,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.Hunter,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Servant,
			::Legends.Background.Vagabond,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword,
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.Hunter,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Vagabond,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Beggar,
			::Legends.Background.Bowyer,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.Juggler,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Servant,
			::Legends.Background.Tailor,
			::Legends.Background.Vagabond,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword,
			::Legends.Background.Sellsword,
			::Legends.Background.Sellsword,
			::Legends.Background.Swordmaster,
			::Legends.Background.HedgeKnight,
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.Juggler,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Vagabond,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Sellsword,
			::Legends.Background.Sellsword,
			::Legends.Background.Sellsword,
			::Legends.Background.Swordmaster,
			::Legends.Background.HedgeKnight
		]];
		this.m.StablesLists = [[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendHorseRouncey,
			::Legends.Background.LegendHorseDestrier
		],[
			::Legends.Background.LegendHorseDestrier,
			::Legends.Background.LegendHorseCourser,
			::Legends.Background.LegendHorseDestrier,
			::Legends.Background.LegendHorseCourser
		]];

		this.m.Rumors = this.Const.Strings.RumorsSteppeSettlement;
	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "This small wooden keep looks wide over the dry steppe and offers shade for weary soldiers.";
			case 2:
				return "This stone keep is a strongpoint in the area and grants a good view of the surrounding flat and dry lands.";
			case 3:
				return "This mighty citadel towers high above the surrounding steppe and is the seat of power in the region. It houses a large garrison and offers all kinds of services valuable to travellers and mercenaries.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small wooden keep in the dry steppe";
			case 2:
				return "A stone keep projecting power over the flat steppe";
			case 3:
				return "A mighty citadel towering above the surrounding steppe";
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
				Script = "scripts/entity/world/attached_location/leather_tanner_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

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
				Script = "scripts/entity/world/attached_location/goat_herd_location",
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
				Script = "scripts/entity/world/attached_location/gatherers_hut_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/beekeeper_location",
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
				Script = "scripts/entity/world/attached_location/beekeeper_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],
			[1, {
				Script = "scripts/entity/world/attached_location/goat_herd_location",
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

		if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

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

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/beekeeper_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/beekeeper_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
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
		], 4, true);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		local r = this.Math.rand(1, 4);

		if (r == 1 || this.Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (r == 2 || this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (r == 3 || this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else if (r == 4)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			]);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [
				this.Const.World.TerrainType.Tundra
			]);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [
				this.Const.World.TerrainType.Tundra
			]);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
	}

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
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
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 0, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", ALL, [], 0, false, true, true);
			return;
		}


		if (this.Math.rand(1, 100) <= 50 || this.Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 5, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills
			], [], 1, true);
		}
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills
		], []);
	}

});

