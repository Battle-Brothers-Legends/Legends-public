::mods_hookExactClass("skills/injury/cut_leg_muscles_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.S.inlineIcon(["melee_defense", "initiative"]);
	}
});
