::mods_hookExactClass("items/weapons/oriental/saif", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Sword, Cleaver, One-Handed";
	}
});
