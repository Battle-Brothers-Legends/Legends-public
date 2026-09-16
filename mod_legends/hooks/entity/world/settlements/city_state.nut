::mods_hookExactClass("entity/world/settlements/city_state", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.FemaleDraftList = [
			::Legends.Background.LegendBellyDancer,
			::Legends.Background.LegendDisownedNobleRanged,
		];
		this.m.DraftList.extend([
			::Legends.Background.JugglerSouthern,
			::Legends.Background.LegendMuladi,
			::Legends.Background.LegendDervish,
			::Legends.Background.BeastSlayer
		]);
	}

	o.getSpriteName <- function() {
		return this.m.Sprite;
	}

	o.buildNewLocation <- function() {
		local ALL = [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis
		];
		local items = [
			[1, {
				Script = "scripts/entity/world/attached_location/harbor_location",
				Terrain = [::Const.World.TerrainType.Shore],
				NearTerrain = [::Const.World.TerrainType.Shore, ::Const.World.TerrainType.Ocean],
				Distance = 1,
				Road = false,
				Clear = false,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/fishing_huts_oriental_location",
				Terrain = ALL,
				NearTerrain = [::Const.World.TerrainType.Shore],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/incense_dryer_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/silk_farm_location",
				Terrain = ALL
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/plantation_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/dye_maker_oriental_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/goat_herd_oriental_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],


		];

		items = this.filterNewLocation(items);
		local item = ::Const.World.Common.pickItem(items);
		return this.buildAttachedLocation(1, item.Script, item.Terrain, item.NearTerrain, item.Distance, item.Road, item.Clear, item.Force);
	}

	o.onSerialize <- function(_out) {
		this.settlement.onSerialize(_out);
		_out.writeU8(this.m.AttachedLocationsMax);
	}

	o.onDeserialize <- function(_in) {
		this.settlement.onDeserialize(_in);
		this.m.AttachedLocationsMax = _in.readU8();
	}
});
