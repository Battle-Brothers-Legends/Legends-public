::mods_hookExactClass("skills/injury/sickness_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon(["health", "fatigue", "melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "bravery"]) + ", [color=%negative%]-2[/color] " + ::Legends.S.inlineIcon("vision");
	}
});
