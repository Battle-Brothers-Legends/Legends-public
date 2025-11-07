this.perk_legend_teacher <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTeacher);
	}


	function onCombatStarted()
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
		foreach( a in actors )
			::Legends.Perks.grant(a, ::Legends.Perk.Student);
	}

});
