::mods_hookExactClass("ai/tactical/behaviors/ai_attack_terror", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendBansheeScream),
		::Legends.Actives.getID(::Legends.Active.LegendHorrificScream)
	]);
});