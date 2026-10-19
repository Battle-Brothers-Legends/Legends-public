::mods_hookExactClass("skills/injury/split_hand_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill"]);
	}
});
