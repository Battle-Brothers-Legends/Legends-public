::mods_hookExactClass("ai/tactical/behaviors/ai_engage_ranged", function(o)
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendMagicMissile),
		::Legends.Actives.getID(::Legends.Active.LegendChainLightning),
		::Legends.Actives.getID(::Legends.Active.LegendCatapultBoulder),
		::Legends.Actives.getID(::Legends.Active.LegendSlingHeavyStone),
		::Legends.Actives.getID(::Legends.Active.LegendShootDart),
		::Legends.Actives.getID(::Legends.Active.LegendShootStone),
		::Legends.Actives.getID(::Legends.Active.LegendShootPreciseStone),
		::Legends.Actives.getID(::Legends.Active.LegendPiercingShot),
		::Legends.Actives.getID(::Legends.Active.LegendPiercingBolt),
		::Legends.Actives.getID(::Legends.Active.ThrowJavelin),
		::Legends.Actives.getID(::Legends.Active.ThrowAxe),
		::Legends.Actives.getID(::Legends.Active.ThrowSpear),
		::Legends.Actives.getID(::Legends.Active.LegendThrowKnife),
	]);
});
