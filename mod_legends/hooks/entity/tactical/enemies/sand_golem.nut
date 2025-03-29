::mods_hookExactClass("entity/tactical/enemies/sand_golem", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.OnDeathLootTable.extend([
			[10, "scripts/items/loot/glittering_rock_item"],
			[5, "scripts/items/trade/uncut_gems_item"]
		]);
		local rolls = ::Legends.S.extraLootChance(::Math.rand(0, 1));
		for (local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([100, "scripts/items/misc/sulfurous_rocks_item"]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			::Legends.Traits.grant(this, ::Legends.Trait.Determined);
		}
	}
});
