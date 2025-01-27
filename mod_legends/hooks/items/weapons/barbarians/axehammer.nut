::mods_hookExactClass("items/weapons/barbarians/axehammer", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Hammer, Axe, One-Handed";
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestRock);
	}
});