::mods_hookExactClass("entity/world/settlements/medium_lumber_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Const.DLC.Unhold) {
			local r = ::Math.rand(1, 4);

			if (r == 1 || ::Const.World.Buildings.Taxidermists == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
			} else if (r == 2 || ::Const.World.Buildings.Fletchers == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			} else if (r == 3 || ::Const.World.Buildings.Blackmarket == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			} else if (r == 4) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		} else {
			local r = ::Math.rand(1, 3);

			if (r == 1 || ::Const.World.Buildings.Fletchers == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			} else if (r == 2 || ::Const.World.Buildings.Blackmarket == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			} else if (r == 3) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		}

		if (::Math.rand(1, 100) <= 50) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills
			], [], 1);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills
			], [], 1);
		}

		if (::Math.rand(1, 100) <= 50) {
			this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 2, false, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/lumber_camp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 1, false, true);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 2, false, true);
			this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/lumber_camp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 1, false, true);
		}

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
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
	}
});
