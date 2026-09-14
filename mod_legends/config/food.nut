if (!("Food" in ::Legends))
	::Legends.Food <- {};

::Legends.Food.TipsyEffects <- [
	::Legends.Effect.LegendBeerBuzzEffect,
	::Legends.Effect.LegendWineTipsyEffect,
	::Legends.Effect.LegendMeadWarmthEffect,
	::Legends.Effect.LegendLiquorBurnEffect,
];

::Legends.Food.isTipsy <- function (_actor) {
	local container = _actor.getSkills();
	foreach (effect in ::Legends.Food.TipsyEffects)
		if (container.hasEffect(effect))
			return true;
	return false;
}
