::mods_hookExactClass("items/weapons/billhook", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Value = 1875;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/bill_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/bill_01" + v + ".png";
		this.m.ArmamentIcon = "icon_bill_01" + v;
	}

});
