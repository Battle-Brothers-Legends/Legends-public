::mods_hookExactClass("items/ammo/large_quiver_of_bolts", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.StaminaModifier = -2;
		this.m.AddGenericSkill = true;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		result = getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.StaminaModifier + "[/color] fatigue"
		});
		return result;
	}
});