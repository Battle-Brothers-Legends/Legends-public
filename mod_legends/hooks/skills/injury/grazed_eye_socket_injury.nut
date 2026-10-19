::mods_hookExactClass("skills/injury/grazed_eye_socket_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("ranged_skill") + ", [color=%negative%]-2[/color] " + ::Legends.S.inlineIcon("vision");
	}
});
