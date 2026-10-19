::mods_hookExactClass("skills/injury/burnt_legs_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-20%[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%positive%]+1[/color] " + ::Legends.S.inlineIcon("action_points") + " per tile moved";
	}
});
