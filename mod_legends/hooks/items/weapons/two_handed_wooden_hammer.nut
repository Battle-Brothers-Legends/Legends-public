::mods_hookExactClass("items/weapons/two_handed_wooden_hammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/hammer_two_handed_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/hammer_two_handed_02" + v + ".png";
		this.m.ArmamentIcon = "icon_hammer_02" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendObliterate);
	}

});
