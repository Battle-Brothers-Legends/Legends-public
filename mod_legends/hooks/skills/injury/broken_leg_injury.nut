::mods_hookExactClass("skills/injury/broken_leg_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%positive%]+2[/color] " + ::Legends.S.inlineIcon("action_points") + " per tile moved";
	}
});
