::mods_hookExactClass("entity/world/settlements/situations/witch_burnings_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.05);
		onAdded(_settlement);
	}

	o.onUpdateDraftList = function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Witchhunter, 22);
	}
});
