this.legends_coast_fort <- this.inherit("scripts/entity/world/settlements/legends_fort", {
	m = {},
	function create()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
			"Seefeste",
			"Kleifeste",
			"Otterfeste",
			"Blankenfeste",
			"Kampfeste",
			"Stohlfeste",
			"Krakenfeste",
			"Sandfeste",
			"Aalfeste",
			"Sturmfeste",
			"Wesefeste",
			"Dunenfeste",
			"Horizont",
			"Ertrunkenort",
			"Diekante",
			"Dasende",
			"Wasserkante",
			"Seemarkfeste",
			"Seelandfeste",
			"Regenfeste",
			"Segelfeste",
			"Kranichfeste",
			"Schwalbenfeste",
			"Dunstfeste",
			"Windfeste",
			"Reedfeste"
			],
			[
			"Seeburg",
			"Kielburg",
			"Otternburg",
			"Blankenburg",
			"Kampburg",
			"Stohlburg",
			"Wikburg",
			"Krakenburg",
			"Krumburg",
			"Sandeburg",
			"Meerburg",
			"Aalburg",
			"Dunenburg",
			"Sturmburg",
			"Weseburg",
			"Gischtburg",
			"Mowenburg",
			"Beltburg",
			"Sundburg",
			"Salzburg",
			"Blauburg",
			"Sichelburg",
			"Heringsburg",
			"Schollburg"
			],
			[
			"Seeturm",
			"Sandwacht",
			"Seewall",
			"Kielwall",
			"Strandwall",
			"Otternwacht",
			"Kampwacht",
			"Stohlwall",
			"Seeschanz",
			"Wikwall",
			"Sandturm",
			"Krakenwacht",
			"Strandwehr",
			"Seewehr",
			"Blankwehr",
			"Krumwehr",
			"Wallsande",
			"Salzwacht",
			"Sturmwall",
			"Seewacht",
			"Fernwall",
			"Wesselburg",
			"Dagewall",
			"Windwacht",
			"Weissenwacht",
			"Fishburg",
			"Stindwall",
			"Tidenwall",
			"Ebbenwacht",
			"Prielburg",
			"Sundwall",
			"Sielburg"
			]
		];
		this.m.DraftLists = [
			[
			"fisherman_background",
			"fisherman_background",
			"houndmaster_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"ratcatcher_background",
			"witchhunter_background",
			"adventurous_noble_background",
			"bastard_background",
			"deserter_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background",
			"fisherman_background",
			"fisherman_background",
			"houndmaster_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"ratcatcher_background",
			"witchhunter_background",
			"bastard_background",
			"deserter_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background"
			],
			[
			"apprentice_background",
			"caravan_hand_background",
			"gambler_background",
			"daytaler_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"historian_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"monk_background",
			"peddler_background",
			"ratcatcher_background",
			"servant_background",
			"vagabond_background",
			"witchhunter_background",
			"adventurous_noble_background",
			"adventurous_noble_background",
			"bastard_background",
			"deserter_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background",
			"sellsword_background",
			"swordmaster_background",
			"apprentice_background",
			"caravan_hand_background",
			"gambler_background",
			"fisherman_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"historian_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"monk_background",
			"peddler_background",
			"ratcatcher_background",
			"vagabond_background",
			"witchhunter_background",
			"bastard_background",
			"deserter_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background",
			"sellsword_background",
			"swordmaster_background"
			],
			[
			"apprentice_background",
			"brawler_background",
			"caravan_hand_background",
			"caravan_hand_background",
			"gambler_background",
			"daytaler_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"historian_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"minstrel_background",
			"ratcatcher_background",
			"refugee_background",
			"servant_background",
			"vagabond_background",
			"witchhunter_background",
			"adventurous_noble_background",
			"adventurous_noble_background",
			"bastard_background",
			"deserter_background",
			"deserter_background",
			"raider_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background",
			"retired_soldier_background",
			"sellsword_background",
			"squire_background",
			"swordmaster_background",
			"cripple_background",
			"eunuch_background",
			 "apprentice_background",
			"brawler_background",
			"caravan_hand_background",
			"caravan_hand_background",
			"gambler_background",
			"fisherman_background",
			"fisherman_background",
			"gravedigger_background",
			"historian_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"minstrel_background",
			"ratcatcher_background",
			"refugee_background",
			"vagabond_background",
			"witchhunter_background",
			"bastard_background",
			"deserter_background",
			"deserter_background",
			"raider_background",
			"raider_background",
			"raider_background",
			"retired_soldier_background",
			"retired_soldier_background",
			"sellsword_background",
			"squire_background",
			"swordmaster_background",
			"cripple_background",
			"eunuch_background"
		]];

		this.m.StablesLists = [[
			"legend_donkey_background",
			"legend_horse_rouncey"
		],
		[
			"legend_donkey_background",
			"legend_horse_rouncey",
			"legend_horse_destrier"
		],
		[
			"legend_horse_destrier",
			"legend_horse_courser"
		]];

		this.m.Rumors = this.Const.Strings.RumorsFishingSettlement;

	}

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A wooden motte with a bailey towering high over the nearby coastline.";
			case 2:
				return "This stone keep controls a strategically important sea access and protects nearby trading routes.";
			case 3:
				return "This massive citadel guards a warport and the surrounding trade routes. It is a seat of power for nobility and home to a large garrison.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A wooden motte with a bailey towering high over the nearby coastline";
			case 2:
				return "A stone keep that controls a strategically important port and protects nearby trading routes";
			case 3:
				return "This massive citadel guards a warport and the surrounding trade routes";
			default:
				return null;
		}
	}

	function getUIBackgroundLeft()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "ui/settlements/water_01";
			case 2:
				return "ui/settlements/water_01";
			case 3:
				return "ui/settlements/water_01";
			default:
				return null;
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
				return 5;
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
				Script = "scripts/entity/world/attached_location/leather_tanner_location",
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
				items.extend([			[1, {
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
					Script = "scripts/entity/world/attached_location/surface_iron_vein_location",
					Terrain = ALL
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
				[1, {Num = 1,
					Script = "scripts/entity/world/attached_location/ore_smelters_location",
					Terrain = ALL,
					NearTerrain = [],
					Distance = 0,
					Road = false,
					Clear = true,
					Force = true
				}],
				[1, {Num = 1,
					Script = "scripts/entity/world/attached_location/blast_furnace_location",
					Terrain = ALL,
					NearTerrain = [],
					Distance = 0,
					Road = false,
					Clear = true,
					Force = true
				}],
				[1, {Num = 1,
					Script = "scripts/entity/world/attached_location/amber_collector_location",
					Terrain = ALL,
					NearTerrain = [this.Const.World.TerrainType.Shore],
					Distance = 1,
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

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
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

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 4, true);
	}

	function onBuildTwo( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (!this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
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

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Shore
			], 1, true);
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
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fishing_huts_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Shore
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
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

	function onBuildThree( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
		{
			local ALL = [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			];
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);

			this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
				this.Const.World.TerrainType.Shore
			], [
				this.Const.World.TerrainType.Ocean,
				this.Const.World.TerrainType.Shore
			], 1, false, false);

			this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", ALL,
			[
				this.Const.World.TerrainType.Shore
			]);

			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/amber_collector_location", ALL,
			[
				this.Const.World.TerrainType.Shore
			]);

			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 60)
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
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [
				this.Const.World.TerrainType.Tundra
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [
				this.Const.World.TerrainType.Tundra
			], 1, true);
		}

		this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], 1, false, false);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
	}

});

