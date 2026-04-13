::mods_hookExactClass("items/weapons/oriental/nomad_mace", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wooden_nomad_mace_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wooden_nomad_mace_01" + v + ".png";
		this.m.ArmamentIcon = "icon_nomad_mace_01" + v;
	}

});
