::mods_hookExactClass("entity/world/settlements/situations/mustering_troops_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		_draftList.push(::Legends.Background.RetiredSoldier);
		::Legends.Array.extend(_draftList, ::Legends.Background.Cripple, 2);
		::Legends.Array.extend(_draftList, ::Legends.Background.Deserter, 2);

		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.Array.extend(_draftList, ::Legends.Background.LegendManAtArms, 3);
		}

	}
});
