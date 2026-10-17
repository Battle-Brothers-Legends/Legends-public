::mods_hookExactClass("skills/effects/webknecht_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Poison";
	}
});
