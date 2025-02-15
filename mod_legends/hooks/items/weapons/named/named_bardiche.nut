::mods_hookExactClass("items/weapons/named/named_bardiche", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Swing, function (_skill) {
			_skill.setApplyAxeMastery(true);
		}.bindenv(this));
	}
});
