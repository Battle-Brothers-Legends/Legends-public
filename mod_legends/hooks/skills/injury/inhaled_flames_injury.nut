::mods_hookExactClass("skills/injury/inhaled_flames_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon("fatigue") + ", [color=%negative%]-2[/color] " + ::Legends.S.inlineIcon("action_points");
	}
});
