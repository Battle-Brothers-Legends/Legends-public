::mods_hookExactClass("skills/actives/whip_slave_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ActionPointCost = 2;
		this.m.MaxRange = 4;
	}
});
