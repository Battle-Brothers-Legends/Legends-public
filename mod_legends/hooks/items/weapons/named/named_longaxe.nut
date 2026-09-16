::mods_hookExactClass("items/weapons/named/named_longaxe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4,5];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.WeaponType = ::Const.Items.WeaponType.Axe | ::Const.Items.WeaponType.Polearm;
		this.setCategories("Axe/Polearm, Two-Handed");
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
	}
});
