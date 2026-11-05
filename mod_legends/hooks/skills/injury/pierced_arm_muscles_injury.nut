::mods_hookExactClass("skills/injury/pierced_arm_muscles_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.Text.inlineIcons(["melee_skill", "ranged_skill"]);
	}
});
