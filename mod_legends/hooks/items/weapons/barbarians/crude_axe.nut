::mods_hookExactClass("items/weapons/barbarians/crude_axe", function(o) {
	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
	}
});