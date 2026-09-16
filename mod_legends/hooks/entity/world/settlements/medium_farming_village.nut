::mods_hookExactClass("entity/world/settlements/medium_farming_village", function(o) 
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}

	o.onBuild = function ( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 3);

		if (r == 1 || ::Const.World.Buildings.Blackmarket == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wool_spinner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}
});