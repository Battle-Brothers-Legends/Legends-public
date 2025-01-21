::mods_hookExactClass("entity/world/locations/goblin_outpost_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 50), _lootTable);
		this.dropArmorParts(this.Math.rand(5, 15), _lootTable);
		this.dropAmmo(this.Math.rand(30, 60), _lootTable);
		this.dropMedicine(this.Math.rand(0, 5), _lootTable);
		local treasure = [
			"trade/salt_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/ancient_gold_coins_item",
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

		this.dropFood(this.Math.rand(3, 5), [
			"strange_meat_item",
			"roots_and_berries_item",
			"pickled_mushrooms_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);

		local treasure = [];
		treasure.push("misc/legend_paint_black_item");
		treasure.push("misc/legend_paint_red_item");
		this.dropTreasure(1, treasure, _lootTable);
	}
});
