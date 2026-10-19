::mods_hookExactClass("skills/injury_permanent/missing_finger_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-5%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill"]);
	}
});
