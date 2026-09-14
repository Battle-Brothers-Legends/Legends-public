::mods_hookExactClass("entity/world/settlements/situations/conquered_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.8);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Refugee, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Cripple, 2);
		_draftList.push(::Legends.Background.Vagabond);
		::Legends.S.extend(_draftList, ::Legends.Background.Gravedigger, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Beggar, 3);

		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 4);
		}

	}
});
