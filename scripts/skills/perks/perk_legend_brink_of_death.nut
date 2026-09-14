this.perk_legend_brink_of_death <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBrinkOfDeath);
	}


	function onCombatStarted()
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		foreach( a in actors )
		{
			if (a.isStabled()) // exclude donkeys
				continue;
			if (!a.getSkills().hasTrait(::Legends.Trait.Survivor))
				::Legends.Traits.grant(a, ::Legends.Trait.LegendDeathlySpectre);
		}
	}

});
