::mods_hookExactClass("items/weapons/named/named_pike", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
	}
});
