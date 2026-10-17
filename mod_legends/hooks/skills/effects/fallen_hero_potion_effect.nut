::mods_hookExactClass("skills/effects/fallen_hero_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Accumulates no from " + ::Legends.S.inlineIcon("fatigue") + " enemy attacks";
	}
});
