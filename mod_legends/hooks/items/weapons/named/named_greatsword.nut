::mods_hookExactClass("items/weapons/named/named_greatsword", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.Description = "This zweihander is a true masterpiece, with a blade that is both flexible yet extremely durable.";
	}
});
