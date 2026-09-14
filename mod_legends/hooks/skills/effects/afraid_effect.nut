::mods_hookExactClass("skills/effects_world/afraid_effect", function(o) {

	o.m.HealChance <- 25;
	o.setHealChance <- function( _i )
	{
		this.m.HealChance = _i;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
		ret.push({
			id = 17,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%negative%]" + this.m.HealChance + "%[/color] chance to remove itself on the start of each new day"
		});

		return ret;
	}

	o.onNewDay = function ()
	{
		if (this.Math.rand(1, 100) <= this.m.HealChance)
		{
			this.removeSelf();
		}
	}
});
