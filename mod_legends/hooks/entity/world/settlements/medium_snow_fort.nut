::mods_hookExactClass("entity/world/settlements/medium_snow_fort", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendDisownedNobleRanged,
		]);
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));

		if (::Const.World.Buildings.Kennels == 0) {
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

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 2, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 1, true);
	}
});
