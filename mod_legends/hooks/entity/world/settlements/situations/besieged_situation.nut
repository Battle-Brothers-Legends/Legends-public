::mods_hookExactClass("entity/world/settlements/situations/besieged_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.75);
		onAdded(_settlement);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.4);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Beggar, 2);
		::Legends.S.extend(_draftList, ::Legends.Background.Cripple, 2);
		_draftList.push(::Legends.Background.Gravedigger);
		_draftList.push(::Legends.Background.Deserter);
		_draftList.push(::Legends.Background.Militia);

		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 3);
		} else if (this.World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendManAtArms, 3);
		}
	}
});
