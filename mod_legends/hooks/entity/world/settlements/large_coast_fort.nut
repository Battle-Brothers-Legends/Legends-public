::mods_hookExactClass("entity/world/settlements/large_coast_fort", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.BeastSlayer,
			::Legends.Background.Manhunter,
			::Legends.Background.LegendTaxidermist,
			::Legends.Background.LegendBlacksmith,
			::Legends.Background.LegendArbalester,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendAdventurousNobleRanged,
		]);
		this.m.StablesList = [
			::Legends.Background.LegendHorseDestrier,
			::Legends.Background.LegendHorseCourser
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue()) {
			local ALL = [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			];
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);

			this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
				::Const.World.TerrainType.Shore
			], [
				::Const.World.TerrainType.Ocean,
				::Const.World.TerrainType.Shore
			], 1, false, false);

			this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", ALL,
				[
					::Const.World.TerrainType.Shore
				]);

			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/amber_collector_location", ALL,
				[
					::Const.World.TerrainType.Shore
				]);

			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Math.rand(1, 100) <= 50) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 60) {
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
		} else {
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

		if (::Math.rand(1, 100) <= 50) {
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
		} else {
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

		this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
			::Const.World.TerrainType.Shore
		], [
			::Const.World.TerrainType.Ocean,
			::Const.World.TerrainType.Shore
		], 1, false, false);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		]);
	}
});
