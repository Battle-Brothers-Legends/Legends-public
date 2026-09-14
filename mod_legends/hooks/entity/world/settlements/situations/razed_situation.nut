::mods_hookExactClass("entity/world/settlements/situations/razed_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.80);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Beggar, 3);
		::Legends.S.extend(_draftList, ::Legends.Background.Cripple, 3);
		_draftList.push(::Legends.Background.Graverobber);
		_draftList.push(::Legends.Background.Raider);

		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 9);
		} else if (::World.Assets.getOrigin().getID() == "scenario.legends_berserker") {
			_draftList.push(::Legends.Background.LegendBerserker);
		}
	}
});
