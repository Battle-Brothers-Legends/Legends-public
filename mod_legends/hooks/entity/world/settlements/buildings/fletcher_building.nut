::mods_hookExactClass("entity/world/settlements/buildings/fletcher_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(80, 1.0, "tents/legend_tent_fletcher"),
		]);
		list.extend([
			item(10, 1.0, "weapons/legend_slingshot"),
			item(10, 1.0, "weapons/legend_dilapitated_sling"),
			item(40, 1.0, "weapons/legend_sturdy_sling"),
			item(70, 1.0, "weapons/legend_northern_sling"),
			item(50, 1.0, "weapons/legend_hand_crossbow"),
			item(50, 1.0, "weapons/legend_hand_crossbow"),
		]);
		list.extend([
			item(40, 1.0, "ammo/legend_armor_piercing_arrows"),
			item(40, 1.0, "ammo/legend_broad_head_arrows"),
			item(40, 1.0, "ammo/legend_armor_piercing_bolts"),
			item(40, 1.0, "ammo/legend_broad_head_bolts"),
			item(70, 1.0, "ammo/large_quiver_of_bolts"),
			item(70, 1.0, "ammo/large_quiver_of_arrows"),
			item(90, 1.0, "weapons/throwing_spear"),
		]);
		return list;
	}
});
