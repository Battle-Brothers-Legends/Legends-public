::mods_hookExactClass("entity/world/settlements/situations/slave_revolt_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);
		onAdded(_settlement);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function (_draftList) {
		onUpdateDraftList(_draftList);
		_draftList.push(::Legends.Background.LegendMuladi);
	}
});
