::mods_hookExactClass("entity/world/locations/barbarian_sanctuary_location", function(o) 
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.NamedWeaponsList = clone ::Const.Items.NamedBarbarianWeapons;
		this.m.NamedWeaponsList.extend([
			"weapons/named/legend_named_heavy_javelin",
			"weapons/named/legend_named_heavy_throwing_axe"
		]);
		if (::Math.rand(1, 4) == 1)
			this.m.NamedWeaponsList.extend(::Const.Items.NamedBarbarianWeaponsHigh);
	}

	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(300, 700), _lootTable);
		this.dropArmorParts(::Math.rand(25, 50), _lootTable);
		this.dropAmmo(::Math.rand(0, 50), _lootTable);
		this.dropMedicine(::Math.rand(5, 15), _lootTable);
		local treasure = [
			"trade/furs_item",
			"trade/furs_item",
			"trade/amber_shards_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/bone_figurines_item",
			"loot/valuable_furs_item",
			"loot/bead_necklace_item",
			"loot/looted_valuables_item"
		];
		this.dropFood(::Math.rand(4, 8), [
			"bread_item",
			"beer_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			"pickled_mushrooms_item",
			"smoked_ham_item",
			"mead_item",
			"cured_venison_item",
			"goat_cheese_item"
		], _lootTable);
		this.dropTreasure(::Math.rand(2, 3), treasure, _lootTable);
	}
});