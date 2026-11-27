::mods_hookExactClass("skills/traits/sure_footing_trait", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%positive%]+3[/color] Block"
		});
		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		_properties.Block += 3;
	}
});
