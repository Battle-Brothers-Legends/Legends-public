::mods_hookExactClass("items/special/golden_goose_item", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();
		local index = 0;
		foreach (i, r in result)
			if (r.id == 15) {
				index = i;
				break;
			}

		result[index] = {
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Generates [color=%positive%]50[/color] crowns daily."
		};
		return result;
	}
});
