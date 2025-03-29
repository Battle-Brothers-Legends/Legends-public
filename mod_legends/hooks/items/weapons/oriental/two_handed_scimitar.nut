::mods_hookExactClass("items/weapons/oriental/two_handed_scimitar", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Sword, Cleaver, Two-Handed";
		this.m.Value = 2900;
	}
});
