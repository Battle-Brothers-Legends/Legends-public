::mods_hookExactClass("skills/effects/night_vision_effect", function (o) {
	o.getDescription <- function () {
		return "Whether due to magic or an alchemical marvel the night appears as bright as day for %them%.";
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		"Not affected by nighttime penalties";
	}
});
