::mods_hookExactClass("entity/world/settlements/large_steppe_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendInventor,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendDisownedNobleRanged,
		]);
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey,
			::Legends.Background.LegendHorseDestrier,
			::Legends.Background.LegendHorseCourser
		];
		if (::World.Assets.getOrigin().getID() == "scenario.legends_nomad") {
			this.m.DraftList.push(::Legends.Background.Nomad);
			this.m.DraftList.push(::Legends.Background.Nomad);
			this.m.DraftList.push(::Legends.Background.Nomad);
			this.m.DraftList.push(::Legends.Background.NomadRanged);
			this.m.DraftList.push(::Legends.Background.NomadRanged);
			this.m.DraftList.push(::Legends.Background.NomadRanged);
			this.m.DraftList.push(::Legends.Background.LegendBladedancer);
			this.m.DraftList.push(::Legends.Background.LegendBladedancer);
		}
	}

	o.onBuild = function() {
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));

		if (::Math.rand(1, 100) <= 50) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		} else if (::Math.rand(1, 100) <= 50) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
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

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/dye_maker_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/winery_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
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
			::Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
	}
});
