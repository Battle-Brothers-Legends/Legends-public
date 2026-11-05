::mods_hookExactClass("skills/injury/pierced_side_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-20%[/color] " + ::Legends.Text.inlineIcons("fatigue");
	}
});
