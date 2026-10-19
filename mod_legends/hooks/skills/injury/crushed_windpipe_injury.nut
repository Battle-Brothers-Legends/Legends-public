::mods_hookExactClass("skills/injury/crushed_windpipe_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("fatigue") + ", [color=%negative%]-10[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_down");
	}
});
