::mods_hookExactClass("items/weapons/shamshir", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Cleaver/Sword, One-Handed";
	}
});
