::mods_hookExactClass("entity/world/locations/undead_mass_grave_location", function(o) 
{
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(200, 500), _lootTable);
		this.dropArmorParts(::Math.rand(0, 40), _lootTable);
		this.dropAmmo(::Math.rand(0, 20), _lootTable);
		local treasure = [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item"
		];

		if (::Const.DLC.Unhold)
		{
			treasure.extend(treasure);
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
		}

		this.dropTreasure(::Math.rand(0, 1), treasure, _lootTable);
	}
});