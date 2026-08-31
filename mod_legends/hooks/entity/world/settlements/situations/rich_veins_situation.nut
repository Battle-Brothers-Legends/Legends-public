::mods_hookExactClass("entity/world/settlements/situations/rich_veins_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.25);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Miner, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendIronmonger, 2);
		_draftList.push(::Legends.Background.LegendBlacksmith);
	}
});
