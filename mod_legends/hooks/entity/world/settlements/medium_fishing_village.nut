::mods_hookExactClass("entity/world/settlements/medium_fishing_village", function(o) {
	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Math.rand(1, 100) <= 66) {
			local r = ::Math.rand(1, 2);

			if (r == 1 || ::Const.World.Buildings.Blackmarket == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			} else if (r <= 2) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			::Const.World.TerrainType.Shore
		], [
			::Const.World.TerrainType.Ocean,
			::Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		], 1, true);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/amber_collector_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
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
});
