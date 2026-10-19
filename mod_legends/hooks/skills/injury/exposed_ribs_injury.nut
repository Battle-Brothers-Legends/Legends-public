::mods_hookExactClass("skills/injury/exposed_ribs_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-35%[/color] " + ::Legends.S.inlineIcon("health");
	}
});
