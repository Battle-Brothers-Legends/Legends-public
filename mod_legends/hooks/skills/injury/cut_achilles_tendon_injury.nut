::mods_hookExactClass("skills/injury/cut_achilles_tendon_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-30%[/color] " + ::Legends.Text.inlineIcons("initiative") + ", [color=%positive%]+2[/color] " + ::Legends.Text.inlineIcons("action_points") + " per tile moved";
	}
});
