::mods_hookExactClass("skills/effects/adrenaline_effect", function (o) {
	o.getDescription = function () {
		return "Go, go, go! This character has an adrenaline rush and will act again before %their% opponents come next round.";
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Acts much faster next turn";
	}
});
