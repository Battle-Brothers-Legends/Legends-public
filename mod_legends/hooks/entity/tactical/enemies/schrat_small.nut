::mods_hookExactClass("entity/tactical/enemies/schrat_small", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
			::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
