::mods_hookExactClass("items/weapons/oriental/firelance", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.ItemType = this.Const.Items.ItemType.Weapon;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/firelance_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/firelance_01" + v + ".png";
		this.m.ArmamentIcon = "icon_firelance_01" + v;
	}

	o.updateEmptyVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/firelance_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/firelance_01" + v + ".png";
		this.m.ArmamentIcon = "icon_firelance_01" + v + "_empty";
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}


	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Ammo > 0) {
			this.updateVariant();
		} else {
			this.updateEmptyVariant();
		}
		this.updateAppearance();
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.IgniteFirelance);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Spearwall);
	}

});
