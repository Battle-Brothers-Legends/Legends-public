::mods_hookExactClass("ai/tactical/behaviors/ai_attack_decapitate", function(o) 
{
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendVoulgeDecapitate));
});