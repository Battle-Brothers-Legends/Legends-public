::mods_hookExactClass("skills/effects/apotheosis_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+1[/color] " + ::Legends.S.inlineIcon(["health", "fatigue"]);
	}
});
