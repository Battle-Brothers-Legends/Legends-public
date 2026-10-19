::mods_hookExactClass("skills/effects_world/exhausted_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon("fatigue");
	}
});
