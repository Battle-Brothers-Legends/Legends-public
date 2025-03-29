::mods_hookExactClass("items/weapons/warhammer", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2500;
	}
});
