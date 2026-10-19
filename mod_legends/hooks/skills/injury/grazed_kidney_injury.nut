::mods_hookExactClass("skills/injury/grazed_kidney_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-60%[/color] " + ::Legends.S.inlineIcon("health");
	}
});
