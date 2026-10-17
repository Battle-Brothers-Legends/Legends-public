::mods_hookExactClass("skills/effects/rachegeist_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+25%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + " and [color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon("damage_received") + " if " + ::Legends.S.inlineIcon("health") + " is below [color=%negative%]50%[/color]";
	}
});
