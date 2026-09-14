::mods_hookExactClass("entity/world/settlements/buildings/kennel_building", function(o) {
	local getDefaultShopList = o.getDefaultShopList;
	o.getDefaultShopList = function() {
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = getDefaultShopList();
		list.extend([
			item(0, 1.0, "accessory/legend_wardog_item"),
			item(15, 1.0, "accessory/legend_wolf_item"),
			item(0, 1.0, "accessory/legend_armored_wardog_item"),
		]);

		if (this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7) {
			list.extend([
				item(0, 1.0, "accessory/legend_warhound_item"),
				item(0, 1.0, "accessory/legend_wolf_item"),
				item(0, 1.0, "accessory/legend_armored_warhound_item"),
			]);
		} else {
			list.extend([
				item(0, 1.0, "accessory/legend_wardog_item")
			]);
		}
		return list;
	}
});
