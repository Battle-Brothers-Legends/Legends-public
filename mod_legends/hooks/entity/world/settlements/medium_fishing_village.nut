::mods_hookExactClass("entity/world/settlements/medium_fishing_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Beggar,
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Daytaler,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.Juggler,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Peddler,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Servant,
			::Legends.Background.Tailor,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Cripple,
			::Legends.Background.Eunuch,
			::Legends.Background.Sellsword,
			::Legends.Background.Anatomist,
			::Legends.Background.Apprentice,
			"female_beggar_background",
			"female_beggar_background",
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			"female_daytaler_background",
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			"female_butcher_background",
			"female_butcher_background",
			::Legends.Background.Gravedigger,
			::Legends.Background.Graverobber,
			::Legends.Background.Historian,
			::Legends.Background.Juggler,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Monk,
			::Legends.Background.Peddler,
			::Legends.Background.Flagellant,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			"female_servant_background",
			"female_tailor_background",
			"female_thief_background",
			::Legends.Background.Vagabond,
			::Legends.Background.Cripple,
			::Legends.Background.Eunuch,
			::Legends.Background.Sellsword,
			"executioner_background"
		];
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Math.rand(1, 100) <= 66) {
			local r = this.Math.rand(1, 2);

			if (r == 1 || this.Const.World.Buildings.Blackmarket == 0) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
			} else if (r <= 2) {
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		], 1, true);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/amber_collector_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
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
	}
});
