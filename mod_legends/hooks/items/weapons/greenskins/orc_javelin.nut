::mods_hookExactClass("items/weapons/greenskins/orc_javelin", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Throwing Weapon, Spear, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.35;
	}
});
