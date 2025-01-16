::mods_hookExactClass("skills/actives/throw_fire_bomb_skill", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This damage shown only occurs when an enemy ends turn inside of the area, it does not affect the enemy when thrown"
		});
		return ret;
	}
});
