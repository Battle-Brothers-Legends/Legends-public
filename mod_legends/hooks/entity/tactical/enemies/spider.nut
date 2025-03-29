::mods_hookExactClass("entity/tactical/enemies/spider", function(o)
{
	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.extend([
				[60, "scripts/items/misc/spider_silk_item"],
				[40, "scripts/items/misc/poison_gland_item"]
			]);
		}
		this.m.OnDeathLootTable.push([1, "scripts/items/loot/webbed_valuables_item"]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLevitate);
			::Legends.Effects.grant(this, ::Legends.Effect.Dodge);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.getLootForTile = function ( _killer, _loot ) {
		return this.actor.getLootForTile(_killer, _loot);
	}
});
