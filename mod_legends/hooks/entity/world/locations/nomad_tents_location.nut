::mods_hookExactClass("entity/world/locations/nomad_tents_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(50, 150), _lootTable);
		this.dropArmorParts(::Math.rand(0, 10), _lootTable);
		this.dropAmmo(::Math.rand(0, 10), _lootTable);
		this.dropMedicine(::Math.rand(0, 5), _lootTable);
		local treasure = [
			"loot/signet_ring_item",
			"trade/spices_item",
			"trade/cloth_rolls_item",
			"trade/salt_item"
		];
		this.dropFood(::Math.rand(1, 2), [
			"bread_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			"goat_cheese_item"
		], _lootTable);
		this.dropTreasure(1, treasure, _lootTable);
	}
});