::mods_hookExactClass("items/weapons/named/named_swordlance", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
	}
});
