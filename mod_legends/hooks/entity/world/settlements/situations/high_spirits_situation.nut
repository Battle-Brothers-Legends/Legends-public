::mods_hookExactClass("entity/world/settlements/situations/high_spirits_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.01);
		onAdded(_settlement);
	}
});
