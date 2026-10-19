::mods_hookExactClass("skills/injury/grazed_neck_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-15%[/color] " + ::Legends.S.inlineIcon("health") + ", [color=%negative%]1[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
