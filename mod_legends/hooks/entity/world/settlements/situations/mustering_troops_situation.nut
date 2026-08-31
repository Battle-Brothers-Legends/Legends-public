::mods_hookExactClass("entity/world/settlements/situations/mustering_troops_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.99);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		_draftList.push(::Legends.Background.RetiredSoldier);
		::Legends.S.extend(_draftList, ::Legends.Background.Cripple, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Deserter, 2);

		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendManAtArms, 3);
		}

	}
});
