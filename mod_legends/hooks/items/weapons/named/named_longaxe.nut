::mods_hookExactClass("items/weapons/named/named_longaxe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
	}
});
