::mods_hookExactClass("items/weapons/greenskins/orc_axe", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 5;
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/orc_axe" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_axe" + v + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_02" + v;
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}

	local onEquip = o.onEquip;
	o.onEquip = function()
	{
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.ThrowAxe, function (_skill) {
			_skill.m.IsBackupAxe = true;
		}.bindenv(this));
	}

});
