::mods_hookExactClass("ai/tactical/behaviors/ai_adrenaline", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.Adrenaline),
		::Legends.Actives.getID(::Legends.Active.LegendTransformIntoBear)
	]);
});