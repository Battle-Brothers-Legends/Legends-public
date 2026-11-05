::mods_hookExactClass("entity/world/settlements/situations/cultist_procession_situation", function (o) {
	o.onUpdateDraftList <- function (_draftList) {
		::Legends.Array.extend(_draftList, ::Legends.Background.Cultist, 16);

		_draftList.push(::Legends.Background.Flagellant);
		_draftList.push(::Legends.Background.Butcher);

		if (::World.Assets.getOrigin().getID() == "scenario.cultists") {
			::Legends.Array.extend(_draftList, ::Legends.Background.LegendHusk, 2);
			::Legends.Array.extend(_draftList, ::Legends.Background.LegendLurker, 4);
			_draftList.push(::Legends.Background.LegendMagister);
		}
	}
});
