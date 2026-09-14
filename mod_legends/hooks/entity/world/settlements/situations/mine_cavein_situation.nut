::mods_hookExactClass("entity/world/settlements/situations/mine_cavein_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.95);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.LegendIronmonger, 3);
		_draftList.push(::Legends.Background.LegendBlacksmith);

		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 4);
		}
	}
});
