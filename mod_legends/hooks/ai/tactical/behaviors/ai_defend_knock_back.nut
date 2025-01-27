::mods_hookExactClass("ai/tactical/behaviors/ai_defend_knock_back", function ( o )
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendRevolt),
		::Legends.Actives.getID(::Legends.Active.LegendPush)
	]);
});
