::mods_hookExactClass("skills/effects/gruesome_feast_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Grown bigger and more dangerous";
	}
});
