::mods_hookExactClass("entity/tactical/enemies/hyena", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		if (::Legends.isLegendaryDifficulty())
		{
			this.m.ActionPoints = b.ActionPoints + 2;
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			::Legends.Traits.grant(this, ::Legends.Trait.IronJaw);
		};
	}
});
