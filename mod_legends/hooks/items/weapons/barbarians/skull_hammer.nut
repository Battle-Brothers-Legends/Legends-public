::mods_hookExactClass("items/weapons/barbarians/skull_hammer", function(o) {
	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestRock);
	}
});