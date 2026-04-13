::mods_hookExactClass("items/weapons/two_handed_wooden_flail", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/flail_two_handed_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/flail_two_handed_01" + v + ".png";
		this.m.ArmamentIcon = "icon_flail_two_handed_01" + v;
	}

});
