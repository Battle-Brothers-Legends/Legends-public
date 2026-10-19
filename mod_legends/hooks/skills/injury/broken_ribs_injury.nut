::mods_hookExactClass("skills/injury/broken_ribs_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon("fatigue");
	}
});
