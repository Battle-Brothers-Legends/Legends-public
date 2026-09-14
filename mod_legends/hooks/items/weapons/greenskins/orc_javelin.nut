::mods_hookExactClass("items/weapons/greenskins/orc_javelin", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.Value = 200;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.35;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.Icon = "weapons/ranged/orc_javelins_70x70.png";
			this.m.IconLarge = "weapons/ranged/orc_javelins.png";
			this.m.ArmamentIcon = "icon_javelin_01"; // this shit is so ass
		} else {
			this.m.Icon = "weapons/ranged/orc_javelins_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/ranged/orc_javelins_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_orc_javelin_01_" + this.getVariant();
		}
	}

	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Ammo > 0) {
			this.updateVariant();
			this.updateAppearance();
		}
	}

});
