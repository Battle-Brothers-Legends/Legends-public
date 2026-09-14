::mods_hookExactClass("entity/world/settlements/situations/mirage_sightings_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);
		onAdded(_settlement);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);
	}

	o.onUpdateDraftList <- function (_draftList) {
		if (::World.Assets.getOrigin().getID() == "scenario.legends_seer" && ::Math.rand(0, 5) == 1) {
			_draftList.push(::Legends.Background.LegendIllusionist);
		} else if (::Math.rand(0, 9) == 1) {
			_draftList.push(::Legends.Background.LegendIllusionist);
		}
	}
});
