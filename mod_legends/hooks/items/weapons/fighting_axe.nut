::mods_hookExactClass("items/weapons/fighting_axe", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2350;
	}
});
