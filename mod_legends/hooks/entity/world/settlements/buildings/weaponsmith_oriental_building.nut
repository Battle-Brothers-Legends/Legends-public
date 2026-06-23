::mods_hookExactClass("entity/world/settlements/buildings/weaponsmith_oriental_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(70, 1.0, "accessory/gloves/legend_cestus_item"),
			item(99, 1.0, "accessory/gloves/legend_cestus_item_named"),
			item(90, 1.0, "weapons/legend_zweihander"),
			item(99, 1.0, "weapons/named/legend_named_nomad_sling"),
		]);
		return list;
	}
});
