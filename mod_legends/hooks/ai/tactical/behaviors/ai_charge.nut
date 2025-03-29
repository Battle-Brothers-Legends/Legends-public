::mods_hookExactClass("ai/tactical/behaviors/ai_charge", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.Charge),
		::Legends.Actives.getID(::Legends.Active.UnstoppableCharge),
		::Legends.Actives.getID(::Legends.Active.LegendHorseCharge)
	]);
});