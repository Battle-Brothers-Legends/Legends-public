::mods_hookExactClass("skills/injury/split_shoulder_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
