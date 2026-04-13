::mods_hookExactClass("entity/tactical/goblin", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		// ::Legends.Perks.grant(this, ::Legends.Perk.LegendTumble);
	}
});
