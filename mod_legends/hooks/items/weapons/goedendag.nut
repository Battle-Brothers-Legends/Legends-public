::mods_hookExactClass("items/weapons/goedendag", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Spear, Mace, Two-Handed";
		this.m.Value = 750;
	}
});
