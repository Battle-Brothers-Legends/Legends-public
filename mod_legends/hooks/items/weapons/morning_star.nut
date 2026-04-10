::mods_hookExactClass("items/weapons/morning_star", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 600;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/morning_star_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/morning_star_01" + v + ".png";
		this.m.ArmamentIcon = "icon_morning_star_01" + v;
	}

});
