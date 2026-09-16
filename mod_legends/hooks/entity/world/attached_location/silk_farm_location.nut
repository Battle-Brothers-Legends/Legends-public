::mods_hookExactClass("entity/world/attached_location/silk_farm_location", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "In these huts the precious silk is spun from cocoons of small insects by secret methods. Contributes silk, daytalers and belly dancers to the local town.";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function (_list) {
		if (::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue() > 0) {
			_list.push(::Legends.Background.LegendBellyDancer);
			_list.push(::Legends.Background.LegendBellyDancer);
		}

		onUpdateDraftList(_list);
	}

	o.getNewResources <- function () {
		return 2;
	}
});
