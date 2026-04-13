this.perk_legend_guide_steps <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendGuideSteps);
	}


	function onCombatStarted()
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
		foreach( a in actors )
			::Legends.Perks.grant(a, ::Legends.Perk.Pathfinder);
	}

});
