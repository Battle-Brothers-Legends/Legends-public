::mods_hookExactClass("entity/tactical/enemies/lindwurm", function(o)
{
	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			for( local i = 0; i < n; i = ++i )
			{
				if (this.Math.rand(1, 100) <= 1)
				{
					local rune;
					local variant = this.Math.rand(21, 22);
					switch (variant)
					{
						case 21:
						rune = this.new("scripts/items/legend_armor/runes/legend_rune_endurance");
						break;

						case 22:
						rune = this.new("scripts/items/legend_armor/runes/legend_rune_safety");
						break
					}
					rune.setRuneVariant(variant);
					rune.setRuneBonus(true);
					rune.setRuneVariant(0);
					rune.drop(_tile);
				}
			}
		}
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMuscularity);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.KillingFrenzy);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
