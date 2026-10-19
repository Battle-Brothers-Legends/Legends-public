::mods_hookExactClass("skills/injury/fractured_skull_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative"]) + ", [color=%negative%]-2[/color] " + ::Legends.S.inlineIcon("vision");
	}
});
