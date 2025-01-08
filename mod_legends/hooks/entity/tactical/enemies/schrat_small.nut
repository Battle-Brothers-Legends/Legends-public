::mods_hookExactClass("entity/tactical/enemies/schrat_small", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLacerate);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.FastAdaption);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
