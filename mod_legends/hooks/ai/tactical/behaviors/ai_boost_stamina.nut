::mods_hookExactClass("ai/tactical/behaviors/ai_boost_stamina", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendDrumsOfLife),
		::Legends.Actives.getID(::Legends.Active.LegendDrumsOfWar),
		::Legends.Actives.getID(::Legends.Active.LegendPushForward),
		::Legends.Actives.getID(::Legends.Active.LegendHoldTheLine)
	]);
});