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

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.MeleeSkill -= 10;
				this.m.HitChanceBonus += 5;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
		}
	}
});
