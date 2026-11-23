::mods_hookExactClass("entity/world/settlements/buildings/weaponsmith_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(80, 1.0, "tents/legend_tent_repair"),
			item(60, 1.0, "weapons/legend_zweihander"),
			item(70, 1.0, "weapons/legend_battle_glaive"),
			item(80, 1.0, "weapons/legend_swordstaff"),
			item(70, 1.0, "weapons/legend_halberd"),
			item(80, 1.0, "weapons/legend_ranged_flail"),
			item(70, 1.0, "weapons/legend_ranged_wooden_flail"),
			item(50, 1.0, "weapons/legend_zweihander"),
			item(65, 1.0, "weapons/legend_reinforced_flail"),
			item(90, 1.0, "weapons/legend_military_goedendag"),
			item(90, 1.0, "weapons/legend_military_warscythe"),
			item(40, 1.0, "weapons/legend_two_handed_club"),
			item(80, 1.0, "weapons/battle_whip"),
			item(70, 1.0, "weapons/legend_cat_o_nine_tails"),
		]);
		return list;
	}
});
