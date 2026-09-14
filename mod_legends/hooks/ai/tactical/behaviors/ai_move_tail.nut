::mods_hookExactClass("ai/tactical/behaviors/ai_move_tail", function(o) 
{
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendStollwurmMoveTail));
});