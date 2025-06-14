::mods_hookExactClass("skills/actives/hail_skill", function(o)
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make three separate strikes for one third of the weapon\'s damage each."
			}
		]);

		return ret;
	}


});
