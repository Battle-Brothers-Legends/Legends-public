::mods_hookExactClass("entity/world/locations/orc_fortress_location", function(o)
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(::Math.rand(25, 50), _lootTable);
		this.dropMedicine(::Math.rand(0, 6), _lootTable);
		this.dropFood(::Math.rand(4, 8), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(::Math.rand(3, 4), [
			"trade/furs_item",
			"trade/furs_item",
			"trade/uncut_gems_item",
			"trade/dies_item",
			"loot/white_pearls_item"
		], _lootTable);
		_lootTable.push(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Legendary.legend_emperors_countenance]]));
	}
});
