::mods_hookExactClass("skills/actives/prong_skill", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] tiles"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		return tooltip;
	}
});
