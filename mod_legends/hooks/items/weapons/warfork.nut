::mods_hookExactClass("items/weapons/warfork", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.Pitchfork;
	}
});
