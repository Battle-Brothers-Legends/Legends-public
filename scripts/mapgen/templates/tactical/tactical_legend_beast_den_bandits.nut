this.tactical_legend_beast_den_bandits <- this.inherit("scripts/mapgen/templates/tactical/tactical_legend_beast_den", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.legend_beast_den_bandits";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function furnish( _rect )
	{
		local tile = ::Tactical.getTileSquare(_rect.X + 20, _rect.Y + ::Math.rand(14, 18));
		tile.Level = 0;
		tile.clear();

		if (!tile.IsEmpty)
		{
			tile.removeObject();
		}

		tile.spawnObject(::Math.rand(1, 3) == 1 ? "entity/tactical/objects/human_camp_small_fireplace" : "entity/tactical/objects/human_camp_large_fireplace");
	}

});
