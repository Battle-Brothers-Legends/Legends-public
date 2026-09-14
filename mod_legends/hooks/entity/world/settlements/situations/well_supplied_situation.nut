::mods_hookExactClass("entity/world/settlements/situations/well_supplied_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {

		_settlement.setResources(_settlement.getResources() * 1.15);

		onAdded(_settlement);
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_modifiers) {
		onUpdate(_modifiers);
		_modifiers.RarityMult *= 1.5 / 1.15;
	}
});
