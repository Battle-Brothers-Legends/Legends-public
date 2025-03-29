::mods_hookExactClass("items/weapons/oriental/handgonne", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.m.IsLoaded = true;
	}
});
