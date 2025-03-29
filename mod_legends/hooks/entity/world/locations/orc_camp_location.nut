::mods_hookExactClass("entity/world/locations/orc_camp_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(10, 25), _lootTable);
		this.dropMedicine(this.Math.rand(0, 2), _lootTable);
		this.dropFood(this.Math.rand(2, 4), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(0, 1), [
			"trade/furs_item",
			"trade/copper_ingots_item",
			"trade/legend_iron_ingots_item",
			"trade/legend_tin_ingots_item",
			"trade/legend_gold_nugget_item"
		], _lootTable);

		if (this.Const.DLC.Unhold && this.Math.rand(1, 100) <= 10)
		{
			local treasure = [];
			treasure.push("misc/legend_paint_black_item");
			treasure.push("misc/legend_paint_red_item");
			this.dropTreasure(1, treasure, _lootTable);
		}
	}
});