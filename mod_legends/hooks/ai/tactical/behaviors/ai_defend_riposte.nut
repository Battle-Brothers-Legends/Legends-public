::mods_hookExactClass("ai/tactical/behaviors/ai_defend_riposte", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendStaffRiposte),
		::Legends.Actives.getID(::Legends.Active.ReturnFavor)
	]);
});