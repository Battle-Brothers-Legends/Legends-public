::mods_hookExactClass("skills/actives/shatter_skill", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = -10;
	}

	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]33%[/color] chance to stagger on a hit"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]33%[/color] chance to knock back on a hit"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can hit up to 3 targets"
			}
		]);
		return ret;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				this.m.HitChanceBonus += 5;
				_properties.MeleeSkill -= 5;
			}
		}
	}
});
