::mods_hookExactClass("items/weapons/javelin", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Spear;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.Variant = this.Math.rand(0, 2);
		this.m.Ammo = 6;
		this.m.AmmoMax = 6;
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.Icon = "weapons/ranged/javelins_01_70x70.png";
			this.m.IconLarge = "weapons/ranged/javelins_01.png";
			this.m.ArmamentIcon = "icon_javelin_02"; // this shit is so ass
		} else {
			this.m.Icon = "weapons/ranged/javelins_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/ranged/javelins_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_javelin_01_" + this.getVariant();
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
