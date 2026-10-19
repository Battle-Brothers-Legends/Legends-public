::mods_hookExactClass("skills/injury_permanent/broken_knee_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense", "initiative"]);
	}
});
