::mods_hookExactClass("items/weapons/estoc", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [1];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		this.m.Icon = "weapons/melee/estoc_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/estoc_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_estoc_0" + this.m.Variant;
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.EstocStab);
		::Legends.Actives.grant(this, ::Legends.Active.Perforate);
		::Legends.Actives.grant(this, ::Legends.Active.Skewer);
	}

});
