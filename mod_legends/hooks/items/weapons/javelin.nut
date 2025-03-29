::mods_hookExactClass("items/weapons/javelin", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Throwing Weapon, Spear, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
	}
});
