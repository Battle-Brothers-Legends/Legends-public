if (!("Food" in ::Legends))
	::Legends.Food <- {};

::Legends.Food.TipsyEffect <- [
	"effects.legend_beer_buzz_effect",
	"effects.legend_wine_tipsy_effect",
	"effects.legend_mead_warmth_effect",
	"effects.legend_liquor_burn_effect",
]

::Legends.Food.isTipsy <- function (_actor) {
	local container = _actor.getSkills();
	foreach (effect in ::Legends.Food.TipsyEffect)
		if (container.hasSkill(effect))
			return true;
	return false;
}
