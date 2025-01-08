::mods_hookExactClass("entity/tactical/enemies/direwolf_high", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.KillingFrenzy);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Nimble);
		}
	}
});
