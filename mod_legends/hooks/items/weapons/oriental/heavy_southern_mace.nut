::mods_hookExactClass("items/weapons/oriental/heavy_southern_mace", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2100;
	}
});
