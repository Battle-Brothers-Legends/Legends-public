::mods_hookExactClass("factions/contracts/hunting_serpents_action", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}
});