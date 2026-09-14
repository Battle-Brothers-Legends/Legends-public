::mods_hookExactClass("skills/traits/craven_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Run for your lives! This character is a craven and will run at the slightest sign of the odds turning against them.";
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%positive%]+5[/color] Ranged Defense"
		});

		return ret;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		_properties.RangedDefense += 5;
	}
});
