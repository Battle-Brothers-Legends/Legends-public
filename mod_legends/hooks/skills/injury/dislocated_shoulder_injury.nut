::mods_hookExactClass("skills/injury/dislocated_shoulder_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-3[/color] " + ::Legends.S.inlineIcon("action_points");
	}
});
