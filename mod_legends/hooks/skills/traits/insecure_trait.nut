::mods_hookExactClass("skills/traits/insecure_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "I can\'t do it! This character cowers, dodges and could use a bit more self confidence.";
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.extend([{
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%positive%]+5%[/color] Melee Defense"
		},
		{
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%positive%]+5%[/color] Ranged Defense"
		}]);

		return ret;
	}

	o.onUpdate <- function ( _properties )
	{
		_properties.MeleeDefenseMult *= 1.05;
		_properties.RangedDefenseMult *= 1.05;
	}
});
