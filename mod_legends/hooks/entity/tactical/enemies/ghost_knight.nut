::mods_hookExactClass("entity/tactical/enemies/ghost_knight", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Fearsome);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Footwork);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLevitate);
		}
	}
});
