::mods_hookExactClass("skills/actives/flail_skill", function(o)
{
	o.m.IsChain <- false;

	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsChain)
		{
			this.m.Name = "Chain Flail";
			this.m.MaxRange = 3;
			this.m.Icon = "skills/active_62.png";
			this.m.IconDisabled = "skills/active_62_sw.png";
			this.m.Overlay = "active_62";
		}
	}

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.IsChain)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]3[/color] tiles"
			});
		}

		return ret;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.IsChain)
		{
			_properties.MeleeSkill -= 10;
		}
	}

});
