::mods_hookExactClass("items/weapons/named/named_billhook", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
	}
});
