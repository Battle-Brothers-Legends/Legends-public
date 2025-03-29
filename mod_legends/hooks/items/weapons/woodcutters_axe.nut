::mods_hookExactClass("items/weapons/woodcutters_axe", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 450;
	}
});
