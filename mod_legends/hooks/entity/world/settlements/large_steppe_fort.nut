::mods_hookExactClass("entity/world/settlements/large_steppe_fort", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendIronmonger,
			::Legends.Background.LegendHouseGuard,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendAdventurousNobleRanged,
			::Legends.Background.LegendAdventurousNobleRanged,
		]);
		this.m.StablesList = [
			::Legends.Background.LegendHorseDestrier,
			::Legends.Background.LegendHorseCourser,
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
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue()) {
			local ALL = [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			];
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 0, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", ALL, [], 0, false, true, true);
			return;
		}


		if (::Math.rand(1, 100) <= 50 || ::Const.World.Buildings.Fletchers == 0) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 70) {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		} else {
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 40) {
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 5, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1, true);
		} else {
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1, true);
		}
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
	}
});
