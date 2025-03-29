::mods_hookExactClass("items/weapons/two_handed_flanged_mace", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 3000;
	}
});
