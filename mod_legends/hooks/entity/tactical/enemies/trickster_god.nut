::mods_hookExactClass("entity/tactical/enemies/trickster_god", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.OnDeathLootTable.extend([
			[15, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}
});
