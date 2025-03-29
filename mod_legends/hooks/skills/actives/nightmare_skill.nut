::mods_hookExactClass("skills/actives/nightmare_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IconDisabled = "skills/active_117_sw.png";
	}

	o.getDamage = function ( _actor )
	{
		if (_actor == null)
			return;
		return this.Math.max(5, 25 - this.Math.floor(_actor.getCurrentProperties().getBravery() * 0.25));
	}
});
