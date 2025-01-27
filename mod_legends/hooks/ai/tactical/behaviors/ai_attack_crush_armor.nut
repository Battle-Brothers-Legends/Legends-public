::mods_hookExactClass("ai/tactical/behaviors/ai_attack_crush_armor", function(o) 
{
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendHalberdSmite));
});