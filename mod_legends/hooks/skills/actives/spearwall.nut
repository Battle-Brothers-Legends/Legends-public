::mods_hookExactClass("skills/actives/spearwall", function(o)
{
	local getDescription = o.getDescription;
	o.getDescription = function ()
	{
		return getDescription() + " Attacks from this ability are considered attacks of opportunity."
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecSpearWall))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]25%[/color] bonus damage on attacks made by Spearwall from [color=#008060]Spearwaller[/color]"
			});
		}
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistMilitia))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]15%[/color] bonus damage on attacks made by Spearwall from [color=#008060]Militia Practice[/color]"
			});
		}

		return tooltip;
	}
});
