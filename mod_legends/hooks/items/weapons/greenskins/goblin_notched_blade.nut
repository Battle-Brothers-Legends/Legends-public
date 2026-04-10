::mods_hookExactClass("items/weapons/greenskins/goblin_notched_blade", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.setVariant(this.Math.rand(0, 1));
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
		this.m.AmmoCost = 1;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/goblin_weapon_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goblin_weapon_01" + v + ".png";
		this.m.ArmamentIcon = "icon_goblin_weapon_01" + v;
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
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendThrowKnife);
	}

});
