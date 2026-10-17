::mods_hookExactClass("skills/effects/kraken_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+50[/color] " + ::Legends.S.inlineIcon("health");
	}
});
