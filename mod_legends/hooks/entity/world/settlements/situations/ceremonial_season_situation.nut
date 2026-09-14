::mods_hookExactClass("entity/world/settlements/situations/ceremonial_season_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Monk, 2);
		_draftList.push(::Legends.Background.Cultist);
		_draftList.push(::Legends.Background.Flagellant);

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendHusk, 2);
			::Legends.S.extend(_draftList, ::Legends.Background.LegendLurker, 3);
			_draftList.push(::Legends.Background.LegendMagister);
		} else if (::World.Assets.getOrigin().getID() == "scenario.legends_crusader") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPilgrim, 17);
		}
	}
});
