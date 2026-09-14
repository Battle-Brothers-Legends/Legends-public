::mods_hookExactClass("ui/screens/tooltip/tooltip_events", function (o) {

	local onQueryUIElementTooltipData = o.onQueryUIElementTooltipData;
	o.onQueryUIElementTooltipData = function (_entityId, _elementId, _elementOwner) {
		if (_elementId == "faction-trait-tooltip") {
			if (_entityId in ::Const.FactionNobleTraitConfig) {
				local config = ::Const.FactionNobleTraitConfig[_entityId];
				return [
					{
						id = 1,
						type = "title",
						text = config.Name
					},
					{
						id = 2,
						type = "description",
						text = config.Description
					}
				];
			}
		}
		return onQueryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}
});
