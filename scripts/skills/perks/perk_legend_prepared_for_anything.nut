this.perk_legend_prepared_for_anything <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPreparedForAnything);
	}


	function onCombatStarted()
	{
		local actors = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);
		foreach( a in actors )
			::Legends.Perks.grant(a, ::Legends.Perk.BagsAndBelts);
	}

});
