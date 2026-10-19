::mods_hookExactClass("skills/injury/cut_throat_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("health") + ", [color=%negative%]6[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
