::mods_hookExactClass("entity/tactical/enemies/zombie_betrayer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 5;
			this.m.Hitpoints = b.Hitpoints * 1.5;
		}
	}
});
