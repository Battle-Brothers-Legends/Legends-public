::mods_hookExactClass("items/weapons/greenskins/orc_axe_2h", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/orc_axe_two_handed" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_axe_two_handed" + v + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_01" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}

});
