::mods_hookExactClass("entity/world/settlements/situations/seasonal_fair_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Rumors.push("Big fairs like the one over in %settlement% attract the worst kinds of people, minstrels and troubadours.");
	}

	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.1);
		onAdded(_settlement);
	}

	o.onUpdateDraftList = function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Peddler, 18);
		::Legends.S.extend(_draftList, ::Legends.Background.Juggler, 3);
		::Legends.S.extend(_draftList, ::Legends.Background.Minstrel, 3);
		::Legends.S.extend(_draftList, ::Legends.Background.LegendMasterArcher, 4);

		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendLeechPeddler, 8);
		} else if (::World.Assets.getOrigin().getID() == "scenario.legends_troupe") {
			_draftList.push(::Legends.Background.LegendIllusionist);
		}
	}
});
