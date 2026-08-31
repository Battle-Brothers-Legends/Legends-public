::mods_hookExactClass("entity/world/settlements/situations/good_harvest_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.1);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Farmhand, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.Miller, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendHerbalist);
	}
});
