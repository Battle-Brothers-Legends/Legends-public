::mods_hookExactClass("skills/actives/darkflight", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Icon = "skills/darkflight.png";
		this.m.IconDisabled = "skills/darkflight_bw.png";
	}
});
