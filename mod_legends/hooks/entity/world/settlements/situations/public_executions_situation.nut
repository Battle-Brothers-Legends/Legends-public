::mods_hookExactClass("entity/world/settlements/situations/public_executions_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.025);
		onAdded(_settlement);
	}
});
