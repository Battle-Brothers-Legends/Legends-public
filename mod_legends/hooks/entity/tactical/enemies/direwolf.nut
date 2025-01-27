::mods_hookExactClass("entity/tactical/enemies/direwolf", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendWerewolf);
		}
	}
});
