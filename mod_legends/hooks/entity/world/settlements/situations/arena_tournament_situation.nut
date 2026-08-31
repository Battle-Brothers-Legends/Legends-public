::mods_hookExactClass("entity/world/settlements/situations/arena_tournament_situation", function (o) {
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function (_draftList) {
		onUpdateDraftList(_draftList);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendGladiatorPrizefighter, 4);
	}

});
