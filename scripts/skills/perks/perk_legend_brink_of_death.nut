this.perk_legend_brink_of_death <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBrinkOfDeath);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
