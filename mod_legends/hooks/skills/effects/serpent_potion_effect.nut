::mods_hookExactClass("skills/effects/serpent_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+3%[/color] chance to hit in melee for every ally surrounding the target";
	}
});
