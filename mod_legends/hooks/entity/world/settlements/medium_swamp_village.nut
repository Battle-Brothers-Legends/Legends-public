::mods_hookExactClass("entity/world/settlements/medium_swamp_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList = [
			::Legends.Background.Beggar,
			::Legends.Background.Beggar,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Flagellant,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.DisownedNoble,
			::Legends.Background.Cripple,
			::Legends.Background.Anatomist,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Flagellant,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.Witchhunter,
			::Legends.Background.AdventurousNoble,
			::Legends.Background.DisownedNoble,
			::Legends.Background.Cripple,
			::Legends.Background.Executioner
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Const.DLC.Unhold) {
			local r = this.Math.rand(1, 3);

			if (r == 1 || this.Const.World.Buildings.Taxidermists == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
			} else if (r == 2) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			} else if (r == 3) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
		} else {
			local r = this.Math.rand(1, 3);

			if (r <= 2) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			} else if (r == 3) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 70) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		} else {
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			this.Const.World.TerrainType.Swamp
		], [], 2);
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
		], 3, true);
	}
});
