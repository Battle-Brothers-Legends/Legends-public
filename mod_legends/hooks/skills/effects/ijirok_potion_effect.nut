::mods_hookExactClass("skills/effects/ijirok_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]50%[/color] chance to resist status effects";
	}
});
