::mods_hookExactClass("items/weapons/reinforced_wooden_flail", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/flail_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/flail_03" + v + ".png";
		this.m.ArmamentIcon = "icon_flail_03" + v;
	}

});
