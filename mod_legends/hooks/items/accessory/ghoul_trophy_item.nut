::mods_hookExactClass("items/accessory/ghoul_trophy_item", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=%negative%]-3[/color]"
		});
		return result;
	}

	o.onUpdateProperties = function ( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.Bravery += 4;
		_properties.Threat += 3;
	}
});
