::mods_hookExactClass("skills/effects/alp_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Not affected by nighttime penalties";
	}
});
