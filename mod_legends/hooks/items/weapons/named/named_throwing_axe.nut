::mods_hookExactClass("items/weapons/named/named_throwing_axe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Categories = "Throwing Weapon/Axe, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Axe;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.OneHanded;
		this.m.ArmorDamageMult = 1.3;
		this.m.Ammo = 6;
		this.m.AmmoMax = 6;
		this.updateVariant();
		this.randomizeValues();
	}

	o.randomizeValues <- function ()
	{
		this.m.ArmorDamageMult = 1.3;
		named_weapon.randomizeValues();
	}

	// o.setAmmo = function ()
	// {
	// 	this.named_weapon.setAmmo(_a);
	// 	this.updateVariant();
	// 	this.updateAppearance();
	// }
});
