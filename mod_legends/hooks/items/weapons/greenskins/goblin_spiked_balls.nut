::mods_hookExactClass("items/weapons/greenskins/goblin_spiked_balls", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/goblin_weapon_07" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/goblin_weapon_07" + v + ".png";
		this.m.ArmamentIcon = "icon_goblin_weapon_07" + v;
	}

});
