::mods_hookExactClass("items/weapons/three_headed_flail", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2200;
	}
});
