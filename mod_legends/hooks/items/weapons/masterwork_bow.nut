::mods_hookExactClass("items/weapons/masterwork_bow", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.TwoHanded;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendFullDraw);
		::Legends.Actives.grant(this, ::Legends.Active.LegendVolley);
		::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
	}
});
