::mods_hookExactClass("items/weapons/scimitar", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.Categories = "Cleaver/Sword, One-Handed";
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/scimitar_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/scimitar_02" + v + ".png";
		this.m.ArmamentIcon = "icon_scimitar_02" + v;
	}

});
