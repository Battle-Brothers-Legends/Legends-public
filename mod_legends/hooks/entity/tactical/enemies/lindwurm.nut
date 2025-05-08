::mods_hookExactClass("entity/tactical/enemies/lindwurm", function(o)
{
	o.m.DroppableRunes <- [
		::Legends.Rune.LegendRsaEndurance,
		::Legends.Rune.LegendRsaSafety
	];

	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.push([1, function () {
				local selected = this.m.DroppableRunes[::Math.rand(0, this.m.DroppableRunes.len() - 1)];
				local rune = ::new(::Legends.Runes.get(selected).Script);
				rune.setRuneVariant(selected);
				rune.setRuneBonus(true);
				return rune;
			}.bindenv(this)]);
		}
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);

		}
	}
});
