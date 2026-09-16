::mods_hookExactClass("entity/world/settlements/medium_snow_village", function(o) {
	o.onBuild = function ( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 3);

		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], [
			::Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}
});