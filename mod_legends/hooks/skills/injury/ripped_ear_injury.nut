::mods_hookExactClass("skills/injury/ripped_ear_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-15%[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
