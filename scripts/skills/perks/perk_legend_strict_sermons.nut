this.perk_legend_strict_sermons <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStrictSermons);
	}


	function onCombatStarted()
	{
		local actors = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);
		foreach( a in actors )
			::Legends.Perks.grant(a, ::Legends.Perk.FortifiedMind);
	}

});
