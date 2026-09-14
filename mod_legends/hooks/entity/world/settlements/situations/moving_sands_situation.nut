::mods_hookExactClass("entity/world/settlements/situations/moving_sands_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);
		onAdded(_settlement);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);
	}

	o.onUpdateDraftList <- function (_draftList) {
		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 2);
		}
	}
});
