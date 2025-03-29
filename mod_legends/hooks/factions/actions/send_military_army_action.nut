::mods_hookExactClass("factions/actions/send_military_army_action", function(o) 
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Cooldown = 120.0;
	}
});