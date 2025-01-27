::mods_hookExactClass("items/weapons/named/named_goblin_heavy_bow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Shortbow;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingShot);
		::Legends.Actives.grant(this, ::Legends.Active.LegendCascade);
	}
});
