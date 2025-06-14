::mods_hookExactClass("skills/actives/lash_skill", function(o)
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();

		return ret;
	}


});
