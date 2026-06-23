::mods_hookExactClass("entity/world/settlements/buildings/armorsmith_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(75, 1.0, "shields/legend_tower_shield"),
			item(80, 1.0, "tents/legend_tent_scrap"),
			item(70, 1.0, "accessory/gloves/legend_spiked_gauntlets_item"),
		]);
		list.extend([
			item(80, 1.0, "helmets/legend_enclave_vanilla_skullcap_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_skullcap_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_great_helm_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_great_helm_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_great_bascinet_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_great_bascinet_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_great_bascinet_02"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_great_bascinet_02"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_armet_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_armet_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_kettle_sallet_01"),
			item(80, 1.0, "helmets/legend_enclave_vanilla_kettle_sallet_01"),
			item(80, 1.0, "helmets/cervelliere"),
			item(80, 1.0, "helmets/cervelliere"),
			item(80, 1.0, "helmets/deep_cervelliere"),
			item(80, 1.0, "helmets/deep_cervelliere"),
			item(80, 1.0, "helmets/scale_helm"),
			item(80, 1.0, "helmets/scale_helm"),
			item(80, 1.0, "helmets/rondel_helm"),
			item(80, 1.0, "helmets/rondel_helm"),
			item(80, 1.0, "helmets/rondel_helm"),
			item(80, 1.0, "helmets/rondel_helm")
		]);
		list.extend([
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_skull_chain_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_skull_chain_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_sacred_shield_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_sacred_shield_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_chain_and_mail_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_chain_and_mail_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_spiked_collar_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_armor_spiked_collar_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_upgrade"),
			item(70, 1.0, "legend_armor/armor_upgrades/legend_pauldron_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"),
			item(70, 1.0, "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"),
			item(70, 1.0, "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_stag_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_stag_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_swan_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_pauldron_swan_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_light_gladiator_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_light_gladiator_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade"),
			item(80, 1.0, "legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade"),
		]);
		list.extend([
			item(85, 1.25, "legend_armor/armor_upgrades/legend_metal_plating_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_mail_patch_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_leather_neckguard_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_joint_cover_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_heraldic_plates_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_double_mail_upgrade"),
		]);
		list.extend([
			item(90, 1.0, "legend_armor/cloth/legend_armor_knightly_robe"),
			item(60, 1.0, "legend_armor/cloth/legend_armor_wanderers_coat"),
		]);

		foreach (i in ::Const.Items.LegendNamedArmorLayers) {
			if (::Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}
		foreach (i in ::Const.Items.LegendNamedHelmetLayers) {
			if (::Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}
		foreach (i in ::Const.Items.NamedShields) {
			if (::Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}
		foreach (i in ::Const.Items.LegendNamedArmorUpgrades) {
			if (::Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}
		return list;
	}
});
