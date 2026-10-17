::mods_hookExactClass("skills/effects/iron_will_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Not affected by non-permanent injuries";
	}
});
