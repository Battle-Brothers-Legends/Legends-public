::mods_hookExactClass("skills/traits/deathwish_trait", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Does not protect from effects that target morale directly, like Fearsome"
			},
			{
				id = 17,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-3[/color] Melee Defense"
			}
		]);

		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		_properties.MeleeDefense -= 3;
	}
});
