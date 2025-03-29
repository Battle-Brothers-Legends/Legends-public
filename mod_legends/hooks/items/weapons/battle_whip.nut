::mods_hookExactClass("items/weapons/battle_whip", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Cleaver, Whip, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
	}
});
