::mods_hookExactClass("entity/world/settlements/buildings/marketplace_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(40, 1.0, "weapons/legend_militia_glaive"),
			item(10, 1.0, "weapons/legend_wooden_spear"),
			item(10, 1.0, "weapons/legend_shiv"),
			item(20, 1.0, "weapons/legend_shovel"),
			item(15, 1.0, "weapons/legend_dilapitated_sling"),
			item(40, 1.0, "weapons/legend_sturdy_sling"),
			item(80, 1.0, "weapons/legend_drum"),
			item(80, 1.0, "weapons/legend_cat_o_nine_tails"),
			item(80, 1.0, "weapons/lute"),
		]);
		list.extend([
			item(25, 1.0, "accessory/legend_pack_small"),
			item(60, 1.0, "accessory/gloves/legend_hand_wraps_item"),
		]);
		list.extend([
			item(40, 1.0, "supplies/legend_fresh_fruit_item"),
			item(20, 1.0, "supplies/legend_fresh_meat_item"),
			item(0, 1.0, "supplies/legend_ammo_small_item"),
			item(10, 1.0, "supplies/legend_armor_parts_small_item"),
			item(50, 1.0, "supplies/legend_armor_parts_small_item"),
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

		if (this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.4) {
			list.extend([
				item(30, 1.0, "weapons/staff_sling"),
			]);
		}
		return list
	}
});
