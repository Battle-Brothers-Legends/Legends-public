::mods_hookExactClass("skills/effects/horrified_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Unable to act";
	}
});
