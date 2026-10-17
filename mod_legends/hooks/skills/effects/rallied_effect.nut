::mods_hookExactClass("skills/effects/rallied_effect", function (o) {
	o.m.TurnsLeft <- 1;

	o.getDescription <- function () {
		return "Rallied to gather all %their% strength and keep on going by an inspirational leader.";
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Already rallied this turn";
	}
});
