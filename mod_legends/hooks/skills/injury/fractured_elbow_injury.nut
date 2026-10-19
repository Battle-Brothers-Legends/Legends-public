::mods_hookExactClass("skills/injury/fractured_elbow_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon("melee_defense");
	}
});
