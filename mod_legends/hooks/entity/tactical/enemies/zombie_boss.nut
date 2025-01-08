::mods_hookExactClass("entity/tactical/enemies/zombie_boss", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
		}
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLastStand);
		}
	}
});
