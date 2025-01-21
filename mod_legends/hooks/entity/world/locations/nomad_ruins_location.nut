::mods_hookExactClass("entity/world/locations/nomad_ruins_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(100, 300), _lootTable);
		this.dropArmorParts(this.Math.rand(5, 25), _lootTable);
		this.dropAmmo(this.Math.rand(0, 40), _lootTable);
		this.dropMedicine(this.Math.rand(0, 3), _lootTable);
		local treasure = [
			"trade/incense_item",
			"trade/dies_item",
			"trade/cloth_rolls_item",
			"trade/silk_item",
			"trade/spices_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"tools/fire_bomb_item"
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

		this.dropFood(this.Math.rand(2, 4), [
			"bread_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			"goat_cheese_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);
	}
});