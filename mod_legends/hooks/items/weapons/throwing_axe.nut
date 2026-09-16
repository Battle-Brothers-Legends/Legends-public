::mods_hookExactClass("items/weapons/throwing_axe", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon/Axe, One-Handed";
		this.m.WeaponType = ::Const.Items.WeaponType.Throwing | ::Const.Items.WeaponType.Axe;
		this.m.ArmorDamageMult = 1.3;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.OneHanded;
		this.m.Variant = ::Math.rand(0, 2);
		this.m.Ammo = 6;
		this.m.AmmoMax = 6;
		this.updateVariant();
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/throwing_axes_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/throwing_axes_01" + v + ".png";
		this.m.ArmamentIcon = "icon_throwing_axes_01" + v;
	}

	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Variant == 0) {
			return;
		}
		if (this.m.Ammo > 0) {
			this.updateVariant();
			this.updateAppearance();
		}
	}

});
