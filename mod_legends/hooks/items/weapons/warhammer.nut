::mods_hookExactClass("items/weapons/warhammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2500;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/warhammer_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/warhammer_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_warhammer_01_" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPryArmor);
	}

});
