::mods_hookExactClass("entity/world/settlements/small_farm_fort", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendAdventurousNobleRanged,
		]);
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey,
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (::Const.World.Buildings.Kennels == 0) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		} else if (::Const.World.Buildings.Stables == 0) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		} else {
			local r = ::Math.rand(1, 4);

			if (r == 1) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			} else if (r == 2) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			} else if (r == 3) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			} else if (r == 4) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (::Math.rand(1, 100) <= 50) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
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
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], 4, true);
	}
});
