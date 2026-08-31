::mods_hookExactClass("entity/world/settlements/situations/hunting_season_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.02);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Hunter, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Poacher, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendTaxidermist, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Houndmaster, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Butcher, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendMasterArcher, 2);
	}
});
