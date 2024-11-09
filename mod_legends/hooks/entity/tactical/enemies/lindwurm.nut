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
				local chance = 1;
				if (this.LegendsMod.Configs().LegendMagicEnabled())
				{
					chance = 10;
				}

				if (this.Math.rand(1, 100) <= chance)
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
