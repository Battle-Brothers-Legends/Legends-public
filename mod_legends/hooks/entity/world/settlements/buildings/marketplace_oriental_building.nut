::mods_hookExactClass("entity/world/settlements/buildings/marketplace_oriental_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(60, 1.0, "helmets/legend_earings"),
			item(60, 1.0, "helmets/legend_headband_coin"),
			item(70, 1.0, "helmets/legend_headress_coin"),
			item(50, 1.0, "helmets/legend_southern_cloth_headress"),
			item(40, 1.0, "helmets/legend_southern_veil"),
		]);
		list.extend([
			item(60, 1.0, "accessory/legend_sighthound_item"),
		]);

		if (this.m.Settlement.getSize() >= 2) {
			list.extend([
				item(50, 1.0, "misc/legend_weapon_skill_book_item"),
				item(50, 1.0, "misc/legend_profession_skill_book_item"),
				item(50, 1.0, "misc/legend_class_skill_book_item"),
				item(50, 1.0, "misc/legend_armor_skill_book_item"),
				item(50, 1.0, "misc/legend_trait_skill_book_item"),
				item(50, 1.0, "misc/legend_enemy_skill_book_item"),
			]);
		}

		if (this.m.Settlement.getSize() >= 3) {
			list.extend([
				item(50, 1.0, "misc/legend_weapon_skill_book_item"),
				item(50, 1.0, "misc/legend_profession_skill_book_item"),
				item(50, 1.0, "misc/legend_class_skill_book_item"),
				item(50, 1.0, "misc/legend_armor_skill_book_item"),
				item(50, 1.0, "misc/legend_trait_skill_book_item"),
				item(50, 1.0, "misc/legend_enemy_skill_book_item"),
				item(95, 2.0, "misc/legend_masterwork_fabric"),
				item(95, 2.0, "misc/legend_masterwork_tools"),
				item(95, 2.0, "misc/legend_masterwork_metal"),
			]);
		}

		if (this.m.Settlement.getSize() >= 3 || this.m.Settlement.isMilitary()) {
			list.extend([
				item(50, 1.0, "accessory/falcon_item"),
			]);
		}
		return list;
	}
});
