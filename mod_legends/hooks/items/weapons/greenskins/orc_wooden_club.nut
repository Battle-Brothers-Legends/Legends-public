::mods_hookExactClass("items/weapons/greenskins/orc_wooden_club", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.IconLarge = "weapons/melee/orc_club_01_140x70.png";
			this.m.Icon = "weapons/melee/orc_club_01_70x70.png";
			this.m.ArmamentIcon = "icon_orc_weapon_06";
		} else {
			this.m.Icon = "weapons/melee/orc_club_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/melee/orc_club_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_orc_weapon_06_" + this.getVariant();
		}
	}

});
