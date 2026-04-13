::mods_hookExactClass("items/weapons/named/named_two_handed_flail", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [1, 2, 3, 4, 5];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Cultist;
	}
});
