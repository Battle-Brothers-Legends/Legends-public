::mods_hookExactClass("items/weapons/named/named_spear", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3, 4, 5, 6];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.AmmoCost = 5;
		this.m.WeaponType = ::Const.Items.WeaponType.Spear;
	}

	o.randomizeValues <- function () {
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.named_weapon.randomizeValues();
	}

	o.getAmmo <- function () {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function () {
		return this.m.AmmoMax;
	}

	o.onEquip = function () {
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this, ::Legends.Active.Spearwall);
		::Legends.Actives.grant(this, ::Legends.Active.LegendThrowBackupSpear);
	}
});
