::mods_hookExactClass("skills/actives/round_swing", function(o)
{
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 6 targets"
		});

		return tooltip;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.HitChanceBonus += 5;
			}
		}
	}

});
