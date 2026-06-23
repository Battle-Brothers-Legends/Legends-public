::mods_hookExactClass("entity/world/settlements/medium_lumber_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList = [
			::Legends.Background.Beggar,
			::Legends.Background.Bowyer,
			::Legends.Background.Bowyer,
			::Legends.Background.Brawler,
			::Legends.Background.Butcher,
			::Legends.Background.Daytaler,
			::Legends.Background.Historian,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Militia,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Tailor,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Cripple,
			::Legends.Background.Eunuch,
			"female_beggar_background",
			"female_bowyer_background",
			"female_bowyer_background",
			::Legends.Background.Brawler,
			::Legends.Background.Butcher,
			"female_daytaler_background",
			::Legends.Background.Historian,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Militia,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			"female_tailor_background",
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Cripple,
			::Legends.Background.Eunuch,
			::Legends.Background.Anatomist,
			::Legends.Background.BeastSlayer,
			"executioner_background"
		];
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Const.DLC.Unhold) {
			local r = this.Math.rand(1, 4);

			if (r == 1 || this.Const.World.Buildings.Taxidermists == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
			} else if (r == 2 || this.Const.World.Buildings.Fletchers == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			} else if (r == 3 || this.Const.World.Buildings.Blackmarket == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			} else if (r == 4) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		} else {
			local r = this.Math.rand(1, 3);

			if (r == 1 || this.Const.World.Buildings.Fletchers == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			} else if (r == 2 || this.Const.World.Buildings.Blackmarket == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			} else if (r == 3) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 50) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills
			], [], 1);
		} else {
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills
			], [], 1);
		}

		if (this.Math.rand(1, 100) <= 50) {
			this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 2, false, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/lumber_camp_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 1, false, true);
		} else {
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 2, false, true);
			this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/lumber_camp_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 1, false, true);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 3, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
			this.Const.World.TerrainType.Plains
		], [], 1);
	}
});
