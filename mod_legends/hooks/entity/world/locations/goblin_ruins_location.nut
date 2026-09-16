::mods_hookExactClass("entity/world/locations/goblin_ruins_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(::Math.rand(5, 15), _lootTable);
		this.dropAmmo(::Math.rand(20, 40), _lootTable);
		this.dropMedicine(::Math.rand(0, 3), _lootTable);
		local treasure = [
			"trade/salt_item",
			"trade/amber_shards_item",
			"trade/furs_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/goblin_carved_ivory_iconographs_item",
			"loot/goblin_minted_coins_item",
			"loot/goblin_rank_insignia_item"
		];

		treasure.extend(treasure);
		treasure.extend(treasure);
		treasure.extend(treasure);
		treasure.push("legend_armor/armor_upgrades/legend_metal_plating_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_mail_patch_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_leather_neckguard_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_joint_cover_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_heraldic_plates_upgrade");
		treasure.push("legend_armor/armor_upgrades/legend_double_mail_upgrade");

		this.dropFood(::Math.rand(2, 4), [
			"strange_meat_item",
			"roots_and_berries_item",
			"pickled_mushrooms_item"
		], _lootTable);
		this.dropTreasure(::Math.rand(1, 2), treasure, _lootTable);
	}
});