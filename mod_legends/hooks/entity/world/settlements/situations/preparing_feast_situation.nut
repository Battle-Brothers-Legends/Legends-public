::mods_hookExactClass("entity/world/settlements/situations/preparing_feast_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Butcher, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Servant, 3);
		_draftList.push(::Legends.Background.Eunuch);
	}
});
