::mods_hookExactClass("skills/injury/broken_nose_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-5[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_down");
	}
});
