::mods_hookExactClass("ai/tactical/behaviors/ai_attack_bow", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendCatapultBoulder),
		::Legends.Actives.getID(::Legends.Active.LegendSlingHeavyStone),
		::Legends.Actives.getID(::Legends.Active.LegendShootDart)
	]);
});