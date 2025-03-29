::mods_hookExactClass("items/weapons/named/named_two_handed_scimitar", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
		this.m.Categories = "Cleaver, Sword, Two-Handed";
	}
});
