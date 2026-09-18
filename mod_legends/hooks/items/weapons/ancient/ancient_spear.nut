::mods_hookExactClass("items/weapons/ancient/ancient_spear", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 5;
		this.m.WeaponType = ::Const.Items.WeaponType.Spear;
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this, ::Legends.Active.Spearwall);
		::Legends.Actives.grant(this, ::Legends.Active.LegendThrowBackupSpear);
	}
});
