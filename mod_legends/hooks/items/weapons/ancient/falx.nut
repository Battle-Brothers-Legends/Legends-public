::mods_hookExactClass("items/weapons/ancient/falx", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variant = this.Math.rand(0, 1);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/falx_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/falx_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_falx_01_" + this.m.Variant;
	}

});
