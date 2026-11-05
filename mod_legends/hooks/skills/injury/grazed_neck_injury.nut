::mods_hookExactClass("skills/injury/grazed_neck_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-15%[/color] " + ::Legends.Text.inlineIcons("health") + ", [color=%negative%]1[/color] " + ::Legends.Text.inlineIcons("damage_received") + " every turn";
	}
});
