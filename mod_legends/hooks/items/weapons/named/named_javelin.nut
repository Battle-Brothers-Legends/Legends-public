::mods_hookExactClass("items/weapons/named/named_javelin", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Categories = "Throwing Weapon/Spear, One-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Spear;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.OneHanded;
		this.m.Ammo = 6;
		this.m.AmmoMax = 6;
		this.updateVariant();
		this.randomizeValues();
	}

	// o.setAmmo = function ()
	// {
	// 	this.named_weapon.setAmmo(_a);
	// 	this.updateVariant();
	// 	this.updateAppearance();
	// }
});
