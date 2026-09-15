::mods_hookExactClass("items/weapons/longaxe", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.WeaponType = ::Const.Items.WeaponType.Axe | ::Const.Items.WeaponType.Polearm;
		this.setCategories("Axe/Polearm, Two-Handed");
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/longaxe_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/longaxe_01" + v + ".png";
		this.m.ArmamentIcon = "icon_longaxe_01" + v;
	}

});
