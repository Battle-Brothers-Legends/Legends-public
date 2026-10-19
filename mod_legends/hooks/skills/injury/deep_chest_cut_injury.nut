::mods_hookExactClass("skills/injury/deep_chest_cut_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-35%[/color] " + ::Legends.S.inlineIcon(["health", "fatigue", "melee_skill", "ranged_skill"]);
	}
});
