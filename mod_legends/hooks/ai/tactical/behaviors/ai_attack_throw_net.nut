::mods_hookExactClass("ai/tactical/behaviors/ai_attack_throw_net", function(o) 
{
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendDaze));
});