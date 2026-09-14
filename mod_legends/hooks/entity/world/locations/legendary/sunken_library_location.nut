::mods_hookExactClass("entity/world/locations/legendary/sunken_library_location", function(o)
{
	o.onDropLootForPlayer <- function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(0, 60), _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		], _lootTable);
	}
});
