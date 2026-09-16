::mods_hookExactClass("items/weapons/wonky_bow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Shortbow;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendVolley);
	}
});
