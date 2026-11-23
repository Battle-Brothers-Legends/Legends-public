::mods_hookExactClass("entity/world/settlements/buildings/armorsmith_oriental_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(30, 1.0, "helmets/oriental/kamy_southern_helmet"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_metal_plating_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_mail_patch_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_leather_neckguard_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_joint_cover_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_heraldic_plates_upgrade"),
			item(85, 1.25, "legend_armor/armor_upgrades/legend_double_mail_upgrade"),
		]);

		foreach (i in this.Const.Items.NamedSouthernShields) {
			if (this.Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}

		foreach (i in this.Const.Items.LegendNamedSouthernArmorLayers) {
			if (this.Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}

		foreach (i in this.Const.Items.LegendNamedArmorUpgrades) {
			if (this.Math.rand(1, 100) <= 33) {
				list.push(item(99, 2.0, i));
			}
		}
		return list
	}
});
