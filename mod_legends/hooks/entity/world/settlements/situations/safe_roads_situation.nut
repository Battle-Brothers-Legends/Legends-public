::mods_hookExactClass("entity/world/settlements/situations/safe_roads_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.1);
		onAdded(_settlement);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.AdventurousNoble, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.CaravanHand, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.Peddler, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.Sellsword, 2);
		_draftList.push(::Legends.Background.Vagabond);
		_draftList.push(::Legends.Background.Messenger);
		_draftList.push(::Legends.Background.Gambler);
		_draftList.push(::Legends.Background.Tailor);
		_draftList.push(::Legends.Background.Minstrel);
		_draftList.push(::Legends.Background.Historian);
		_draftList.push(::Legends.Background.LegendDonkey);

		if (::World.Assets.getOrigin().getID() == "scenario.legends_crusader") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPilgrim, 6);
		} else if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push(::Legends.Background.LegendManAtArms);
			::Legends.S.extend(_draftList, ::Legends.Background.LegendLeechPeddler, 4);
		}
	}
});
