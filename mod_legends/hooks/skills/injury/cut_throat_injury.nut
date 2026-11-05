::mods_hookExactClass("skills/injury/cut_throat_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.Text.inlineIcons("health") + ", [color=%negative%]6[/color] " + ::Legends.Text.inlineIcons("damage_received") + " every turn";
	}
});
