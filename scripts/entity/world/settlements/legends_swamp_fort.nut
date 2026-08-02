this.legends_swamp_fort <- this.inherit("scripts/entity/world/settlements/legends_fort", {
	m = {},
	function create()
	{
		this.legends_fort.create();
		this.m.Names = [[
			"Schwarzwacht",
			"Mooswall",
			"Pfuhlwall",
			"Moorwacht",
			"Furthwacht",
			"Stakenwall",
			"Kolkwacht",
			"Auenturm",
			"Torfwall",
			"Pfuhlwacht",
			"Krautwacht",
			"Moorwacht",
			"Birkwall",
			"Birkturm",
			"Brunnwall",
			"Kaltenwacht",
			"Furthwacht",
			"Grunenturm",
			"Suhlwacht",
			"Schwarzgard",
			"Moorgard",
			"Wehrturm",
			"Furthwehr",
			"Schanzmoor",
			"Wallpfuhl",
			"Wallfurt",
			"Auenwacht",
			"Brookwall",
			"Fennwacht",
			"Fackelwacht",
			"Bruchwacht",
			"Riedwehr",
			"Rohrwall",
			"Dusterwall"
		],[
			"Schwarzburg",
			"Moosburg",
			"Pfuhlburg",
			"Moorburg",
			"Furthburg",
			"Stakenburg",
			"Kolkburg",
			"Torfburg",
			"Krautburg",
			"Birkenburg",
			"Brunnburg",
			"Kaltenburg",
			"Grunburg",
			"Suhlburg",
			"Brookburg",
			"Muckenburg",
			"Egelburg",
			"Dunkelburg",
			"Nebelburg",
			"Bruchburg",
			"Morastburg",
			"Froschburg",
			"Schlammburg",
			"Brackenburg",
			"Molchburg",
			"Teichburg",
			"Fennburg",
			"Riedburg",
			"Schlickburg",
			"Senkburg",
			"Rohrburg",
			"Marschburg",
			"Schilfburg"
		],[
			"Schwarzburg",
			"Moosburg",
			"Pfuhlburg",
			"Moorburg",
			"Furthburg",
			"Stakenburg",
			"Kolkburg",
			"Torfburg",
			"Krautburg",
			"Birkenburg",
			"Brunnburg",
			"Kaltenburg",
			"Grunburg",
			"Suhlburg",
			"Brookburg",
			"Muckenburg",
			"Egelburg",
			"Dunkelburg",
			"Nebelburg",
			"Bruchburg",
			"Morastburg",
			"Froschburg",
			"Schlammburg",
			"Brackenburg",
			"Molchburg",
			"Teichburg",
			"Fennburg",
			"Riedburg",
			"Schlickburg",
			"Senkburg",
			"Rohrburg",
			"Marschburg",
			"Schilfburg"
		]];
		this.m.DraftLists = [[
			::Legends.Background.Cultist,
			::Legends.Background.Houndmaster,
			::Legends.Background.Daytaler,
			::Legends.Background.Hunter,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Cultist,
			::Legends.Background.Houndmaster,
			::Legends.Background.Hunter,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Beggar,
			::Legends.Background.Butcher,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.DisownedNoble,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Butcher,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier
		],[
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Beggar,
			::Legends.Background.Butcher,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.DisownedNoble,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Butcher,
			::Legends.Background.Cultist,
			::Legends.Background.Gravedigger,
			::Legends.Background.Hunter,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Raider,
			::Legends.Background.RetiredSoldier
		]];
		this.m.StablesLists = [[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		],[
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		]];

		if (this.Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[1].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
			this.m.DraftLists[2].push(::Legends.Background.BeastSlayer);
		}

		this.m.Rumors = this.Const.Strings.RumorsSwampSettlement;
	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "Placed on a small bit of solid ground, this motte and baily controls the surrounding lands.";
			case 2:
				return "A stone keep controlling routes through and access to the surrounding swamps and marshes.";
			case 3:
				return "A large stone keep that commands a wide view of the surrounding swamps and marshes.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A motte with bailey built on a spot of dry ground";
			case 2:
				return "A stone keep controlling routes through the swamps";
			case 3:
				return "A large stone keep that keeps a watch on the routes through the swamps";
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
				Script = "scripts/entity/world/attached_location/herbalists_grove_location",
				Terrain = ALL,
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
				Script = "scripts/entity/world/attached_location/workshop_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 0,
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

		if (!this.Const.World.Buildings.Kennels == 0)
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 2);
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
			], []);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 2);
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
			], []);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
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

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1 || this.Const.World.Buildings.Kennels == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 1);
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
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
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

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
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
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
	}

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

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

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1 || this.Const.World.Buildings.Kennels == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 1);
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
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
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

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
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
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
	}
});

