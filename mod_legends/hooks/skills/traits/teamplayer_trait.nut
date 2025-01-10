::mods_hookExactClass("skills/traits/teamplayer_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character makes sure to always announce their intentions to his brothers-in-arms. In fact, they\'ll never shut the hell up. At least it reduces the chance of accidents happening.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = format("[color=%s]%s[/color], [color=%s]%s[/color] and [color=%s]%s[/color] skills have [color=%s]%s[/color] chance to hit when targeting an allied character"
				, this.Const.UI.Color.NegativeValue, "Knock Back"
				, this.Const.UI.Color.NegativeValue, "Repel"
				, this.Const.UI.Color.NegativeValue, "Hook"
				, this.Const.UI.Color.PositiveValue, "100%"
			)
		});
		
		return ret;
	}
});
