::mods_hookExactClass("skills/injury/bruised_leg_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-20%[/color] " + ::Legends.Text.inlineIcons("initiative") + ", [color=%positive%]+1[/color] " + ::Legends.Text.inlineIcons("action_points") + " per tile moved";
	}
});
