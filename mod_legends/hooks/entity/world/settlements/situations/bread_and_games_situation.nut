::mods_hookExactClass("entity/world/settlements/situations/bread_and_games_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function (_draftList) {
		onUpdateDraftList(_draftList);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendGladiatorPrizefighter, 4);
	}
});
