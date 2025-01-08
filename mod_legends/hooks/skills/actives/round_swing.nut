::mods_hookExactClass("skills/actives/round_swing", function(o)
{
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		local hitchanceBonus = this.m.HitChanceBonus;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			hitchanceBonus = hitchanceBonus + 5;
		}

		if (this.getContainer().getActor().getSkills().hasPerk(::Const.Perks.PerkDefs.LegendBloodyHarvest))
			hitchanceBonus += 10;

		if (hitchanceBonus != 0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]" + hitchanceBonus + "%[/color] chance to hit"
			});
		}

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 6 targets"
		});

		return tooltip;
	}

});
