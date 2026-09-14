::mods_hookExactClass("ai/tactical/behaviors/ai_disengage", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.Footwork),
		::Legends.Actives.getID(::Legends.Active.LegendHorsePirouette)
	]);
});