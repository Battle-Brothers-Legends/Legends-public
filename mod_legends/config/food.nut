if (!("Food" in ::Legends)) {
	::Legends.Food <- {};
}

::Legends.Food.TipsyEffects <- [
	::Legends.Effect.LegendBeerBuzz,
	::Legends.Effect.LegendWineTipsy,
	::Legends.Effect.LegendMeadWarmth,
	::Legends.Effect.LegendLiquorBurn,
];

::Legends.Food.isTipsy <- function (_actor) {
	local container = _actor.getSkills();
	foreach (effect in ::Legends.Food.TipsyEffects) if (container.hasEffect(effect)) {
		return true;
	}
	return false;
}
