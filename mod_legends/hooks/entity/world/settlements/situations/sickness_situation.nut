::mods_hookExactClass("entity/world/settlements/situations/sickness_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.95);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Cripple, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Beggar, 2);
		_draftList.push(::Legends.Background.Monk);
		_draftList.push(::Legends.Background.LegendHerbalist);

		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 4);
		} else if (this.World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendLeechPeddler, 8);
		}
	}
});
