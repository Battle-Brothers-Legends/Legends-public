::mods_hookExactClass("items/weapons/two_handed_flail", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2800;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;	
	}
});
