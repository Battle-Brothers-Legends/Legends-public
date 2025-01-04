::mods_hookExactClass("items/weapons/staff_sling", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A leather sling on a staff, used to hurl stones at the enemy. It is lighter than its northern cousin and with stones abundant everywhere, it will never run out of ammunition.";
		this.m.Categories = "Sling, Two-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
	}
});
