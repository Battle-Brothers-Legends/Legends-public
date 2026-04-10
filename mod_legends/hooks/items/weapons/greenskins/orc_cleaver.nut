::mods_hookExactClass("items/weapons/greenskins/orc_cleaver", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/orc_cleaver" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_cleaver" + v + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_04" + v;
	}

});
