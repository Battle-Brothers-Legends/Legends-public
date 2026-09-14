::mods_hookExactClass("entity/world/settlements/situations/snow_storms_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.95);
		onAdded(_settlement);
	}
});
