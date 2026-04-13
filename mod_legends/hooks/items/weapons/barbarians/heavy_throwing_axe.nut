::mods_hookExactClass("items/weapons/barbarians/heavy_throwing_axe", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon/Axe, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Axe;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.ArmorDamageMult = 1.4;
		this.m.Ammo = 4;
		this.m.AmmoMax = 4;
		this.setVariant(this.Math.rand(0, 1));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/throwing_axes_heavy_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/throwing_axes_heavy_01" + v + ".png";
		this.m.ArmamentIcon = "icon_throwing_axes_heavy_01" + v;
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
