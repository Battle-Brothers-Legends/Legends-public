::mods_hookExactClass("ai/tactical/behaviors/ai_darkflight", function(o) 
{
	o.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendTeleport));
});