::mods_hookExactClass("ai/tactical/behaviors/ai_wither", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendWither)
	]);
});