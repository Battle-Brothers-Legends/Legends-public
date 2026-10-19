::mods_hookExactClass("skills/injury/cut_arm_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-15%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill"]);
	}
});
