::mods_hookExactClass("ai/tactical/behaviors/ai_attack_swing", function (o) {
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendDoubleSwing),
		::Legends.Actives.getID(::Legends.Active.LegendHarvest),
		::Legends.Actives.getID(::Legends.Active.LegendBearClaws),
		::Legends.Actives.getID(::Legends.Active.LegendSkinGhoulClaws),
	]);
});
