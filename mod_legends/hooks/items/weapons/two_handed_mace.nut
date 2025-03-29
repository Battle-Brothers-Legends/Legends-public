::mods_hookExactClass("items/weapons/two_handed_mace", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1000;
	}
});
