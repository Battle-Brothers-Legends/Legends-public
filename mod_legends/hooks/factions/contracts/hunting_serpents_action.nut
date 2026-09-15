::mods_hookExactClass("factions/contracts/hunting_serpents_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
	}
});
