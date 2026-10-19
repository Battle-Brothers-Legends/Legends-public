::mods_hookExactClass("skills/injury/injured_shoulder_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
