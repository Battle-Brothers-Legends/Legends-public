::mods_hookExactClass("skills/injury/burnt_face_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense"]) + "[color=%negative%]-2[/color] " + ::Legends.S.inlineIcon("vision");
	}
});
