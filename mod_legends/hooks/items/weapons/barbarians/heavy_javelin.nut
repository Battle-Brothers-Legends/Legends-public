::mods_hookExactClass("items/weapons/barbarians/heavy_javelin", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Spear;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.Ammo = 4;
		this.m.AmmoMax = 4;
		this.setVariant(this.Math.rand(0, 1));
		this.m.DirectDamageAdd = 0.1;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/javelins_heavy_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/javelins_heavy_01" + v + ".png";
		this.m.ArmamentIcon = "icon_javelins_heavy_01" + v;
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
