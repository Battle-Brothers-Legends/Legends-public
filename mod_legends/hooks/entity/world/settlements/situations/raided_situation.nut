::mods_hookExactClass("entity/world/settlements/situations/raided_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.85);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		_draftList.push(::Legends.Background.Refugee);
		::Legends.S.extend(_draftList, ::Legends.Background.Cripple, 2);
		_draftList.push(::Legends.Background.Vagabond);
		_draftList.push(::Legends.Background.Gravedigger);
		_draftList.push(::Legends.Background.Beggar);

		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 5);
		} else if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendManAtArms, 2);
		}
	}
});
