::mods_hookExactClass("items/weapons/masterwork_bow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.MaxRange = 8;
		this.m.RangeIdeal = 8;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendFullDraw);
		::Legends.Actives.grant(this, ::Legends.Active.LegendVolley);
		::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
	}
});
