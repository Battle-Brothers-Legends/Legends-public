::mods_hookExactClass("entity/world/settlements/large_swamp_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendInventor,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendDisownedNobleRanged,
		]);
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Const.DLC.Unhold) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		} else if (::Math.rand(1, 100) <= 80 || ::Const.World.Buildings.Blackmarket == 0) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}

		if (::Math.rand(1, 100) <= 50) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (::Math.rand(1, 100) <= 60) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}

		if (::Math.rand(1, 100) <= 60) {
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
		} else {
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

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			::Const.World.TerrainType.Swamp
		], []);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			::Const.World.TerrainType.Swamp
		], [], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
	}
});
