::mods_hookExactClass("skills/traits/old_trait", function (o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		foreach (tooltip in ret) {
			if ("icon" in tooltip && tooltip.icon == "ui/icons/initiative.png") {
				tooltip.text = "[color=%negative%]-20[/color] Initiative";
			}
		}
		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		_properties.Initiative -= 10;
	}
});