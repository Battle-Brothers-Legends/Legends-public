::mods_hookExactClass("skills/effects/ancient_priest_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Cannot be reduced below Breaking morale";
	}
});
