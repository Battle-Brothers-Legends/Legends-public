::mods_hookExactClass("skills/injury/pierced_cheek_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-3[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_down");
	}
});
