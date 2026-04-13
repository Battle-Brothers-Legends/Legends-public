::mods_hookExactClass("skills/traits/disloyal_trait", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.push({
			id = 17,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%positive%]+10[/color] Melee Defense while retreating"
		});
		return ret;
	}
});
