::mods_hookExactClass("entity/world/settlements/situations/draught_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function (_draftList) {
		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			_draftList.push(::Legends.Background.LegendPuppet);
		}

		onUpdateDraftList(_draftList);
	}
});
