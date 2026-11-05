::mods_hookExactClass("entity/world/settlements/situations/rebuilding_effort_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.95);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		if (this.m.IsSouthern) {
			// Necro: "this.m.IsSouthern" is always false, i don't get how this would work
			::Legends.Array.extend(_draftList, ::Legends.Background.DaytalerSouthern, 4);
			::Legends.Array.extend(_draftList, ::Legends.Background.SlaveSouthern, 6);
		} else {
			::Legends.Array.extend(_draftList, ::Legends.Background.Lumberjack, 2);
			::Legends.Array.extend(_draftList, ::Legends.Background.Mason, 2);
			::Legends.Array.extend(_draftList, ::Legends.Background.Daytaler, 3);
			_draftList.push(::Legends.Background.LegendInventor);
		}

		::Legends.Array.extend(_draftList, ::Legends.Background.LegendBlacksmith, 3);
	}
});
