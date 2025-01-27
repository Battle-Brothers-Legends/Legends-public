::mods_hookExactClass("ai/tactical/behaviors/ai_line_breaker", function(o) 
{
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendBoarCharge));
});