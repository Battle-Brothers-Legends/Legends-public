::mods_hookExactClass("entity/world/settlement", function(o) {
	local onEnter = o.onEnter;
	o.onEnter = function()
	{
		local ret = onEnter();

		if (ret)
		{
			local roster = ::World.getPlayerRoster().getAll();
			foreach (bro in roster)
			{
				bro.getSkills().onEnterSettlement(this);
			}
		}

		return ret;
	}
});
