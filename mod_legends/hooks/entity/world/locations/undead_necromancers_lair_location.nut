::mods_hookExactClass("entity/world/locations/undead_necromancers_lair_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(100, 400), _lootTable);
		this.dropFood(this.Math.rand(0, 1), [
			"wine_item",
			"bread_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item"
		], _lootTable);

		if (this.Const.DLC.Unhold && this.Math.rand(1, 100) <= 10)
		{
			local treasure = [];
			treasure.push("misc/legend_paint_black_item");
			this.dropTreasure(1, treasure, _lootTable);
		}
	}
});