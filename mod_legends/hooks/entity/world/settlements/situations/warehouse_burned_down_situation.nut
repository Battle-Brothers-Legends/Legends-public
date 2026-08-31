::mods_hookExactClass("entity/world/settlements/situations/warehouse_burned_down_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}
});
