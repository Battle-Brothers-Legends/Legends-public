::mods_hookExactClass("items/weapons/greenskins/orc_metal_club", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	// ofc the original is misnamed
	o.updateVariant <- function() {
		if (this.getVariant() == 0)
		{
			this.m.IconLarge = "weapons/melee/orc_club_02_140x70.png";
			this.m.Icon = "weapons/melee/orc_club_02_70x70.png";
			this.m.ArmamentIcon = "icon_orc_weapon_07";
			return;
		}
		local v = this.getVariant();
		this.m.Icon = "weapons/melee/orc_club_02_" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_club_02_" + v + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_07_" + v;
	}

});
