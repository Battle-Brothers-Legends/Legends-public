::mods_hookExactClass("skills/injury/fractured_hand_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-20%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill"]);
	}
});
