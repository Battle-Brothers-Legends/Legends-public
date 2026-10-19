::mods_hookExactClass("skills/injury/cut_achilles_tendon_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-30%[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%positive%]+2[/color] " + ::Legends.S.inlineIcon("action_points") + " per tile moved";
	}
});
