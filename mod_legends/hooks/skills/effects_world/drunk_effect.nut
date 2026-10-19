::mods_hookExactClass("skills/effects_world/drunk_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative"]) + ", [color=%positive%]+25%[/color] " + ::Legends.S.inlineIcon("bravery");
	}
});
