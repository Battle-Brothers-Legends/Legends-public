::mods_hookExactClass("skills/actives/horror_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Blare out a piercing, unworldly sound that is more than likely to distress anyone unfortunate enough to hear.";
	}

	o.getTooltip <- function () {
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 4,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Triggers a morale check for with a penalty of [color=%negative%]-15[/color]"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Targets failing a morale check with a penalty of [color=%negative%]-5[/color] are Horrified and unable to act"
			}
		]);
		return ret;
	}
});
