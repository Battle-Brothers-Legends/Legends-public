::mods_hookExactClass("entity/world/settlements/situations/arena_tournament_situation", function (o) {
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function (_draftList) {
		onUpdateDraftList(_draftList);
		::Legends.Array.extend(_draftList, ::Legends.Background.LegendGladiatorPrizefighter, 4);
	}

});
