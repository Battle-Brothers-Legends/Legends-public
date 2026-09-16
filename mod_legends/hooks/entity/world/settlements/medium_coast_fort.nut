::mods_hookExactClass("entity/world/settlements/medium_coast_fort", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendAdventurousNobleRanged,
		]);
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey,
			::Legends.Background.LegendHorseDestrier
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);

		if (::Math.rand(1, 100) <= 50) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (!::Const.World.Buildings.Kennels == 0) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		} else if (::Const.World.Buildings.Stables == 0) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		} else {
			local r = ::Math.rand(1, 4);

			if (r == 1) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			} else if (r == 2) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			} else if (r == 3) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			} else if (r == 4) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (::Math.rand(1, 100) <= 70) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Shore
			], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fishing_huts_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Shore
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		if (::Math.rand(1, 100) <= 40) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills
			], [], 1);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			::Const.World.TerrainType.Shore
		], [
			::Const.World.TerrainType.Ocean,
			::Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
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
});
