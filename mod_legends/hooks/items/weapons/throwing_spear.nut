::mods_hookExactClass("items/weapons/throwing_spear", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Spear;
		this.m.Description = "Lighter than a common spear, but heavier than a javelin, this weapon is intended to be thrown over short distances. The tip will bend on impact, potentially rendering shields unusable. Can be used against unshielded opponents as well for great effect.";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.Value = 400;
		this.m.RangeMin = 1;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 6;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/throwing_spear_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/throwing_spear_01" + v + ".png";
		this.m.ArmamentIcon = "icon_throwing_spear_01" + v;
	}

	o.getTooltip = function ()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Requires 6 ammunition to replenish after battle"
		});
		return result;
	}

	o.isAmountShown <- function ()
	{
		return true;
	}

	o.getAmountString <- function ()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	o.setAmmo <- function(_a) {
		this.weapon.setAmmo(_a);
		if (this.m.Ammo > 0) {
			this.m.Name = "Throwing Spear";
			this.updateVariant();
			this.m.ShowArmamentIcon = true;
		} else {
			this.m.Name = "Throwing Spear (Used)";
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png";
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png";
			this.m.ShowArmamentIcon = false;
		}
		this.updateAppearance();
	}

});
