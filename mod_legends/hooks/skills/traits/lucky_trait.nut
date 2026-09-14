::mods_hookExactClass("skills/traits/lucky_trait", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]10%[/color] chance to reroll a missed attack"
		});

		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		_properties.RerollAttackChance += 10;
	}
});