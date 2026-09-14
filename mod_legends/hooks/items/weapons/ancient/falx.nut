::mods_hookExactClass("items/weapons/ancient/falx", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 1));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/falx_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/falx_01" + v + ".png";
		this.m.ArmamentIcon = "icon_falx_01" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDebilitate);
	}
});
