::mods_hookExactClass("skills/injury_permanent/weakened_heart_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-30%[/color] " + ::Legends.S.inlineIcon("health");
	}
});
