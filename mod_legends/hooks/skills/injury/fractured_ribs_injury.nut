::mods_hookExactClass("skills/injury/fractured_ribs_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-30%[/color] " + ::Legends.S.inlineIcon("fatigue");
	}
});
