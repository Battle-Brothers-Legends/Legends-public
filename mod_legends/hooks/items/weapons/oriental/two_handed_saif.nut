::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2400;
		this.m.Categories = "Sword, Cleaver, Two-Handed";
	}
});
