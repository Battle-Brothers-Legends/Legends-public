::mods_hookExactClass("skills/injury/stabbed_guts_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon(["health", "fatigue"]);
	}
});
