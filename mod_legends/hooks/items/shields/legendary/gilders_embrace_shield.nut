::mods_hookExactClass("items/shields/legendary/gilders_embrace_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsIndestructible = true;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function (){
		local result = getTooltip();
		foreach (tooltip in result) {
			if (!tooltip.rawin("id") || !tooltip.rawin("text") || !tooltip.rawin("icon")) {
				continue;
			}

			if (tooltip.id == 7 && tooltip.icon == "ui/icons/fatigue.png") {
				tooltip.text = "Fatigue Weight Penalty [color=%negative%]" + this.m.StaminaModifier + "[/color]"
			}
		}
		return result;
	}
});
